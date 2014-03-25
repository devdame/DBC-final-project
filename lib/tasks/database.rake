require 'httparty'
require 'json'
require 'find'
require './db/alchemyapi.rb'
require 'fileutils'

  namespace :db do

    desc "This is what to run when setting up a completely new database."
      task :setup_from_empty => :environment do
        raise "Databases must be empty!" unless AnalyzedPost.all.empty? && OriginalPost.all.empty? && Keyword.all.empty? && School.all.empty? && Topic.all.empty? && Rating.all.empty? && ReferenceWord.all.empty?
        make_topics_and_schools
        populate_tables_from_csv
        json_to_alchemy_to_tables_and_csv
        increment_school_word_counts
        increment_school_ratings
        create_or_update_school_word_counts
        wipe_temporary_tables
        delete_all_files_in_seeds_directory
      end

    desc "This is what to run if you already have a db and want to update your final tables with the geofeedia files in your seeds folder. DELETE FILES AFTERWARD."
      task :json_to_alchemy_to_tables_and_csv => :environment do
        check_setup_for_updating_csv
        json_to_alchemy_to_tables_and_csv
        increment_school_word_counts
        increment_school_ratings
        create_or_update_school_word_counts
        wipe_temporary_tables
        delete_all_files_in_seeds_directory
      end

    desc "Create topics and schools for empty db"
      task :seed_schools_and_topics => :environment do
        raise "Topics, reference words and schools must be empty!" unless Topic.all.empty? && School.all.empty? && ReferenceWord.all.empty?
        make_topics_and_schools
      end

    desc "Overwrite topics and schools (deletes what's already in there and repopulates it from rake file)"
      task :overwrite_schools_and_topics => :environment do
        Topic.delete_all
        ReferenceWord.delete_all
        School.delete_all
        Rating.delete_all
        SchoolWordCount.delete_all
        make_topics_and_schools
      end

    desc "Import rows from CSV into empty database (keywords and analyzed posts)--only to be called when initializing db!!!! Never again!!!"
      task :populate_tables_from_csv => :environment do
        raise "Temporary databases must be empty, and you must have already made schools!" unless AnalyzedPost.all.empty? && OriginalPost.all.empty? && Keyword.all.empty? && School.all.any?
        check_for_previously_seeded_data
        populate_tables_from_csv
        wipe_temporary_tables
      end

    desc "Import rows from CSV  *AND*  send any json files in seeds folder to geofeedia and back to analyzed posts and keywords, from empty (but already created and migrated) database and wipe tables when done"
      task :import_csv_get_json_wipe_tables => :environment do
        check_for_previously_seeded_data
        setup_from_empty
        wipe_temporary_tables
      end

# Don't use this one unless you know what you're doing!
    # desc "Import rows from CSV  *AND*  send any json files in seeds folder to geofeedia and back to analyzed posts and keywords, from empty (but already created and migrated) database"
    # task :import_csv_get_json_keep_tables => :environment do
    #   setup_from_empty
    # end

    # desc "Send any json files in seeds folder to alchemy and update csv accordingly, then wipe temporary tables"
    #   task :json_to_alchemy_to_tables_and_csv_wipe_tables => :environment do
    #     check_setup_for_updating_csv
    #     json_to_alchemy_to_tables_and_csv
    #     increment_school_word_counts
    #     increment_school_ratings
    #     create_or_update_school_word_counts
    #     wipe_temporary_tables
    #     delete_all_files_in_seeds_directory
    #   end

      task :blah => :environment do
        Keyword.populate_reference_words
        Keyword.create_or_update_school_word_counts
      end

# Don't use this one unless you know what you're doing!
    # desc "Send any json files in seeds folder to alchemy and update csv accordingly BUT DON'T wipe tables when done"
    # task :json_to_alchemy_to_tables_and_csv_keep_tables => :environment do
      # check_setup_for_updating_csv
      # json_to_alchemy_to_tables_and_csv
      # increment_school_word_counts
      # increment_school_ratings
      # create_or_update_school_word_counts
      # delete_all_files_in_seeds_directory
    # end

    desc "Wipe the temporary tables (keywords and analyzed posts)"
      task :wipe_temporary_tables => :environment do
        wipe_temporary_tables
      end

    desc "Grabs data from geofeedia and stores in json files. Uncomment the schools that you want to grab from."
      task :create_json_from_geofeedia => :environment do
        make_call_to_geofeedia_and_save_json({"32204" => "asu",
          "32211" => "uta",
          # "32244" => "uga",
          "32207" => "msu",
          "32206" => "uofm"#,
          # "32202" => "uofi",
          # "32251" => "uwm",
          # "32243" => "uws",
          # "32241" => "ucd",
          # "32210" => "cor"
          })
      end

    desc "Updates final tables with whatever data is in keywords and analyzed posts"
      task :update_final_tables_from_temporary_tables => :environment do
        raise "Tables must be properly populated before this task is run!" unless AnalyzedPost.any? && Keyword.any? && School.any? && Topic.any? && ReferenceWord.any? && Rating.any?
        increment_school_word_counts
        increment_school_ratings
        create_or_update_school_word_counts
        # wipe_temporary_tables
      end
  end


###############################################################################################################################################################
##################################################### METHODS ##############################################################################################
###############################################################################################################################################################


def setup_from_empty
  raise "Databases must be empty!" unless AnalyzedPost.all.empty? && OriginalPost.all.empty? && Keyword.all.empty? && School.all.empty? && Topic.all.empty? && Rating.all.empty? && ReferenceWord.all.empty?
  make_topics_and_schools
  populate_tables_from_csv
  ["analyzed_posts", "original_posts", "reference_words", "topics", "keywords", "schools"].each do |table|
    result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
    if result.any?
      ai_val = result.first['id'].to_i + 1
      puts "Resetting auto increment ID for #{table} to #{ai_val}"
      ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
    end
  end
  json_to_alchemy_to_tables_and_csv if Dir['db/seeds/*'].any?
end

def check_for_previously_seeded_data
  School.all.each do |school|
    if school.post_count > 0
      raise "Looks like you already have data in your school models from another pull.  You shouldn't run this if you already have data!"
    end
  end
end

#####################################################


def populate_tables_from_csv
  post_csv = CSV.read('db/analyzed_posts.csv', :headers => true)
  post_csv.each do |post|
    AnalyzedPost.create(post.to_hash)
  end
  keyword_csv = CSV.read('db/keywords.csv', :headers => true)
  keyword_csv.each do |post|
    Keyword.create(post.to_hash)
  end
end


#####################################################


def check_setup_for_updating_csv
  raise "Temporary tables should be empty if you're doing this!" if AnalyzedPost.all.any? || Keyword.all.any? || OriginalPost.all.any?
  raise "Either your school, topic, or reference word table is empty." if School.all.empty? || Topic.all.empty? || ReferenceWord.all.empty?
end


def json_to_alchemy_to_tables_and_csv
  new_posts = []
  original_post_seeding(new_posts)
  update_ids_for_posts_and_keywords

  new_analyzed_posts = []
  new_analyzed_keywords = []
  get_alchemy_responses(new_analyzed_posts, new_analyzed_keywords, new_posts)

  write_to_csv_files(new_analyzed_posts, new_analyzed_keywords)
end


#####################################################


def original_post_seeding(new_posts)
  Dir['db/seeds/*'].each do |filename|
    json = File.read(filename)
    feed_id = filename.gsub(/\D+(\d+)[a-z].+/i, '\1')
    school = School.find_by_geofeedia_id(feed_id)
    parsed = JSON.parse(json)
    batch = []

    if school.original_posts.empty?
      create_original_posts(parsed["items"], batch, feed_id, school)
      school.first_post_time = batch.sort_by{|post| post.original_publish_time}.first.original_publish_time
    else
      create_original_posts(parsed["items"], batch, feed_id, school)
    end

    log_batch_to_new_posts(batch, new_posts)
  end
end


def create_original_posts(parsed_items, batch, feed_id, school)
  parsed_items.each do |item|
    post = OriginalPost.new(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school.id, external_id: item["externalId"])
    if post.save
      batch << post
    else
      puts "original post didn't pass validations:"
      puts post.inspect
    end
  end
end


def log_batch_to_new_posts(batch, new_posts)
  batch.each do |post|
    new_posts << post
  end
end


def delete_all_files_in_seeds_directory
  Dir['db/seeds/*'].each do |file|
    FileUtils.rm(file)
  end
end


#####################################################


def update_ids_for_posts_and_keywords
  new_first_post_id = CSV.read('db/analyzed_posts.csv').last[0].to_i + 1
  new_first_keyword_id = CSV.read('db/keywords.csv').last[0].to_i + 1
  puts "Resetting auto increment ID for analyzed posts to #{new_first_post_id}"
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE analyzed_posts_id_seq RESTART WITH #{new_first_post_id}")
  puts "Resetting auto increment ID for keywords to #{new_first_keyword_id}"
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE keywords_id_seq RESTART WITH #{new_first_keyword_id}")
end


#####################################################


def get_alchemy_responses(new_analyzed_posts, new_analyzed_keywords, new_posts)
  puts "in the alchemy call now"
  alchemyapi = AlchemyAPI.new()
  new_posts.each do |post|
    alchemy_post_response = alchemyapi.sentiment('text', post.text)
    overall_sentiment = get_overall_sentiment(alchemy_post_response)
    new_post = AnalyzedPost.new(school_id: post.school_id, original_publish_time: post.original_publish_time, overall_sentiment: overall_sentiment)
    if new_post.save
      new_analyzed_posts << new_post

      alchemy_keywords_response = alchemyapi.keywords('text', post.text, options = {"sentiment" => 1})
      alchemy_keywords_response["keywords"].each do |keyword|
        analysis = analyze_sentiment(keyword)
        new_keyword = Keyword.new(text: keyword["text"], sentiment: analysis[:sentiment], confidence: analysis[:confidence], analyzed_post_id: new_post.id)
        if new_keyword.save
          new_analyzed_keywords << new_keyword
        else
          puts "keyword didn't pass validations:"
          puts new_keyword.inspect
        end
      end
    else
      puts "analyzed post didn't pass validations"
    end
  end
end


def get_overall_sentiment(alchemy_post_response)
    if alchemy_post_response["docSentiment"]
      alchemy_post_response["docSentiment"]["type"]
    else
      "neutral"
    end
end


def analyze_sentiment(keyword)
  if keyword["sentiment"]
    {sentiment: keyword["sentiment"]["type"], confidence: keyword["sentiment"]["score"]}
  else
    {sentiment: "neutral", confidence: 0.0}
  end
end


def write_to_csv_files(new_analyzed_posts, new_analyzed_keywords)
  CSV.open('db/analyzed_posts.csv', 'a') do |csv|
    new_analyzed_posts.each do |post|
      csv << post.attributes.values
    end
  end
  CSV.open('db/keywords.csv', 'a') do |csv|
    new_analyzed_keywords.each do |keyword|
      csv << keyword.attributes.values
    end
  end
end


#####################################################


def wipe_temporary_tables
  OriginalPost.delete_all
  AnalyzedPost.delete_all
  Keyword.delete_all
end


#####################################################


def make_call_to_geofeedia_and_save_json(school_plus_abbreviation_hash)
  # schools_and_calls = {"32204" => "asu",
  #   "32211" => "uta"
  #   }
  school_plus_abbreviation_hash.each do |geofeedia_id, school_abbreviation|
    most_recent_post_time = nil
    url = "https://api.geofeedia.com/v1/search/geofeed/#{geofeedia_id}?format=json-default&appId=420880de&appKey=#REMEMBER TO ADD ME BACK"
    4.times do
      response = HTTParty.get(url)
        if most_recent_post_time == nil
          most_recent_post_time = response.parsed_response["items"][0]["publishDate"]
        end
      posts = response.parsed_response
      url = response.parsed_response["result"]["nextPage"]["url"]
      timestamp = Time.now.to_s.gsub(/\s|(:)/, '')
      # p geofeedia_id
      # p most_recent_post_time
      # p response.parsed_response["items"].count
      create_local_json_files(geofeedia_id, school_abbreviation, timestamp, posts)
    end
    update_most_recent_post_time(geofeedia_id, most_recent_post_time)
    sleep 40
  end
end


def create_local_json_files(geofeedia_id, school_abbreviation, timestamp, posts)
  FileUtils.touch("db/seeds/#{geofeedia_id}#{school_abbreviation}_#{timestamp}.json")
  File.open("db/seeds/#{geofeedia_id}#{school_abbreviation}_#{timestamp}.json","w") do |file|
    file.write(posts.to_json)
  end
end


def update_most_recent_post_time(geofeedia_id, most_recent_post_time)
  school_to_be_updated = School.find_by_geofeedia_id(geofeedia_id)
  school_to_be_updated.update_attributes(most_recent_post_time: most_recent_post_time)
end


##########################################


def increment_school_word_counts
  AnalyzedPost.populate_reference_words
  AnalyzedPost.increment_school_word_count
end


def increment_school_ratings
  AnalyzedPost.increment_school_ratings
end


def create_or_update_school_word_counts
  Keyword.populate_reference_words
  Keyword.create_or_update_school_word_counts
end


#####################################


def make_topics_and_schools

  topics = ["food", "tech", "nerd_culture", "art", "sports", "partying", "academics", "romance", "music", "lgbt", "fitness", "social life", "career", "finance", "gender", "housing", "politics", "religion", "fashion"]
  topics.each do |topic|
    Topic.where(name: topic).first_or_create
  end

  nerd_culture = ["nerd", "geek", "nerds", "geeks", "xbox", "ps4", "ps3", "super nintendo", "nintendo", "wii", "nintendo wii", "n64", "miyazaki", "totoro", "spirited away", "cat bus", "howl's moving castle", "princess mononoke", "ponyo", "lego", "legos", "lego movie", "mini fig", "mini figs", "lego mania", "pottermania", "muppets", "the mary sue", "io9", "spec fic", "anime", "cowboy bebop", "fanfic", "fanfiction", "fan-fic", "fan-fiction", "fangirl", "fangirling", "geeking out", "geek out", "geeked out", "speculative fiction", "manga", "gameboy", "playstation", "league", "the guild", "armor", "chain mail", "ren faire", "ren fest", "renaissance faire", "renaissance fair", "ren fair", "wand", "critical hit", "critical fail", "critical failure", "nat 20", "natural 20", "nat 1", "natural 1", "natural twenty", "nat twenty", "natural one", "nat one", "roll a critical", "roll a nat 20", "roll for initiative", "charisma score", "intelligence score", "wisdom score", "strength score", "constitution score", "dexterity score", "character sheet", "d&d session", "d&d game", "bioshock", "bioshock infinite", "wii", "minecraft", "lolcats", "lolcat", "doge", "bitcoin", "dogecoin", "japanophile", "doctor who", "dr who", "dr. who", "dalek", "cyberman", "cybermen", "daleks", "whovian", "matt smith", "david tennant", "nerd rage", "liz lemon", "30 rock", "peter capaldi", "capaldi", "firefly", "whedon", "joss whedon", "buffy", "btvs", "scifi", "anime", "reddit", "star wars", "star trek", "trekkie", "trekkies", "trekker", "trekkers", "meme", "nerdcore", "nerdfighter", "nerdfighters", "nerdfighteria", "cosplay", "dungeons and dragons", "dungeons & dragons", "d&d", "d20", "20 sided die", "dice set", "set of dice", "twenty sided die", "d10", "d12", "d8", "d4", "rpg", "role playing game", "tabletop", "tabletop game", "settlers of catan", "catan", "board games", "board game", "munchkin", "four chan", "4chan", "comics", "marvel", "dc comics", "orphan black", "agents of shield", "agents of s.h.i.e.l.d.", "pi", "magic", "magic the gathering", "magic cards", "miniatures", "battle mat", "battle board", "world of warcraft", "w.o.w.", "newb", "noob", "n00b", "pwn", "pwned", "night cheese", "adventure time", "finn and jake", "lsp", "lumpy space princess", "princess bubblegum", "marceline", "the ice king", "amy pond", "tardis", "the tardis", "sonic screwdriver", "tribbles", "george takei", "takei", "sulu", "captain kirk", "janeway", "picard", "captain picard", "jean luc picard", "captain janeway", "spock", "big bang" "the big bang", "the big bang theory", "fake geek girl", "fake geek girls", "geek girl", "geek girls", "think geek", "futurama", "scifi", "sci-fi", "syfy", "game of thrones", "winter is coming", "westeros", "the cones of dunshire", "cones of dunshire", "leslie knope", "ben wyatt", "torchwood", "jack harkness", "river song", "face of bo", "geronimo", "the girl who waited", "harry potter", "the boy who lived", "voldemort", "rowling", "hermione granger", "ron weasley", "snape", "severus snape", "marvel vs dc", "dc vs marvel", "mischief managed", "time travel", "space time", "spacetime", "space time continuum", "the verse", "buffy", "buffy the vampire slayer", "dragons"]
  nerd_culture.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("nerd_culture")).first_or_create
  end

  partying = ["king cobra", "schwasted", "schwasty", "40 oz", "40s", "forties", "fourtys", "shenanigans", "fotie", "foties", "rally", "boones farm", "boone's farm", "mad dog", "drunk life", "high life", "franzia", "box wine", "boxed wine", "chillable red", "liquor store", "party hard", "party hardy", "get shitty", 'St Patty', "St. Patty's", "fancy drinks", "struggle bus", "circle of death", "kings cup", "king's cup", "darts", "taco bell", "saturday night", "friday night", "tgif", "beer porn", "beer snob", "beergasm", "beerstagram", "craft beer", "hangover", "hung over", "so hung over", "hung over as shit", "huge hangover", "party on", "hookah", "hookah bar", "jack daniels", "jim beam", "jameson", "captain morgan", "moonshine", "smirnoff", "absolut", "312", "goose island", "whiskey sour", "gin and tonic", "whiskey coke", "whiskey and diet", "whisky", "absinthe", "ouzo", "jager bomb", "sake", "sake bomb", "sake bombs", "jager bombs", "corona", "heineken", "dos equis", "bud light", "coors light", "miller light", "coors", "sauza", "jose cuervo", "el jimador", "russian standard", "svedka", "patron", "hennessy", "dom perignon", "champagne", "champagne of beers", "don julio", "beefeater", "seagrams", "malort", "bitters", "bombay gin", "tanqueray", "coconut rum", "baileys", "baileys irish cream", "grey goose", "gray goose", "ketel one", "belvedere", "stolichnaya", "uv blue", "lush", "alkie", "alcoholic", "booze hound", "Saturday", "Friday", "tailgate", "pregame", "pre-game", "pregaming", "pre-gaming", "after bar", "after-bar", "a-bar", "cut loose", "get down", "party down", "hotbox", "smokeout", "reefer", "rave", "raver", "orgy", "blunt", "after hours", "spliff", "joint", "walk of shame", "sex cult", "vermouth", "alcohol delivery", "boozahol", "boozaholic", "booze", "margaritas", "martini", "martinis", "margarita", "margs", "tailgaiting", "stoner", "spring break", "tgif", "freakin weekend", "stoner mindset", "bottle",  "drinks", "unlimited ass", "beer", "alcohol", "shots", "rage", "ragin", "ragin'", "vape", "vaporizer", "codeine", "morphine", "vicodin", "hydrocodone", "oxycontin", "oxy cotton", "hopped up", "nugs", "dank weed", "good weed", "chronic", "dank nugs", "tripping", "hallucinating", "ball so hard", "dope", "karaoke", "head shop", "dat ass", "raging", "rager", "get down", "hammered", "spring break", "springbreak", "collegelife", "blacked out", "drugs", "drink", "smoke", "wasted", "shitfaced", "shit faced", "shithoused", "browned out", "blasted", "tipsy", "drunk", "drank", "blotto", "smokin", "kush", "dank", "pot", "weed", "blazed", "blazing", "party", "partying", "cig", "cigarettes", "acid", "lsd", "mdma", "ecstasy", "blackout", "black out", "wine", "liquor", "whiskey", "rum", "gin", "vodka", "tequila", "rumpleminze", "goldschlager", "kahlua", "jager", "jagermeister", "budweiser", "leinenkugels", "leinies", "pbr", "pabst", "pabst blue ribbon", "miller high life", "mgd", "blatts", "hamms", "porter", "stout", "ipa", "amber ale", "red ale", "beer pong", "frat", "greek", "sorority", "club", "420", "4:20", "four twenty", "so high", "get high", "get blazed", "get drunk", "get shitty", "get shitfaced", "get wasted", "get blackout", "blackout drunk", "bath salts", "busch", "schlitz", "keystone", "30 rack", "thirty rack", "rolling rock", "steel reserve", "house party", "hookah", "hooka", "ritalin", "adderall", "shinerbock", "coors", "cocktail", "kings cup", "king's cup", "circle of death"]
  partying.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("partying")).first_or_create
  end

  academics = ["study", "test", "class", "school", "essay", "essays", "final paper", "classes", "schools", "colleges", "academics", "courses", "tests", "lab", "lab report", "panelist", "panelists", "ta", "teachers assistant", "teaching assistant", "lab reports", "discussion group", "quiz", "quizzes", "quizes", "pop quiz", "classroom", "college bound", "go study", "all-nighter", "all nighter", "pull an all nighter", "pull an all-nighter", "hard test", "easy test", "hard class", "easy class", "easy a", "drop out", "drop-out", "college", "academic", "ace", "grade", "studying", "professor", "guest speaker", "study break", "prof", "homework", "hw", "philosophy", "statistics", "botany", "degree", "office hours", "students", "student", "anthropology", "physics", "biology", "neuroscience", "neuro", "microbiology", "teacher", "grad school", "graduate school", "graduate", "grad student", "graduate student", "graduate studies", "grad students", "graduate students", "undergrads", "upperclassmen", "upperclassman", "underclassmen", "underclassman", "freshman", "sophomore", "junior", "senior", "college freshmen", "college freshman", "freshmen", "sophomores", "juniors", "seniors", "freshman year", "senior year", "graduation", "college graduation", "university", "study hall", "engineering", "productive", "science", "scholar", "scholarship", "brain", "liberal arts", "humanities", "english", "history", "women's studies", "creative writing", "essay", "paper", "midterm", "final", "chem", "chemistry", "allnighter", "all nighter", "internship", "grad", "grad school", "semester", "quarter", "trimester", "term", "terms", "semesters", "quarters", "trimesters", "econ", "study guide", "grades", "studybreak", "lab", "laboratory", "calc", "calculus", "trig", "trigonometry", "algebra", "thesis", "advisor", "dissertation", "seminar", "report", "lab report", "admissions", "prereqs", "prerequisites", "gen eds", "general education", "education", "GRE", "LSAT", "project", "MCAT", "academics", "academic", "academy", "library", "math", "computer science", "comp sci", "j-term"]
  academics.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("academics")).first_or_create
  end

  lgbt = ["lgbt", "gay", "boi", "bois", "lesbian", "bisexual", "bi", "trans", "transgender", "drag queen", "drag queens", "you better work", "you betta work", "pansexual", "queer", "genderqueer", "gender queer", "gender", "asexual", "post-op", "post op", "pride parade", "gay pride", "homosexual", "butch", "femme", "fag", "fags", "faggot", "faggots", "homo", "homos", "dyke", "boystown", "hunty", "throw shade", "rainbow", "drag ball", "rupaul", "rupauls drag race", "rupaul's drag race", "sharon needles", "raja", "michelle visage", "willam", "jinkx monsoon", "courtney act", "chad michaels", "latrice royale", "jiggly caliente", "pandora boxxx", "jujubee", "lgbt", "gsa", "homophobe", "homophobic",  "manila luzon", "nina flowers", "shangela", "jessica wild", "tyra sanchez", "yara sofia", "alyssa edwards", "bianca del rio", "laganja estranja", "harvey milk", "you betta work", "halleloo", "drag ball", "gay rights", "lgbt rights", "gay marriage", "right to marriage", "gay boy", "gay girl", "gay guy"]
  lgbt.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("lgbt")).first_or_create
  end

  career = ["career", "business", "management", "marketing", "job", "work", "workplace", "office", "overtime", "work week", "networking", "worknight", "work night", "shift", "interview", "work blows", "shitty job", "hate my job", "bullshit job", "apprentice", "apprenticeship", "intern", "internship", "manager", "regional manager", "my manager", "my boss", "new job", "old job", "better job", "promotion", "get a raise", "need a raise", "working overtime", "get a promotion", "ceo", "cto", "company president", "intern", "internship", "paid intern", "unpaid intern", "interns", "internships",  "paid internship", "unpaid internship", "interview", "job interview", "group interview", "resume", "job application", "cv", "coworker", "coworkers", "my coworker", "my coworkers", "co-worker", "co-workers", "hr", "human resources", "at my job", "at work", "at my work"]
  career.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("career")).first_or_create
  end

  romance = ["romance", "hookup", "hook up", "husband and wife", "power couple", "slurty", "flirty", "main squeeze", "wedding", "weddings", "propose", "proposed", "engaged", "engagement", "got engaged", "get engaged", "married", "get married", "have kids", "procreate", "hooked up", "had sex", "have sex", "good lay", "got laid", "get laid", "vibrator", "dildo", "sex toy", "condom", "pussy", "turned on", "horny", "lover", "lovers", "break up", "broke up", "breaking up", "dumped", "contraceptives", "contraceptive", "iud", "good boyfriend", "good girlfriend", "awesome boyfriend", "awesome girlfriend", "love", "adore", "in love", "so in love", "smitten", "boy crush", "girl crush", "sex", "crush", "flowers", "date", "date night", "dinner date", "girlfriend", "boyfriend", "wife", "husband", "marriage", "significant other", "s. o.", "s.o.", "spouse"]
  romance.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("romance")).first_or_create
  end

  fitness = ["fitness", "protein", "workout", "p90x", "gym", "swole", "swoll", "swol", "do you even lift", "parkour", "bodyweight", "bmi", "swoll", "diet", "dieting", "weight", "marathon", "half marathon", "bike", "bicycle", "bicyclist", "bike ride", "ride my bike", "half-marathon", "running", "triathalon", "5k", "five k", "cycling", "jog", "jogging", "body mass index", "body mass", "body weight", "lose weight", "lost weight", "skinny", "thin", "fat", "obese", "diet", "paleo", "weight watchers", "pounds", "snowboard", "bike", "biking", "hiking", "ski", "yoga", "hatha yoga", "hatha"]
  fitness.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("fitness")).first_or_create
  end

  finance = ["finance", "finances", "destitute", "financial needs", "financial aid", "wallet", "out of pocket", "savings", "checking", "my savings", "dipping into my savings", "save money", "coupon", "coupons", "coupon queen", "welfare", "food stamps", "unemploment check", "utilities", "utility bills", "gas bill", "electric bill", "heating bill", "cable bill", "internet bill", "broke", "cheap", "expensive", "money", "bills", "credit", "credit card", "charge it", "debit card", "student loan", "student loans", "payment", "payments", "loan payments", "student debt", "debt", "financial aid", "loan", "bank account", "bank", "dolla dolla billz", "dolla dolla bills", "moolah", "dollaz", "dollars", "hundo", "pricey", "too expensive", "so cheap", "way too expensive", "out of money", "get paid", "get my paycheck", "got my paycheck", "got paid" ]
  finance.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("finance")).first_or_create
  end

  housing = ["housing", "rent", "lease", "dorm", "apartment", "house", "apartment search", "apartment hunt", "domu", "renting", "my lease", "signed my lease", "sign my lease", "cosign", "apartment application", "rental application"]
  housing.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("housing")).first_or_create
  end

  gender = ["gender", "women", "men", "female", "sexual harrassment", "princess", "sexual assault", "rape", "sexually harrassed", "sexually assaulted", "raped", "victim blaming", "slut shaming", "slut shame", "bitch", "bitches", "sluts", "whores", "cunts", "sexxx", "submissive", "jezebel", "the hairpin", "feminist news", "feminist magazine", "feminist blog", "feminist website", "feminist", "feminazi", "slut", "slutty", "ho", "flasher", "flashed", "cat-call", "cat-called", "cat called", "cat call", "catcall", "catcalled", "twat", "sex positive", "whore", "cunt", "ladies", "gender", "gender roles", "gender studies", "feminist", "gender binary", "gender roles", "patriarchy", "mra", "mens rights activist", "mens rights", "examine your privelege", ""]
  gender.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("gender")).first_or_create
  end

  politics = ["politics", "political", "fillibuster", "gridlock", "boycott", "divestment", "grassroots", "sanctions", "election", "mayor", "senate", "senator", "congress", "congressman", "congresswoman", "congressperson", "congress person", "chelsea clinton", "clinton", "representative", "rep", "fuck obama", "potus", "flotus", "democrat", "dem", "republican", "conservative", "liberal", "dems", "democrats", "republicans", "communist", "facist", "protest", "occupy wall street", "wall street", "post-all", "sit-in", "post all", "sit in", "Capitol Hill", "whitehouse", "white house", "newt gingrich", "gingrich", "student election", "student elections", "vote", "voter", "voter registration", "special interest", "special interests", "pac", "super pac", "super-pac", "lobbyist", "lobbyists", "obama", "barack obama", "barack osama", "hillary clinton", "bill clinton", "john mccain", "joe biden", "condoleeza rice", "george bush", "reagan", "nixon", "supreme court", "wendy davis", "gabrielle giffords", "michelle bachmann", "jon stewart", "john stewart", "steven colbert", "colbert", "non-profit", "npo", "volunteer", "paul ryan", "scott walker", "charity", "red cross", "candidate", "primaries", "sarah palin", "todd akin", "ruth bader-ginsburg", "ruth bader-ginsberg", "john edwards", "putin", "vladimir putin", "riots", "government", "gov", "law", "kate bailey hutchinson", "bloomberg", "bill deblasio", "deblasio"]
  politics.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("politics")).first_or_create
  end

  tech = ["App store", "api", "startup", "start up", "start-up", "web developer", "web development", "dev", "sysadmin", "raspberry pi", "arduino", "d3", "macbook", "app", "microsoft", "netflix", "programming", "ruby", "sublime text", "vim", "facebook", "twitter", "tech", "whatsapp", "whats app", "snapchat", "technology", "dev bootcamp", "bill gates", "steve jobs", "google", "html", "css", "python", "java", "javascript", "c++", "fortran", "sublime text 2", "sublime text 3", "rspec", "ajax", "jquery", "ux", "ui", "front end", "front-end", "back end", "back-end", "web developer", "web development", "computer science", "computer", "technological", "technological advances", "technological innovation"]
  tech.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("tech")).first_or_create
  end

  fashion = ["fashion", "clothes", "clothing", "shopping", "hair", "fashionista", "apparel", "fashion plate", "nails", "fingernails", "blouse", "cardigan", "sweater", "nail polish", "nail art", "beauty", "uggs", "notd", "ootd", "outfit", "fashion freak", "fashion tip", "fashion slave", "slave to fashion", "style blog", "my haul", "makeup", "flawless", "gorgeous", "sephora", "sunnies", "sunglasses", "accessories", "accessory", "purse", "clutch", "scarf", "necklace", "earring", "earrings", "jewelry", "diamond ring", "diamond", "sapphire", "emerald", "jewels", "bangles", "necklaces", "bracelet", "bracelets", "lipstick", "lippy", "toner", "primer", "eyeshadow", "blush", "makeup primer", "face primer", "eye primer", "lotion", "body lotion", "face lotion", "eyeliner", "smudge pot", "lip gloss", "lip liner", "mascara", "ulta", "legging", "leggings", "urban outfitters", "anthropologie", "forever 21", "american apparel", "gucci", "prada", "louis vuitton", "chanel", "bcbg", "fendi", "nordstrom", "bloomingdales", "bloomies", "saks", "manolo blahnik", "salon", "louboutins", "louboutin", "armani", "burberry", "j-crew", "j crew", "banana republic", "dress", "rag and bone", "skirt", "shirt", "jacket", "leather jacket", "outfit", "cutest outfit", "cute outfit", "looking good", "cute dress", "shoes", "cute shoes", "hat", "slouchy boots", "boots", "knee high boots", "tights", "fleece lined tights", "fleece tights", "mz wallace", "kate spade", "michael kors", "project runway", "model", "supermodel", "high fashion", "new york fashion week", "fashion week", "runway", "runway show", "fashion model", "haute couture", "couture", "stylist", "celebrity stylist", "rachel zoe", "fashion consultant", "get my hair done", "get my hair cut", "hair cut", "hair dye", "hair bow", "ascot", "hair accessories", "locket", "brooch", "high heels", "heels", "stilettos", "high heeled", "pumps", "high heeled shoes", "high heeled boots", "three inch heels", "four inch heels", "two inch heels", "3 inch heels", "4 inch heels", "2 inch heels", "mani pedi", "mani", "pedi", "manicure", "pedicure", "brazilian blowout", "bikini wax", "full face of slap", "full face o slap", "no makeup", "without makeup", "sans makeup", "spanx", "kitten heels", "bronzer", "moisturize", "moisturizer", "daily moisturizer", "facial moisturizer", "body moisturizer", "juicy couture", "heidi klum", "tim gunn", "make it work"]
  fashion.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("fashion")).first_or_create
  end

  food = ["cafeteria", "caf", "dining", "barista", "favorite barista", "favorite restaurant", "favorite cafe", "favorite food", "favorite drink", "eat", "eating", "ate", "over ate", "over eating", "over eat", "dining hall", "food", "donut", "good food", "muffin", "donuts", "muffins", "breakfast", "lunch", "dinner", "brunch", "grub", "grubhub", "lemon", "lime", "citrus", "green beans", "beans", "black beans", "refried beans", "cupcake", "cupcakes", "almond", "almonds", "nuts", "nut", "cranberry", "cranberries", "berries", "berry", "fruit", "dried fruit", "food", "foods", "fatty foods", "fried foods", "fatty food", "fried food", "country cooking", "country cookin", "soul food", "fried chicken", "collard greens", "greens", "kale chips", "kale chip", "grape", "grapes", "strawberry", "strawberries", "raspberry", "raspberries", "blueberry", "blueberries", "melon", "melons", "papaya", "milkshake", "fast food", "sit down restaurant", "fast food restaurant", "jalapenos", "brown rice", "tabasco", "sriracha", "hot sauce", "mustard", "ketchup", "catsup", "pickles", "pickle", "peppers", "pepper", "hot peppers", "meal plan", "meal", "vegan", "gluten free", "gf", "veganism", "vegetarianism", "vegetarian", "vegeterianism", "vegeterian", "gluten", "coffee", "caffiene", "caffeine", "hamburger", "burger", "pizza", "burgers", "fries", "eggs", "eggs benedict", "omelette", "pancakes", "waffles", "oatmeal", "cereal", "bacon", "sausage", "bacon fat", "bacon flavored", "bacon salt", "ham", "ham steak", "smoothie", "scrambled eggs", "sunny side up", "over easy", "eggs over easy", "hotcakes", "griddle cakes", "sandwich", "huevos rancheros", "breakfast sandwich", "bagel", "breakfast bagel", "bagel sandwich", "baguette", "toast", "club sandwich", "reuben", "italian beef", "italian beef sandwich", "philly cheese steak", "philly cheesesteak", "cheesesteak", "cheese steak", "hot dog", "bratwurst", "italian sausage", "beer and brats", "cheddarwurst", "knockwurst", "schnitzel", "milk", "almond", "peanut", "peanut butter", "almond butter", "nutella", "hazelnut", "walnut", "pecan", "pistachio", "cake", "pie", "chocolate cake", "cherry pie", "apple pie", "strawberry rhubarb pie", "pumpkin pie", "pecan pie", "ice cream", "frozen yogurt", "custard", "ice cream sundae", "ice cream sandwich", "sundae", "dessert", "sweets", "sugar", "coffee", "tea", "soda", "pasta", "spaghetti", "gnocchi", "noodles", "thai food", "thai restaurant", "thai place", "chinese food", "chinese restaurant", "chinese place", "takeout", "chinese takeout", "korean food", "korean restaurant", "korean place", "mexican food", "mexican restaurant", "mexican place", "kimchi", "lo mein", "lomein", "chow mein", "general tso's", "tofu", "chicken", "shrimp", "lamb", "eggrolls", "pot stickers", "pizza rolls", "onion rings", "curly fries", "bloomin onion", "steak", "dumplings", "fried dumplings", "dim sum", "sushi", "japanese food", "japanese restaurant", "japanese place", "curry", "spicy", "rice", "cashew butter", "fudge", "maple", "coconut", "orange", "apple", "peach", "pear", "plum", "banana", "fruit", "nectarine", "cherry", "cherries", "oranges", "coconuts", "apples", "peaches", "plums", "pears", "bananas", "fruits", "panang curry", "green curry", "red curry", "tom kha", "soup", "pad thai", "makimono", "nigiri", "gyoza", "bao", "pork buns", "pork belly", "carmelized", "onions", "mango", "ginger", "broccoli", "peanut sauce", "peanut chicken", "teriyaki", "chipotle", "garlic",  "carmelized onions", "bahn mi", "pho", "vietnamese food", "vietnamese restaurant", "vietnamese place", "italian restaurant", "italian food", "italian place", "russian food", "russian restaurant", "persian food", "persian restaurant", "ethnic food", "burrito", "burritos", "chalupa", "churro", "tostada", "enchilada", "enchiladas", "chili", "chili con queso", "cheese", "cheese fries", "chili fries", "chili cheese fries" ]
  food.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("food")).first_or_create
  end

  religion = ["pray", "jesus", "allah", "buddha", "sermon", "worship", "sunday mass", "saturday mass", "god", "blessed", "hymn", "hymnal", "bible", "church", "religion", "virtue", "meditation", "meditate", "belief", "beliefs", "chapel", "judaism", "temple", "bible study", "bible group", "church service", "pastor", "priest", "rabbi", "atheism", "atheist", "agnostic", "agnosticism", "jewish", "christian", "muslim", "islam", "buddhist", "spiritual", "spiritualism", "catholic", "pope", "bishop", "righteous", "cardinal", "archbishop", "arch bishop", "sunday school", "bible", "bible study"]
  religion.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("religion")).first_or_create
  end

  art = ["art", "artist", "exhibit", "art museum", "art museums", "museums", "museum", "institute", "art institute", "art gallery", "art opening", "gallery opening", "gallery", "surrealist", "impressionist", "pottery", "watercolor", "watercolors", "masterpiece", "oil paint", "oil paints", "acrylic paint", "acrylic paints", "expressionist", "picasso", "cubist", "cubism", "matisse", "magritte", "renoir", "degas", "diy", "do it yourself", "crafty", "artsy", "crafts", "knitting", "sewing", "open mic", "poetry book", "book of poems", "poet", "poetry", "poetry slam", "paint", "painting", "sculpt", "sculpture", "draw", "sculpting", "drawing", "drew", "sculpted", "painted", "exhibition", "photography", "visual art", "vis art", "paintbrush", "gesso", "turpenoid", "paint stains", "paint stained", "art studio", "art gallery", "art show", "art opening", "art history", ]
  art.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("art")).first_or_create
  end

  climate = ["weather", "cold outside", "hot outside", "cold out", "hot out", "misty", "foggy", "sunshine", "clouds", "sunny", "sun", "sunset", "sweltering", "sunscreen", "air conditioner", "ac unit", "freezing", "freeze", "snow", "snowy", "chilly", "snowing", "rain", "rainy", "raining", "windy", "cloudy", "partly cloudy", "clear skies", "cloudy day", "rainy day", "sunny day", "snowy day", "snow day", "snowday", "great weather", "nice weather", "shitty weather", "horrible weather", "awesome weather", "worst weather", "best weather", "sunrise", "beautiful sunset", "beautiful sunrise", "sleet", "sleeting", "hailing", "hail", "icy rain", "blustery", "shivering", "overheated", "nice out", "shitty out", "horrible out", "nice outside", "shitty outside", "horrible outside", "beautiful outside", "beautiful out", "below zero", "below freezing", "celsius", "fahrenheit", "weather", "weather report", "weather forecast", "forecast", "weather man", "weather woman", "weatherman", "weatherwoman", "weather person", "weather.com", "winter", "winter coat", "summer", "spring", "autumn", "humid", "dry heat", "dry air"]
  climate.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("climate")).first_or_create
  end

  music = ["music", "band", "musician", "rock band", "music video", "concert", "jazz", "rock music", "experimental jazz", "show tunes", "musical theater", "musical theatre", "musical", "free show", "sxsw", "south by southwest", "bonaroo", "bonnaroo", "song", "sing", "singing", "stuck in my head", "auto tune", "tone deaf", "singing voice", "singer", "really good singer", "amazing singer", "amazing voice", "the voice", "broadway", "music theory", "instrument", "neo-soul", "r and b", "r&b", "music festival", "amp", "lollapalooza", "coachella", "opening band", "opener", "guitar", "bass", "electric guitar", "fender", "bpm", "clef", "treble", "soprano", "alto", "tenor", "acapella", "acapella group", "drum", "synth", "synthesizer", "violin", "viola", "strings", "trumpet", "clarinet", "horn", "flute", "drums", "percussion", "drummer", "guitarist", "bassist", "keyboard", "keytar", "guitar solo", "bass solo", "drum solo", "my jam", "piano", "dj", "remix", "disc jockey", "give me a beat", "hip hop", "rap", "venue", "hip hop artist", "rapper", "rap artist", "indie pop", "indie rock", "pitchfork", "techno", "skrillex", "dubstep", "metal", "black metal", "heavy metal", "death metal", "blues", "blues artist", "metal band", "death metal band", "heavy metal band", "rock band", "jazz band", "jazz standards", "jazz standard", "classical music"]
  music.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("music")).first_or_create
  end

  social_life = ["friend", "friends", "best friend", "best friends", "bestie", "besties", "bff", "bffs", "girl party", "celebration", "celebrate", "slumber party", "campfire", "camping", "weekend at the cabin", "road trip", "favorite person", "fav person", "favorite girl", "favorite boy", "weekend up north", "cabin weekend", "camping trip", "go camping", "going camping", "sleepover", "event", "events", "fun night", "good times", "bromance", "hug", "fraternity", "fam", "family", "mom", "dad", "mother", "father", "sorority", "sorority sisters", "frat brothers", "sorority sister", "happy birthday", "birthday", "girls night", "ladies night", "bro out", "with the guys", "man cave", "cookout", "grill out", "grilling out", "cooking out", "frisbee", "coffee shop", "coffee house", "go get coffee", "hang out", "hanging out", "hung out", "chill", "chilled", "chillin'", "chillin", "chilling", "hangin out", "hangin' out", "broing out", "bro out", "social", "social life", "my social life", "bowling", "roomie", "roommate", "my roommate", "my roommates", "roommates", "roomies", "old roommate", "new roommate", "old roommates", "new roommates", "out with friends", "with my friends", "i love you guys", "besties forever", "most amazing friend", "love my friends", "awesome friend", "awesome friends", "sisters", "soul sisters", "blood brothers", "blood brother", "soul sister", "soul sistas", "soul sista", "brother from another mother", "brotha from another mother", "sister from another mister", "sista from another mista", "brotha", "sista", "sistas", "brothas", "brothers", "brother", "the bros", "my bros", "bros", "best bros", "my guy friends", "my girl friends", "trivia night", "neighbor", "neighbors", "best buds", "buddy", "buddies", "friends from home", "friends from school", "fun", "best day", "fun day", "outing", "trip", "vacation", "day trip"]
  social_life.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("social life")).first_or_create
  end

  sports = ["sports", "championship", "championship title", "bases loaded", "50 yard line", "jock strap", "cleats", "soccer ball", "golf", "golfer", "tennis", "tennis ball", "tennis court", "grand slam", "slam dunk", "quarterback", "lineman", "offensive lineman", "defensive lineman", "offense", "defense", "penalty", "penalty shot", "goalie", "juke", "field goal", "3 pointer", "2 pointer", "three pointer", "two pointer", "free throw", "punt", "bracket", "march madness", "basketball", "football", "nfl", "nba", "wba", "hockey", "aaron rodgers", "brett favre", "fantasy football", "fantasy football league", "football league", "football game", "basketball game", "baseball", "baseball game", "touchdown", "foul", "referee", "ref", "superbowl", "playoffs", "championship playoffs", "rose bowl", "espn", "sport", "sports team", "football team", "basketball team", "baseball team", "hockey team", "hockey game", "stanley cup", "halftime", "half time", "cheerleader", "cheerleaders", "inning", "ninth inning", "9th inning", "bottom of the ninth", "tennis", "wimbledon", "rowing", "lacrosse", "rugby", "baseball bat", "chicago bears", "packers", "green bay", "green bay packers", "longhorn", "da bears", "cubs", "chicago cubs", "white sox", "red sox", "sox", "ball game", "forty niners", "forty-niners", "giants", "new york giants", "dallas cowboys", "houston texans", "texas rangers", "rangers", "houston astros", "dallas stars", "houston dynamo", "houston rockets", "longhorns", "aggies", "wolverines", "spartans", "detroit tigers", "detroit lions", "detroit redwings", "lions", "tigers", "redwings", "pistons", "sun devils", "sundevils", "cardinals", "mascot", "phoenix suns", "world series", "soccer", "futbol", "world cup", "sugar bowl", "orange bowl", "championship playoff game", "playoff game", "division series", "championship series", "college basketball", "college football", "nba finals", "nhl", "mls", "mlb", "frozen four", "sports news", "lebron james", "michael jordan", "james harden", "the beard", "kevin durant", "chicago bulls", "bulls", "anthony davis", "puck", "andrew wiggins"]
  sports.each do |word|
    ReferenceWord.where(name: word, topic_id: Topic.find_by_name("sports")).first_or_create
  end

  School.where(id: 1, name: "Arizona State University", geofeedia_id: "32204", student_body_count: 59794 ).first_or_create
  School.where(id: 2, name: "University of Michigan, Ann Arbor", geofeedia_id: "32206", student_body_count: 43426).first_or_create
  School.where(id: 3, name: "University of Texas, Austin", geofeedia_id: "32211", student_body_count: 38463).first_or_create
  School.where(id: 4, name: "Michigan State University", geofeedia_id: "32207", student_body_count: 47954).first_or_create
end


def ping_geofeedia
  times_pinged = 0
  until times_pinged == 16
  #{geofeedia_id => "abbrev"}
  #schoools_and_calls = {Arizona State University => "asu",
  #University of Texas Austin => "uta"}
    make_call_to_geofeedia_and_save_json({"32204" => "asu",
    "32211" => "uta",
    "32244" => "uga",
    "32207" => "msu",
    "32206" => "uofm",
    "32202" => "uofi",
    "32251" => "uwm",
    "32243" => "uws",
    "32241" => "ucd",
    "32210" => "cor"
    })
    times_pinged += 1
    sleep 21600
  end
end



# def get_most_recent_post_time(posts)
#   posts.sort_by{|post| post.original_publish_time}.last.original_publish_time
# end

# def update_all_schools_mrpt
#   AnalyzedPost.select(:school_id).distinct.each do |school_id|
#     school = School.find(school_id.school_id)
#     most_recent_post_time = get_most_recent_post_time(school.analyzed_posts)
#     update_the_most_recent_post_time(school, most_recent_post_time)
#   end
# end

# def update_the_most_recent_post_time(school, most_recent_post_time)
#   if school.most_recent_post_time
#     school.most_recent_post_time = most_recent_post_time unless school.most_recent_post_time > most_recent_post_time
#   else
#     school.most_recent_post_time = most_recent_post_time
#   end
# end

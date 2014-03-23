require 'httparty'
require 'json'
require 'find'
require './db/alchemyapi.rb'

  namespace :db do

    desc "Setup from empty database (adding new seed files if any) and wipe tables when done"
    task :setup_from_empty => :environment do
      raise "Databases must be empty!" unless AnalyzedPost.all.empty? && OriginalPost.all.empty? && Keyword.all.empty? && School.all.empty? && Topic.all.empty? && Rating.all.empty? && ReferenceWord.all.empty?
      topics_and_schools
      seed_from_csv
      ["analyzed_posts", "original_posts", "reference_words", "topics", "keywords", "schools"].each do |table|
        result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
        if result.any?
          ai_val = result.first['id'].to_i + 1
          puts "Resetting auto increment ID for #{table} to #{ai_val}"
          ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
        end
      end
      update_csv if Dir['db/seeds/*'].any?
      wipe_temporary_tables
    end

    desc "Setup from empty database (adding new seed files if any) BUT DON'T wipe tables when done"
    task :setup_from_empty_keep_tables => :environment do
      raise "Databases must be empty!" unless AnalyzedPost.all.empty? && OriginalPost.all.empty? && Keyword.all.empty? && School.all.empty? && Topic.all.empty? && Rating.all.empty? && ReferenceWord.all.empty?
      topics_and_schools
      seed_from_csv
      puts ActiveRecord::Base.connection.tables.inspect
      ["analyzed_posts", "original_posts", "reference_words", "topics", "keywords", "schools"].each do |table|
        result = ActiveRecord::Base.connection.execute("SELECT id FROM #{table} ORDER BY id DESC LIMIT 1")
        if result.any?
          ai_val = result.first['id'].to_i + 1
          puts "Resetting auto increment ID for #{table} to #{ai_val}"
          ActiveRecord::Base.connection.execute("ALTER SEQUENCE #{table}_id_seq RESTART WITH #{ai_val}")
        end
      end
      update_csv if Dir['db/seeds/*'].any?
    end

    desc "Populate empty database from csv file"
    task :seed_from_csv => :environment do
    raise "Temporary databases must be empty, and you must have already made schools!" unless AnalyzedPost.all.empty? && OriginalPost.all.empty? && Keyword.all.empty? && School.all.any?
      seed_from_csv
    end

    desc "Create topics and schools"
    task :seed_schools_and_topics => :environment do
      raise "Topics, reference words and schools must be empty!" unless Topic.all.empty? && School.all.empty? && ReferenceWord.all.empty?
      topics_and_schools
    end

    desc "Update the csv file with new seeding info"
    task :update_csv => :environment do
      if AnalyzedPost.all.empty? || Keyword.all.empty? || OriginalPost.all.empty?
        wipe_temporary_tables unless OriginalPost.all.empty? && Keyword.all.empty? && AnalyzedPost.all.empty?
      end
      update_csv
      wipe_temporary_tables
    end

    desc "Wipe the temporary tables"
    task :wipe_temporary_tables => :environment do
      wipe_temporary_tables
    end
  end



def topics_and_schools

  topics = ["food", "tech", "nerd_culture", "art", "partying", "academics", "romance", "lgbt", "fitness", "career", "finance", "gender", "housing", "politics", "religion"]
  topics.each do |topic|
    Topic.create(name: topic)
  end

  nerd_culture = ["nerd", "geek", "nerds", "geeks", "xbox", "ps4", "playstation", "league", "bioshock", "bioshock infinite", "wii", "minecraft", "lolcats", "lolcat", "doge", "bitcoin", "dogecoin", "doctor who", "dr who", "dr. who", "matt smith", "david tennant", "nerd rage", "liz lemon", "30 rock", "peter capaldi", "capaldi", "firefly", "whedon", "joss whedon", "buffy", "btvs", "scifi", "anime", "reddit", "star wars", "star trek", "trekkie", "trekkies", "trekker", "trekkers", "meme", "nerdcore", "nerdfighter", "nerdfighters", "nerdfighteria", "cosplay", "dungeons and dragons", "dungeons & dragons", "d&d", "d20", "20 sided die", "dice set", "set of dice", "twenty sided die", "d10", "d12", "d8", "d4", "rpg", "role playing game", "tabletop", "tabletop game", "settlers of catan", "catan", "board games", "board game", "munchkin", "four chan", "4chan", "comics", "marvel", "dc comics", "orphan black", "agents of shield", "agents of s.h.i.e.l.d.", "pi", "magic", "magic the gathering", "magic cards", "miniatures", "battle mat", "battle board", "world of warcraft", "w.o.w.", "newb", "noob", "n00b", "pwn", "pwned", "night cheese", "adventure time", "finn and jake", "lsp", "lumpy space princess", "princess bubblegum", "marceline", "the ice king", "amy pond", "tardis", "the tardis", "sonic screwdriver", "tribbles", "george takei", "takei", "sulu", "captain kirk", "janeway", "picard", "captain picard", "jean luc picard", "captain janeway", "spock", "big bang" "the big bang", "the big bang theory", "fake geek girl", "fake geek girls", "geek girl", "geek girls", "think geek", "futurama", "scifi", "sci-fi", "syfy", "game of thrones", "winter is coming", "westeros", "the cones of dunshire", "cones of dunshire", "leslie knope", "ben wyatt", "torchwood", "jack harkness", "river song", "face of bo", "geronimo", "the girl who waited", "harry potter", "the boy who lived", "voldemort", "rowling", "hermione granger", "ron weasley", "snape", "severus snape", "marvel vs dc", "dc vs marvel", "mischief managed", "time travel", "space time", "spacetime", "space time continuum", "the verse", "buffy", "buffy the vampire slayer", "dragons"]
  nerd_culture.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("nerd_culture"))
  end

  partying = ["king cobra", "schwasted", "schwasty", "40 oz", "40s", "forties", "fourtys", "fotie", "foties", 'St Patty', "St. Patty's", "Saturday", "Friday", "sex cult", "booze", "margaritas", "margs", "tailgaiting", "stoner", "spring break", "tgif", "freakin weekend", "stoner mindset", "bottle",  "drinks", "unlimited ass", "beer", "alcohol", "shots", "rage", "ragin", "ragin'", "vape", "vaporizer", "dope",  "head shop", "dat ass", "raging", "rager", "get down", "hammered", "spring break", "springbreak", "collegelife", "blacked out", "drugs", "drink", "smoke", "wasted", "shitfaced", "shit faced", "shithoused", "browned out", "blasted", "tipsy", "drunk", "drank", "blotto", "smokin", "kush", "dank", "pot", "weed", "blazed", "blazing", "party", "partying", "cig", "cigarettes", "acid", "lsd", "mdma", "ecstasy", "blackout", "black out", "wine", "liquor", "whiskey", "rum", "gin", "vodka", "tequila", "rumpleminze", "goldschlager", "kahlua", "jager", "jagermeister", "budweiser", "leinenkugels", "leinies", "pbr", "pabst", "pabst blue ribbon", "miller high life", "mgd", "blatts", "hamms", "porter", "stout", "ipa", "amber ale", "red ale", "beer pong", "frat", "greek", "sorority", "club", "420", "bath salts", "busch", "schlitz", "keystone", "30 rack", "thirty rack", "rolling rock", "steel reserve", "house party", "hookah", "hooka", "ritalin", "adderall", "shinerbock", "coors", "cocktail", "kings cup", "king's cup", "circle of death"]
  partying.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("partying"))
  end

  academics = ["study", "test", "class", "school", "college", "academic", "ace", "grade", "studying", "professor", "prof", "homework", "hw", "philosophy", "statistics", "botany", "degree", "physics", "engineering", "productive", "science", "scholar", "scholarship", "brain", "liberal arts", "humanities", "english", "history", "women's studies", "creative writing", "essay", "paper", "midterm", "final", "chem", "chemistry", "allnighter", "all nighter", "internship", "grad", "grad school", "semester", "quarter", "trimester", "term", "terms", "semesters", "quarters", "trimesters", "econ", "study guide", "grades", "studybreak", "lab", "laboratory", "calc", "calculus", "trig", "trigonometry", "algebra", "thesis", "advisor", "dissertation", "seminar", "report", "lab report", "admissions", "prereqs", "prerequisites", "gen eds", "general education", "education", "GRE", "LSAT", "project", "MCAT", "academics", "academic", "academy", "library", "math", "computer science", "comp sci", "j-term"]
  academics.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("academics"))
  end

  lgbt = ["lgbt", "gay", "boi", "bois", "lesbian", "bisexual", "bi", "trans", "transgender", "drag queen", "drag queens", "pansexual", "queer", "genderqueer", "gender queer", "gender", "asexual", "post-op", "post op", "pride parade", "gay pride", "homosexual", "butch", "femme", "fag", "dyke", "boystown", "hunty", "throw shade", "rainbow", "drag ball", "rupaul", "rupauls drag race", "rupaul's drag race", "sharon needles", "raja", "michelle visage", "willam", "jinkx monsoon", "courtney act", "chad michaels", "latrice royale", "jiggly caliente", "pandora boxxx", "jujubee", "manila luzon", "nina flowers", "shangela", "jessica wild", "tyra sanchez", "yara sofia", "alyssa edwards", "bianca del rio", "laganja estranja", ]
  lgbt.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("lgbt"))
  end

  career = ["career", "business", "management", "marketing", "job", "work", "workplace", "office", "overtime", "work week", "worknight", "work night", "shift", "interview", "apprentice", "apprenticeship", "intern", "internship", "manager", "regional manager", "my manager", "my boss", "new job", "old job", "better job", "promotion", "get a raise", "need a raise", "working overtime", "get a promotion", "ceo", "cto", "company president", "interview", "job interview", "group interview", "resume", "job application", "cv", "coworker", "coworkers", "my coworker", "my coworkers", "hr", "human resources", "at my job", "at work", "at my work"]
  career.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("career"))
  end

  romance = ["romance", "hookup", "hook up", "power couple", "slurty", "flirty", "hooked up", "had sex", "have sex", "good lay", "got laid", "get laid", "vibrator", "dildo", "sex toy", "condom", "contraceptives", "contraceptive", "iud", "good boyfriend", "good girlfriend", "awesome boyfriend", "awesome girlfriend", "love", "adore", "in love", "so in love", "smitten", "boy crush", "girl crush", "sex", "crush", "flowers", "date", "date night", "dinner date", "girlfriend", "boyfriend", "wife", "husband", "marriage", "significant other", "s. o.", "s.o.", "spouse"]
  romance.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("romance"))
  end

  fitness = ["fitness", "protien", "workout", "p90x", "gym", "swole", "swol", "parkour", "bodyweight", "bmi", "swoll", "diet", "dieting", "weight", "marathon", "half marathon", "bike", "bicycle", "bicyclist", "bike ride", "ride my bike", "half-marathon", "running", "triathalon", "5k", "five k", "cycling", "jog", "jogging", "body mass index", "body mass", "body weight", "lose weight", "lost weight", "skinny", "thin", "fat", "obese", "diet", "paleo", "weight watchers", "pounds", "snowboard", "bike", "biking", "hiking", "ski", "yoga", "hatha yoga", "hatha"]
  fitness.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("fitness"))
  end

  finance = ["finance", "finances", "destitute", "financial needs", "financial aid", "utilities", "utility bills", "gas bill", "electric bill", "heating bill", "cable bill", "internet bill", "broke", "cheap", "expensive", "money", "bills", "credit", "credit card", "charge it", "debit card", "student loan", "student loans", "payment", "payments", "loan payments", "student debt", "debt", "financial aid", "loan", "bank account", "bank", "dolla dolla billz", "dolla dolla bills", "moolah", "dollaz", "dollars", "hundo", "pricey", "too expensive", "so cheap", "way too expensive", "out of money", "get paid", "get my paycheck", "got my paycheck", "got paid" ]
  finance.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("finance"))
  end

  housing = ["housing", "rent", "lease", "dorm", "apartment", "house", "apartment search", "apartment hunt", "domu", "renting", "my lease", "signed my lease", "sign my lease", "cosign", "apartment application", "rental application"]
  housing.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("housing"))
  end

  gender = ["gender", "women", "men", "female", "sexual harrassment", "princess", "sexual assault", "rape", "sexually harrassed", "sexually assaulted", "raped", "victim blaming", "slut shaming", "slut shame", "bitch", "sexxx", "submissive", "slut", "slutty", "ho", "flasher", "flashed", "cat-call", "cat-called", "cat called", "cat call", "catcall", "catcalled", "twat", "sex positive", "whore", "cunt", "ladies", "gender", "gender roles", "gender studies", "feminist", "gender binary", "gender roles", "patriarchy", "mra", "mens rights activist", "mens rights", "examine your privelege", ""]
  gender.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("gender"))
  end

  politics = ["politics", "political", "fillibuster", "gridlock", "boycott", "divestment", "grassroots", "sanctions", "election", "senate", "senator", "congress", "congressman", "congresswoman", "congressperson", "congress person", "chelsea clinton", "clinton", "representative", "rep", "potus", "flotus", "democrat", "dem", "republican", "conservative", "liberal", "dems", "democrats", "republicans", "communist", "facist", "protest", "occupy wall street", "wall street", "post-all", "sit-in", "post all", "sit in", "Capitol Hill", "whitehouse", "white house", "newt gingrich", "gingrich", "student election", "student elections", "vote", "voter", "voter registration", "special interest", "special interests", "pac", "super pac", "super-pac", "lobbyist", "lobbyists", "obama", "barack obama", "barack osama", "hillary clinton", "bill clinton", "john mccain", "joe biden", "condoleeza rice", "george bush", "reagan", "nixon", "supreme court", "wendy davis", "gabrielle giffords", "michelle bachmann", "jon stewart", "john stewart", "steven colbert", "colbert", "non-profit", "npo", "volunteer", "paul ryan", "scott walker", "charity", "red cross", "candidate", "primaries", "sarah palin", "todd akin", "ruth bader-ginsburg", "ruth bader-ginsberg", "john edwards", "putin", "vladimir putin", "riots", "government", "gov", "law", "kate bailey hutchinson", "bloomberg", "bill deblasio", "deblasio"]
  politics.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("politics"))
  end

  tech = ["App store", "api", "startup", "start up", "start-up", "web developer", "web development", "dev", "sysadmin", "macbook", "app", "microsoft", "netflix", "programming", "ruby", "sublime text", "vim", "facebook", "twitter", "tech", "whatsapp", "whats app", "snapchat", "technology", "dev bootcamp", "bill gates", "steve jobs", "google", "html", "css", "python", "java", "javascript", "c++", "fortran", "sublime text 2", "sublime text 3", "rspec", "ajax", "jquery", "ux", "ui", "front end", "front-end", "back end", "back-end", "web developer", "web development", "computer science", "computer", "technological", "technological advances", "technological innovation"]
  tech.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("tech"))
  end

  food = ["cafeteria", "caf", "dining", "barista", "favorite barista", "favorite restaurant", "favorite cafe", "favorite food", "favorite drink", "dining hall", "food", "donut", "good food", "breakfast", "lunch", "dinner", "brunch", "grub", "grubhub", "lemon", "lime", "citrus", "green beans", "beans", "black beans", "refried beans", "jalapenos", "brown rice", "tabasco", "sriracha", "hot sauce", "mustard", "ketchup", "catsup", "pickles", "pickle", "peppers", "pepper", "hot peppers", "meal plan", "meal", "vegan", "gluten free", "gf", "veganism", "vegetarianism", "vegetarian", "vegeterianism", "vegeterian", "gluten", "coffee", "caffiene", "caffeine", "hamburger", "burger", "pizza", "burgers", "fries", "eggs", "eggs benedict", "omelette", "pancakes", "waffles", "oatmeal", "cereal", "bacon", "sausage", "bacon fat", "bacon flavored", "bacon salt", "ham", "ham steak", "smoothie", "scrambled eggs", "sunny side up", "over easy", "eggs over easy", "hotcakes", "griddle cakes", "sandwich", "huevos rancheros", "breakfast sandwich", "bagel", "breakfast bagel", "bagel sandwich", "baguette", "toast", "club sandwich", "reuben", "italian beef", "italian beef sandwich", "philly cheese steak", "philly cheesesteak", "cheesesteak", "cheese steak", "hot dog", "bratwurst", "italian sausage", "beer and brats", "cheddarwurst", "knockwurst", "schnitzel", "milk", "almond", "peanut", "peanut butter", "almond butter", "nutella", "hazelnut", "walnut", "pecan", "pistachio", "cake", "pie", "chocolate cake", "cherry pie", "apple pie", "strawberry rhubarb pie", "pumpkin pie", "pecan pie", "ice cream", "frozen yogurt", "custard", "ice cream sundae", "ice cream sandwich", "sundae", "dessert", "sweets", "sugar", "coffee", "tea", "soda", "pasta", "spaghetti", "gnocchi", "noodles", "thai food", "thai restaurant", "thai place", "chinese food", "chinese restaurant", "chinese place", "takeout", "chinese takeout", "korean food", "korean restaurant", "korean place", "mexican food", "mexican restaurant", "mexican place", "kimchi", "lo mein", "lomein", "chow mein", "general tso's", "tofu", "chicken", "shrimp", "lamb", "eggrolls", "pot stickers", "dumplings", "fried dumplings", "dim sum", "sushi", "japanese food", "japanese restaurant", "japanese place", "curry", "spicy", "rice", "cashew butter", "fudge", "maple", "coconut", "orange", "apple", "peach", "pear", "plum", "banana", "fruit", "nectarine", "cherry", "cherries", "oranges", "coconuts", "apples", "peaches", "plums", "pears", "bananas", "fruits", "panang curry", "green curry", "red curry", "tom kha", "soup", "pad thai", "makimono", "nigiri", "gyoza", "bao", "pork buns", "pork belly", "carmelized", "onions", "mango", "ginger", "broccoli", "peanut sauce", "peanut chicken", "teriyaki", "chipotle", "garlic",  "carmelized onions", "bahn mi", "pho", "vietnamese food", "vietnamese restaurant", "vietnamese place", "italian restaurant", "italian food", "italian place", "russian food", "russian restaurant", "persian food", "persian restaurant", "ethnic food", "burrito", "burritos", "chalupa", "churro", "tostada", "enchilada", "enchiladas", "chili", "chili con queso", "cheese", "cheese fries", "chili fries", "chili cheese fries" ]
  food.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("food"))
  end

  religion = ["pray", "jesus", "allah", "buddha", "sermon", "worship", "sunday mass", "saturday mass", "god", "blessed", "hymn", "hymnal", "bible", "church", "religion", "chapel", "judaism", "temple", "bible study", "bible group", "church service", "pastor", "priest", "rabbi", "atheism", "atheist", "agnostic", "agnosticism", "jewish", "christian", "muslim", "islam", "buddhist", "spiritual", "spiritualism", "catholic", "pope", "bishop", "righteous", "cardinal", "archbishop", "arch bishop", "sunday school", "bible", "bible study"]
  religion.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("religion"))
  end

  art = ["art", "artist", "exhibit", "art museum", "museum", "institute", "gallery", "surrealist", "impressionist", "pottery", "watercolor", "watercolors", "masterpiece", "oil paint", "oil paints", "acrylic paint", "acrylic paints", "expressionist", "picasso", "cubist", "cubism", "matisse", "magritte", "renoir", "degas", "diy", "do it yourself", "crafty", "artsy", "crafts", "knitting", "sewing", "open mic", "poetry book", "book of poems", "poet", "poetry", "poetry slam", "paint", "painting", "sculpt", "sculpture", "draw", "sculpting", "drawing", "drew", "sculpted", "painted", "exhibition", "photography", "visual art", "vis art", "paintbrush", "gesso", "turpenoid", "paint stains", "paint stained", "art studio", "art gallery", "art show", "art opening", "art history", ]
  art.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("art"))
  end

  climate = ["cold outside", "hot outside", "sunny", "sun", "sunset", "sweltering", "sunscreen", "air conditioner", "ac unit", "freezing", "freeze", "snow", "snowy", "chilly", "snowing", "rain", "rainy", "raining", "windy", "cloudy", "partly cloudy", "clear skies", "cloudy day", "rainy day", "sunny day", "snowy day", "snow day", "snowday", "sunrise", "beautiful sunset", "beautiful sunrise", "sleet", "sleeting", "hailing", "hail", "icy rain", "blustery", "shivering", "overheated", "nice out", "shitty out", "horrible out", "nice outside", "shitty outside", "horrible outside", "beautiful outside", "beautiful out", "below zero", "below freezing", "celsius", "fahrenheit", "weather", "weather report", "weather forecast", "forecast", "weather man", "weather woman", "weatherman", "weatherwoman", "weather person", "weather.com", "winter", "winter coat", "summer", "spring", "autumn" ]
  climate.each do |word|
    ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("climate"))
  end

  School.where(id: 1, name: "Arizona State University", geofeedia_id: "32204", student_body_count: 123456789).first_or_create
  School.where(id: 2, name: "University of Texas Austin", geofeedia_id: "32211", student_body_count: 123456789).first_or_create
end



def seed_from_csv
  post_csv = CSV.read('db/analyzed_posts.csv', :headers => true)
  post_csv.each do |post|
    AnalyzedPost.create(post.to_hash)
  end

  keyword_csv = CSV.read('db/keywords.csv', :headers => true)
  keyword_csv.each do |post|
    Keyword.create(post.to_hash)
  end
end


def update_csv
  new_posts = []

  Dir['db/seeds/*'].each do |filename|
    json = File.read(filename)
    feed_id = filename.gsub(/\D+(\d+)[a-z].+/i, '\1')
    school = School.find_by_geofeedia_id(feed_id)
    parsed = JSON.parse(json)
    batch = []
    if school.original_posts.empty?
      create_original_posts(parsed["items"], batch, feed_id, school)
      first_post_time = batch.sort_by{|post| post.original_publish_time}.first.original_publish_time
      school.first_post_time = first_post_time
    else
      create_original_posts(parsed["items"], batch, feed_id, school)
    end
    batch.each do |post|
      new_posts << post
    end
    most_recent_post_time = batch.sort_by{|post| post.original_publish_time}.last.original_publish_time
    school.most_recent_post_time = most_recent_post_time
    school.save
  end

  alchemyapi = AlchemyAPI.new()

  new_analyzed_posts = []
  new_analyzed_keywords = []
  add_to_id = AnalyzedPost.all.empty?

  new_posts.each do |post|
    post_text = post.text
    alchemy_post_response = alchemyapi.sentiment('text', post_text)
    if alchemy_post_response["docSentiment"]
      overall_sentiment = alchemy_post_response["docSentiment"]["type"]
    else
      overall_sentiment = "neutral"
    end
    new_post = AnalyzedPost.create(school_id: post.school_id, original_publish_time: post.original_publish_time, overall_sentiment: overall_sentiment)
    last_id = CSV.read('db/analyzed_posts.csv').last[0].to_i
    new_post.id = new_post.id + last_id if add_to_id
    new_analyzed_posts << new_post


    alchemy_keywords_response = alchemyapi.keywords('text', post_text, options = {"sentiment" => 1})
    alchemy_keywords_response["keywords"].each do |keyword|
      if keyword["sentiment"]
        sentiment = keyword["sentiment"]["type"]
        confidence = keyword["sentiment"]["score"]
      else
        sentiment = "neutral"
        confidence = 0.0
      end
      new_keyword = Keyword.new(text: keyword["text"], sentiment: sentiment, confidence: confidence, analyzed_post_id: new_post.id)
      # ALSO UPDATE ID OF KEYWORDS
      new_analyzed_keywords << new_keyword if new_keyword.save
    end
  end
  write_to_csv_files(new_analyzed_posts, new_analyzed_keywords)
end

def create_original_posts(parsed_items, batch, feed_id, school)
  parsed_items.each do |item|
    batch << OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school.id)
  end
end


def wipe_temporary_tables
  OriginalPost.all.each {|post| post.destroy}
  AnalyzedPost.all.each {|post| post.destroy}
  Keyword.all.each {|word| word.destroy}
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


def update_ids_for_posts_and_keywords
  new_first_post_id = CSV.read('db/analyzed_posts.csv').last[0].to_i + 1
  new_first_keyword_id = CSV.read('db/keywords.csv').last[0].to_i + 1
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE analyzed_posts_id_seq RESTART WITH #{new_first_post_id}")
  ActiveRecord::Base.connection.execute("ALTER SEQUENCE keywords_id_seq RESTART WITH #{new_first_keyword_id}")
end





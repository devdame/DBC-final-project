require 'httparty'
require 'json'
require 'find'
puts Dir.pwd
require './db/alchemyapi.rb'


############################
#  FOR REALS STUFF TO USE  #
############################

###############Create Topics
topics = ["food", "tech", "nerd_culture", "partying", "academics", "romance", "lgbt", "fitness", "career", "finance", "gender", "housing", "politics", "food", "religion"]

topics.each do |topic|
  Topic.create(name: topic)
end

################Create Reference Words
nerd_culture = ["nerd", "geek", "nerds", "geeks", "xbox", "ps4", "playstation", "league", "bioshock", "bioshock infinite", "wii", "minecraft", "doge", "bitcoin", "dogecoin", "doctor who", "dr who", "dr. who", "firefly", "whedon", "joss whedon", "buffy", "btvs", "scifi", "anime", "reddit", "star wars", "star trek", "trekkie", "trekkies", "trekker", "trekkers", "meme", "nerdcore", "nerdfighter", "nerdfighters", "nerdfighteria"]
nerd_culture.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("nerd_culture"))
end

partying = ["king cobra", "40s", "fourtys", "fotie", "foties", 'St Patty', "St. Patty's", "Saturday", "Friday", "sex cult", "tailgaiting", "drinks", "beer", "alcohol", "shots", "hammered", "spring break", "springbreak", "collegelife", "blacked out", "drugs", "drink", "smoke", "wasted", "shitfaced", "shit faced", "shithoused", "browned out", "blasted", "tipsy", "drunk", "drank", "blotto", "smokin", "kush", "dank", "pot", "weed", "blazed", "blazing", "party", "partying", "cig", "cigarettes", "acid", "lsd", "mdma", "ecstasy", "blackout", "black out", "wine", "liquor", "whiskey", "rum", "gin", "vodka", "tequila", "rumpleminze", "goldschlager", "kahlua", "jager", "jagermeister", "budweiser", "leinenkugels", "leinies", "pbr", "pabst", "pabst blue ribbon", "miller high life", "mgd", "blatts", "hamms", "porter", "stout", "ipa", "amber ale", "red ale", "beer pong", "frat", "greek", "sorority", "club", "420", "bath salts", "busch", "schlitz", "keystone", "30 rack", "thirty rack", "rolling rock", "steel reserve", "house party", "hookah", "hooka", "ritalin", "adderall", "shinerbock", "coors", "cocktail", "kings cup", "king's cup", "circle of death"]
partying.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("partying"))
end

academics = ["study", "test", "class", "school", "college", "academic", "ace", "grade", "studying", "professor", "prof", "homework", "hw", "philosophy", "statistics", "botany", "degree", "physics", "engineering", "productive", "science", "liberal arts", "humanities", "english", "history", "women's studies", "creative writing", "essay", "paper", "midterm", "final", "chem", "chemistry", "allnighter", "all nighter", "internship", "grad", "grad school", "semester", "quarter", "trimester", "term", "terms", "semesters", "quarters", "trimesters", "econ", "study guide", "grades", "studybreak", "lab", "laboratory", "calc", "calculus", "trig", "trigonometry", "algebra", "thesis", "advisor", "dissertation", "seminar", "report", "lab report", "admissions", "prereqs", "prerequisites", "gen eds", "general education", "education", "GRE", "LSAT", "project", "MCAT", "academics", "academic", "academy", "library", "math", "computer science", "comp sci", "j-term"]
academics.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("academics"))
end

lgbt = ["lgbt", "gay", "lesbian", "bisexual", "bi", "trans", "transgender", "drag queen", "drag queens", "pansexual", "queer", "genderqueer", "gender queer", "gender", "asexual", "post-op", "post op", "pride parade", "gay pride", "homosexual", "butch", "femme", "fag", "dyke", "boystown", "hunty", "throw shade", "rainbow", "drag ball", "RuPaul"]
lgbt.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("lgbt"))
end

career = ["career", "business", "management", "marketing", "job", "work", "workplace", "office", "overtime", "work week", "worknight", "work night", "shift", "interview", "apprentice", "apprenticeship", "intern", "internship"]

career.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("career"))
end

romance = ["romance", "hookup", "sex", "crush", "flowers", "date", "girlfriend", "boyfriend", "wife", "husband", "marriage", "significant other", "s. o.", "s.o.", "spouse", "date night"]

romance.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("romance"))
end

fitness = ["fitness", "protien", "workout", "p90x", "gym", "swole", "swol", "parkour", "bodyweight", "bmi", "swoll", "diet", "dieting", "weight", "marathon", "half marathon", "half-marathon", "running", "triathalon", "5k", "five k", "cycling", "jog", "jogging", "body mass index", "body mass", "body weight", "lose weight", "lost weight", "pounds", "snowboard", "bike", "biking", "hiking", "ski", "yoga", "hatha yoga", "hatha"]

fitness.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("fitness"))
end

finance = ["finance", "finances", "broke", "cheap", "expensive"]

finance.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("finance"))
end

housing = ["housing", "rent", "lease", "dorm", "apartment", "house"]

housing.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("housing"))
end

gender = ["gender", "women", "female", "bitch", "sexxx", "slurty", "flirty", "submissive", "sex positive", "whore", "cunt", "ladies", "gender", "gender roles", "gender studies", "feminist", "gender binary"]

gender.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("gender"))
end

politics = ["politics", "political", "fillibuster", "gridlock", "boycott", "divestment", "sanctions", "election", "senate", "senator", "congress", "congressman", "congresswoman", "congressperson", "congress person", "representative", "rep", "potus", "flotus", "democrat", "dem", "republican", "conservative", "liberal", "dems", "democrats", "republicans", "communist", "facist", "protest", "occupy wall street", "wall street", "post-all", "sit-in", "post all", "sit in", "Capitol Hill", "whitehouse", "white house", "newt gingrich", "gingrich", "student election", "student elections", "vote", "voter", "voter registration", "special interest", "special interests", "pac", "super pac", "super-pac", "lobbyist", "lobbyists"]

politics.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("politics"))
end

tech = ["App store", "api", "startup", "start up", "start-up", "web developer", "web development", "dev", "sysadmin", "macbook", "app", "microsoft", "netflix", "programming", "ruby", "python", "sublime text", "vim", "facebook", "twitter", "tech", "whatsapp", "whats app", "snapchat", "technology"]

tech.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("tech"))
end

food = ["cafeteria", "caf", "dining", "dining hall", "food", "breakfast", "lunch", "dinner", "brunch", "grub", "meal plan", "meal", "vegan", "gluten free", "gf", "veganism", "vegetarianism", "vegetarian", "vegeterianism", "vegeterian", "gluten", "coffee", "caffiene"]

food.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("food"))
end

religion = ["pray", "jesus", "allah", "buddha", "god", "blessed", "hymn", "hymnal", "bible", "church", "religion", "chapel", "judiasm", "temple", "bible study", "bible group", "atheism", "atheist", "jewish", "christian", "muslim", "islam", "buddhist", "spiritual", "spiritualism", "catholic", "pope", "bishop", "priest", "pastor", "righteous"]

religion.each do |word|
  ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("religion"))
end

##########################Create Original Posts
def create_original_posts(parsed_items, batch, feed_id, school)
  parsed_items.each do |item|
    batch << OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school.id)
  end
end

# School.create(name: "University of Illinois, Urbana-Champaign", geofeedia_id: "32202", student_body_count: 44520)
# School.create(name: "University of Michigan, Ann Arbor", geofeedia_id: "32206", student_body_count: 43426)

School.create(name: "Arizona State University", geofeedia_id: "32204", student_body_count: 123456789)
School.create(name: "University of Texas Austin", geofeedia_id: "32211", student_body_count: 123456789)

School.create_ratings

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

  most_recent_post_time = batch.sort_by{|post| post.original_publish_time}.last.original_publish_time
  school.most_recent_post_time = most_recent_post_time
  school.save
end

alchemyapi = AlchemyAPI.new()


OriginalPost.all.each do |post|

  post_text = post.text
  alchemy_post_response = alchemyapi.sentiment('text', post_text)

  new_post = AnalyzedPost.create(school_id: post.school_id, original_publish_time: post.original_publish_time, overall_sentiment: alchemy_post_response["docSentiment"]["type"])

  alchemy_keywords_response = alchemyapi.keywords('text', post_text, options = {"sentiment" => 1})
  alchemy_keywords_response["keywords"].each do |keyword|
    Keyword.create(text: keyword["text"], sentiment: keyword["sentiment"]["type"], confidence: keyword["sentiment"]["score"], analyzed_post_id: new_post.id)
  end

end

##########################Create School Word Counts
Keyword.create_or_update_school_word_counts



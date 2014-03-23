require 'httparty'
require 'json'
require 'find'
require './db/alchemyapi.rb'


# ############################
# #  FOR REALS STUFF TO USE  #
# ############################


###############Create Topics

# topics = ["food", "tech", "nerd_culture", "partying", "academics", "romance", "lgbt", "fitness", "career", "finance", "gender", "housing", "politics", "religion"]

# topics.each do |topic|
#   Topic.create(name: topic)
# end

# ################Create Reference Words

# nerd_culture = ["nerd", "geek", "nerds", "geeks", "xbox", "ps4", "playstation", "league", "bioshock", "bioshock infinite", "wii", "minecraft", "lolcats", "lolcat", "doge", "bitcoin", "dogecoin", "doctor who", "dr who", "dr. who", "matt smith", "david tennant", "nerd rage", "liz lemon", "30 rock", "peter capaldi", "capaldi", "firefly", "whedon", "joss whedon", "buffy", "btvs", "scifi", "anime", "reddit", "star wars", "star trek", "trekkie", "trekkies", "trekker", "trekkers", "meme", "nerdcore", "nerdfighter", "nerdfighters", "nerdfighteria", "cosplay", "dungeons and dragons", "dungeons & dragons", "d&d", "d20", "20 sided die", "dice set", "set of dice", "twenty sided die", "d10", "d12", "d8", "d4", "rpg", "role playing game", "tabletop", "tabletop game", "settlers of catan", "catan", "board games", "board game", "munchkin", "four chan", "4chan", "comics", "marvel", "dc comics", "orphan black", "agents of shield", "agents of s.h.i.e.l.d.", "pi", "magic", "magic the gathering", "magic cards", "miniatures", "battle mat", "battle board", "world of warcraft", "w.o.w.", "newb", "noob", "n00b", "pwn", "pwned"]
# nerd_culture.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("nerd_culture"))
# end

# partying = ["king cobra", "schwasted", "schwasty", "40 oz", "40s", "forties", "fourtys", "fotie", "foties", 'St Patty', "St. Patty's", "Saturday", "Friday", "sex cult", "booze", "tailgaiting", "drinks", "beer", "alcohol", "shots", "rage", "ragin", "ragin'", "raging", "rager", "get down", "hammered", "spring break", "springbreak", "collegelife", "blacked out", "drugs", "drink", "smoke", "wasted", "shitfaced", "shit faced", "shithoused", "browned out", "blasted", "tipsy", "drunk", "drank", "blotto", "smokin", "kush", "dank", "pot", "weed", "blazed", "blazing", "party", "partying", "cig", "cigarettes", "acid", "lsd", "mdma", "ecstasy", "blackout", "black out", "wine", "liquor", "whiskey", "rum", "gin", "vodka", "tequila", "rumpleminze", "goldschlager", "kahlua", "jager", "jagermeister", "budweiser", "leinenkugels", "leinies", "pbr", "pabst", "pabst blue ribbon", "miller high life", "mgd", "blatts", "hamms", "porter", "stout", "ipa", "amber ale", "red ale", "beer pong", "frat", "greek", "sorority", "club", "420", "bath salts", "busch", "schlitz", "keystone", "30 rack", "thirty rack", "rolling rock", "steel reserve", "house party", "hookah", "hooka", "ritalin", "adderall", "shinerbock", "coors", "cocktail", "kings cup", "king's cup", "circle of death"]
# partying.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("partying"))
# end

# academics = ["study", "test", "class", "school", "college", "academic", "ace", "grade", "studying", "professor", "prof", "homework", "hw", "philosophy", "statistics", "botany", "degree", "physics", "engineering", "productive", "science", "liberal arts", "humanities", "english", "history", "women's studies", "creative writing", "essay", "paper", "midterm", "final", "chem", "chemistry", "allnighter", "all nighter", "internship", "grad", "grad school", "semester", "quarter", "trimester", "term", "terms", "semesters", "quarters", "trimesters", "econ", "study guide", "grades", "studybreak", "lab", "laboratory", "calc", "calculus", "trig", "trigonometry", "algebra", "thesis", "advisor", "dissertation", "seminar", "report", "lab report", "admissions", "prereqs", "prerequisites", "gen eds", "general education", "education", "GRE", "LSAT", "project", "MCAT", "academics", "academic", "academy", "library", "math", "computer science", "comp sci", "j-term"]
# academics.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("academics"))
# end

# lgbt = ["lgbt", "gay", "lesbian", "bisexual", "bi", "trans", "transgender", "drag queen", "drag queens", "pansexual", "queer", "genderqueer", "gender queer", "gender", "asexual", "post-op", "post op", "pride parade", "gay pride", "homosexual", "butch", "femme", "fag", "dyke", "boystown", "hunty", "throw shade", "rainbow", "drag ball", "rupaul", "rupauls drag race", "rupaul's drag race", "sharon needles", "raja", "michelle visage", "willam", "jinkx monsoon", "courtney act", "chad michaels", "latrice royale", "jiggly caliente", "pandora boxxx", "jujubee", "manila luzon", "nina flowers", "shangela", "jessica wild", "tyra sanchez", "yara sofia", "alyssa edwards", "bianca del rio", "laganja estranja", ]
# lgbt.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("lgbt"))
# end

# career = ["career", "business", "management", "marketing", "job", "work", "workplace", "office", "overtime", "work week", "worknight", "work night", "shift", "interview", "apprentice", "apprenticeship", "intern", "internship", "manager", "regional manager", "my manager", "my boss", "new job", "old job", "better job", "promotion", "get a raise", "need a raise", "working overtime", "get a promotion", "ceo", "cto", "company president", "interview", "job interview", "group interview", "resume", "job application", "cv", "coworker", "coworkers", "my coworker", "my coworkers", "hr", "human resources"]
# career.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("career"))
# end

# romance = ["romance", "hookup", "hook up", "hooked up", "had sex", "have sex", "good lay", "got laid", "get laid", "sex", "crush", "flowers", "date", "date night", "dinner date", "girlfriend", "boyfriend", "wife", "husband", "marriage", "significant other", "s. o.", "s.o.", "spouse"]
# romance.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("romance"))
# end

# fitness = ["fitness", "protien", "workout", "p90x", "gym", "swole", "swol", "parkour", "bodyweight", "bmi", "swoll", "diet", "dieting", "weight", "marathon", "half marathon", "half-marathon", "running", "triathalon", "5k", "five k", "cycling", "jog", "jogging", "body mass index", "body mass", "body weight", "lose weight", "lost weight", "pounds", "snowboard", "bike", "biking", "hiking", "ski", "yoga", "hatha yoga", "hatha"]
# fitness.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("fitness"))
# end

# finance = ["finance", "finances", "broke", "cheap", "expensive", "money", "bills", "credit", "credit card", "charge it", "debit card", ]
# finance.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("finance"))
# end

# housing = ["housing", "rent", "lease", "dorm", "apartment", "house", "apartment search", "apartment hunt"]
# housing.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("housing"))
# end

# gender = ["gender", "women", "female", "bitch", "sexxx", "slurty", "flirty", "submissive", "sex positive", "whore", "cunt", "ladies", "gender", "gender roles", "gender studies", "feminist", "gender binary"]
# gender.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("gender"))
# end

# politics = ["politics", "political", "fillibuster", "gridlock", "boycott", "divestment", "grassroots", "sanctions", "election", "senate", "senator", "congress", "congressman", "congresswoman", "congressperson", "congress person", "representative", "rep", "potus", "flotus", "democrat", "dem", "republican", "conservative", "liberal", "dems", "democrats", "republicans", "communist", "facist", "protest", "occupy wall street", "wall street", "post-all", "sit-in", "post all", "sit in", "Capitol Hill", "whitehouse", "white house", "newt gingrich", "gingrich", "student election", "student elections", "vote", "voter", "voter registration", "special interest", "special interests", "pac", "super pac", "super-pac", "lobbyist", "lobbyists", "obama", "barack obama", "barack osama", "hillary clinton", "bill clinton", "john mccain", "joe biden", "condoleeza rice", "george bush", "reagan", "nixon", "supreme court", "wendy davis", "gabrielle giffords", "michelle bachmann", "jon stewart", "john stewart", "steven colbert", "colbert", "non-profit", "npo", "volunteer", "paul ryan", "scott walker", "charity", "red cross", "candidate", "primaries", "sarah palin", "todd akin", "ruth bader-ginsburg", "ruth bader-ginsberg", "john edwards", "putin", "vladimir putin", "riots", "government", "gov", "law", "kate bailey hutchinson", "bloomberg", "bill deblasio", "deblasio"]
# politics.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("politics"))
# end

# tech = ["App store", "api", "startup", "start up", "start-up", "web developer", "web development", "dev", "sysadmin", "macbook", "app", "microsoft", "netflix", "programming", "ruby", "python", "sublime text", "vim", "facebook", "twitter", "tech", "whatsapp", "whats app", "snapchat", "technology"]
# tech.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("tech"))
# end

# food = ["cafeteria", "caf", "dining", "barista", "favorite barista", "favorite restaurant", "favorite cafe", "favorite food", "favorite drink", "dining hall", "food", "breakfast", "lunch", "dinner", "brunch", "grub", "meal plan", "meal", "vegan", "gluten free", "gf", "veganism", "vegetarianism", "vegetarian", "vegeterianism", "vegeterian", "gluten", "coffee", "caffiene"]
# food.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("food"))
# end

# religion = ["pray", "jesus", "allah", "buddha", "god", "blessed", "hymn", "hymnal", "bible", "church", "religion", "chapel", "judiasm", "temple", "bible study", "bible group", "atheism", "atheist", "jewish", "christian", "muslim", "islam", "buddhist", "spiritual", "spiritualism", "catholic", "pope", "bishop", "priest", "pastor", "righteous"]
# religion.each do |word|
#   ReferenceWord.create(name: word.downcase, topic: Topic.find_by_name("religion"))
# end

##########################Create Original Posts

# def create_original_posts(parsed_items, batch, feed_id, school)
#   parsed_items.each do |item|
#     batch << OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school.id)
#   end
# end

# School.where(name: "Arizona State University", geofeedia_id: "32204", student_body_count: 123456789).first_or_create
# School.where(name: "University of Texas Austin", geofeedia_id: "32211", student_body_count: 123456789).first_or_create

# new_posts = []

# Dir['db/seeds/*'].each do |filename|
#   json = File.read(filename)
#   feed_id = filename.gsub(/\D+(\d+)[a-z].+/i, '\1')
#   school = School.find_by_geofeedia_id(feed_id)
#   parsed = JSON.parse(json)
#   batch = []
#   if school.original_posts.empty?
#     create_original_posts(parsed["items"], batch, feed_id, school)
#     first_post_time = batch.sort_by{|post| post.original_publish_time}.first.original_publish_time
#     school.first_post_time = first_post_time
#   else
#     create_original_posts(parsed["items"], batch, feed_id, school)
#   end
#   batch.each do |post|
#     new_posts << post
#   end
#   most_recent_post_time = batch.sort_by{|post| post.original_publish_time}.last.original_publish_time
#   school.most_recent_post_time = most_recent_post_time
#   school.save
# end

# alchemyapi = AlchemyAPI.new()

# new_analyzed_posts = []
# new_analyzed_keywords = []

# new_posts.each do |post|

#   post_text = post.text

#   alchemy_post_response = alchemyapi.sentiment('text', post_text)
#   if alchemy_post_response["docSentiment"]
#     overall_sentiment = alchemy_post_response["docSentiment"]["type"]
#   else
#     overall_sentiment = "neutral"
#   end
#   new_post = AnalyzedPost.new(school_id: post.school_id, original_publish_time: post.original_publish_time, overall_sentiment: overall_sentiment)
#   new_analyzed_posts << new_post if new_post.save

#   alchemy_keywords_response = alchemyapi.keywords('text', post_text, options = {"sentiment" => 1})
#   alchemy_keywords_response["keywords"].each do |keyword|
#     if keyword["sentiment"]
#       sentiment = keyword["sentiment"]["type"]
#       confidence = keyword["sentiment"]["score"]
#     else
#       sentiment = "neutral"
#       confidence = 0.0
#     end
#     new_keyword = Keyword.new(text: keyword["text"], sentiment: sentiment, confidence: confidence, analyzed_post_id: new_post.id)
#     new_analyzed_keywords << new_keyword if new_keyword.save
#   end
# end

# CSV.open('db/analyzed_posts.csv', 'a') do |csv|
#   new_analyzed_posts.each do |post|
#     csv << post.attributes.values
#   end
# end

# CSV.open('db/keywords.csv', 'a') do |csv|
#   new_analyzed_keywords.each do |keyword|
#     csv << keyword.attributes.values
#   end
# end

require 'httparty'
require 'json'
require 'find'
puts Dir.pwd
require './db/alchemyapi.rb'


############################
#  FOR REALS STUFF TO USE  #
############################

def create_original_posts(parsed_items, batch, feed_id, school)
  parsed_items.each do |item|
    batch << OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school.id)
  end
end

School.create(name: "University of Illinois, Urbana-Champaign", geofeedia_id: "32202", student_body_count: 44520)
School.create(name: "University of Michigan, Ann Arbor", geofeedia_id: "32206", student_body_count: 43426)

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


# OriginalPost.each do |post|
post = OriginalPost.first

post_text = post.text
alchemy_post_response = alchemyapi.sentiment('text', post_text)

new_post = AnalyzedPost.create(school_id: post.school_id, original_publish_time: post.original_publish_time, overall_sentiment: alchemy_post_response["docSentiment"]["type"])
puts new_post.overall_sentiment

alchemy_keywords_response = alchemyapi.keywords('text', post_text, options = {"sentiment" => 1})
alchemy_keywords_response["keywords"].each do |keyword|
  Keyword.create(text: keyword["text"], sentiment: keyword["sentiment"]["type"], confidence: keyword["sentiment"]["score"], analyzed_post_id: new_post.id)
end

# end



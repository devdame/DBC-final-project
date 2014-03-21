require 'httparty'
require 'json'
require 'find'

############################
#  FOR REALS STUFF TO USE  #
############################

School.create(name: "University of Illinois, Champaign-Urbana", geofeedia_id: "32202")
School.create(name: "University of Michigan, Ann Arbor", geofeedia_id: "32206")

Dir['db/seeds/*'].each do |filename|
  json = File.read(filename)
  feed_id = filename.gsub(/\D+(\d+)[a-z].+/i, '\1')
  school_id = School.find_by_geofeedia_id(feed_id).id
  parsed = JSON.parse(json)



  parsed["items"].each do |item|
    OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school_id)
  end
end

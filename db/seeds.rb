# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'httparty'
require 'json'

# response = HTTParty.get('https://api.geofeedia.com/v1/search/geofeed/32206?appId=420880de&appKey=306ced14ef8ab2183b8264327c456806&maxDate=2014-03-19T23:59:59Z')

uofm_320 = File.read('seeds/uofm32206_3_20_1342.json')
parsed = JSON.parse(json)

sample_data = []

parsed["items"].each do |item|
  sample_data << item["title"]
end

puts sample_data

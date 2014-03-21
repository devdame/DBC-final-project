# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'httparty'
require 'json'

json = File.read('seeds/uofm32206_3_20_1342.json')
parsed = JSON.parse(json)

sample_data = []

parsed["items"].each do |item|
  sample_data << item["title"]
end

puts sample_data

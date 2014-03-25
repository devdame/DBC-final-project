require 'httparty'
require 'json'
require 'find'
require './db/alchemyapi.rb'
require 'fileutils'


class GeofeediaWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    AnalyzedPost.create(school_id: 1, overall_sentiment: "positive", original_publish_time: Time.now)
  end

  def Worker1
  	geofeedia_id = 32206
  	school_id = 1
    url = "https://api.geofeedia.com/v1/search/geofeed/#{geofeedia_id}?format=json-default&appId=420880de&appKey=306ced14ef8ab2183b8264327c456806&take=10"
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body)
    parsed_items = parsed["items"]
    parsed_items.each do |item|
      post = OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: geofeedia_id, school_id: school_id, external_id: item["externalId"])
    end
  end
end
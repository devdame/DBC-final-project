require 'httparty'
require 'json'

class GeofeediaWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }
  # recurrence { hourly.minute_of_hour(0, 15, 30, 45) }

  def perform
  	geofeedia_id = 32210
  	school_id = 6
    appId = ENV['GEOFEEDIA_ID']
    appKey = ENV['GEOFEEDIA_KEY']
    url = "https://api.geofeedia.com/v1/search/geofeed/#{geofeedia_id}?format=json-default&appId=#{appId}&appKey=#{appKey}&take=10"
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body)
    parsed_items = parsed["items"]
    parsed_items.each do |item|
      post = OriginalPost.create(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: geofeedia_id, school_id: school_id, external_id: item["externalId"])
    end
    AlchemyWorker.perform_async
  end
end
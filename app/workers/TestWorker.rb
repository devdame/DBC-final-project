class SomeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    AnalyzedPost.create(school_id: 1, overall_sentiment: "positive", original_publish_time: Time.now)
  end

  def testcall
  	geofeedia_id = 32206
    url = "https://api.geofeedia.com/v1/search/geofeed/#{geofeedia_id}?format=json-default&appId=420880de&appKey=306ced14ef8ab2183b8264327c456806"
    response = HTTParty.get(url)
    parsed = JSON.parse(response)
    parsed_items = parsed["items"]
    post = OriginalPost.new(text: item["title"], original_publish_time: item["publishDate"], geofeedia_school_id: feed_id, school_id: school.id, external_id: item["externalId"])
end
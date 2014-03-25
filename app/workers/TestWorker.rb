class SomeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely }

  def perform
    AnalyzedPost.create(school_id: 1, overall_sentiment: "positive", original_publish_time: Time.now)
  end
end
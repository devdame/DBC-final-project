class FilterWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence { hourly.minute_of_hour(10, 25, 40, 55) }

  def perform
    AnalyzedPost.populate_reference_words
    AnalyzedPost.increment_school_ratings
    Keyword.populate_reference_words
    Keyword.create_or_update_school_word_counts
  end

  def wildfire
  	AnalyzedPost.destroy_all
  	Keyword.destroy_all
  end
end
require 'pry'
require 'pry-nav'

class AnalyzedPost < ActiveRecord::Base
  validates :school_id, presence: true
  validates :overall_sentiment, presence: true
  validates :original_publish_time, presence: true

  belongs_to :school
  has_many :keywords

  def self.increment_school_word_count
    self.all.each do |post|
      school = School.find(post.school_id)
      if post.overall_sentiment == "positive"
        school.post_count += 1
        school.positive_post_count += 1
      elsif post.overall_sentiment == "negative"
        school.post_count += 1
        school.negative_post_count += 1
      elsif post.overall_sentiment == "neutral"
        school.post_count += 1
        school.neutral_post_count += 1
      elsif post.overall_sentiment == "mixed"
        school.post_count += 1
        school.mixed_post_count += 1
      end
        school.save
    end
  end

  def self.increment_school_ratings
    reference_words = [] #SHOULD THIS BE GLOBAL?
    ReferenceWord.all.each do |reference_word|
      reference_words << reference_word.name
    end

    self.all.each do |post|
      school = School.find(post.school_id)
      ratings = {}
      post.keywords.each do |keyword|
        if reference_words.index(keyword.text.downcase)
          index = reference_words.index(keyword.text.downcase)
          lookup_reference_word = ReferenceWord.find_by_name(reference_words[index])
          reference_word_topic = lookup_reference_word.topic.name
          if ratings.has_key?("#{reference_word_topic}")
            ratings[reference_word_topic].push(keyword)
          else
            ratings[reference_word_topic] = [keyword]
          end
        end
      end

      ratings.each do |topic, keyword_match|
        topic_record = Topic.find_by_name(topic)
        school_rating = Rating.where(topic_id: topic_record.id, school_id: school.id)[0]
        if keyword_match.length == 1
          school_rating.total_post_count += 1
          # school_rating.save
          keyword = ratings[topic].first
          if keyword.confidence.abs > 0.15
            if keyword.sentiment == "positive"
              school_rating.positive_post_count += 1
            elsif keyword.sentiment == "negative"
              school_rating.negative_post_count += 1
            elsif keyword.sentiment == "neutral"
              school_rating.neutral_post_count += 1
            elsif keyword.sentiment == "mixed"
              school_rating.mixed_post_count += 1
            end
          end
            school_rating.save
            binding.pry
        elsif keyword_match.length > 1
          school_rating.total_post_count += 1
          # school_rating.save
          aggregated_keywords_data = self.aggregate_keywords(keyword_match)
          if aggregated_keywords_data[:positive_negative_difference] < 0.3
            school_rating.mixed_post_count += 1
          elsif aggregated_keywords_data[:greatest_count] == "positive_count"
            school_rating.positive_post_count += 1
          elsif aggregated_keywords_data[:greatest_count] == "negative_count"
            school_rating.negative_post_count += 1
          elsif aggregated_keywords_data[:greatest_count] == "neutral_count"
            school_rating.neutral_post_count += 1
          elsif aggregated_keywords_data[:greatest_count] == "mixed_count"
            school_rating.mixed_count += 1
          end
            school_rating.save
        end
      end
    end

  end

  def self.aggregate_keywords(keywords_array)
    counts = {"positive_count" => 0, "negative_count" => 0, "neutral_count" => 0, "mixed_count" => 0}
    keywords_array.each do |keyword|
      if keyword.sentiment == "positive"
        counts["positive_count"] += keyword.confidence.abs
      elsif keyword.sentiment == "negative"
        counts["negative_count"] += keyword.confidence.abs
      elsif keyword.sentiment == "neutral"
        counts["neutral_count"] += keyword.confidence.abs
      elsif keyword.sentiment == "mixed"
        counts["mixed_count"] += keyword.confidence.abs
      end
    end
    positive_negative_difference = (counts["positive_count"] - counts["negative_count"]).abs
    greatest_count = counts.max_by{|k,v| v}.first
    {:greatest_count => greatest_count, :positive_negative_difference => positive_negative_difference}
  end

end

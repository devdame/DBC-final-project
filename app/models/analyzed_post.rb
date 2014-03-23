require 'pry'
require 'pry-nav'

class AnalyzedPost < ActiveRecord::Base
  validates :school_id, presence: true
  validates :overall_sentiment, presence: true
  validates :original_publish_time, presence: true

  belongs_to :school
  has_many :keywords

  def self.find_school(post)
    post.school
  end

  def self.increment_school_word_count
    self.all.each do |post|
      school = self.find_school(post)
      school.post_count += 1
      case post.overall_sentiment
      when "positive" then school.positive_post_count += 1
      when "negative" then school.negative_post_count += 1
      when "neutral" then school.neutral_post_count += 1
      when "mixed" then school.mixed_post_count += 1
      end
      school.save
    end
  end

  def self.find_reference_words
    reference_words = []
    ReferenceWord.all.each do |reference_word|
      reference_words << reference_word.name
    end
    reference_words
  end

  def self.get_ratings_hash(post)
    ratings = {}
    reference_words = self.find_reference_words
    post.keywords.each do |keyword|
      text = keyword.text.downcase
      if reference_words.include?(text)
        lookup_reference_word = ReferenceWord.find_by_name(text)
        topic = lookup_reference_word.topic.name
        ratings.has_key?("#{topic}") ? ratings[topic].push(keyword) : ratings[topic] = [keyword]
      end
    end
    ratings
  end

  def self.increment_school_ratings
    self.all.each do |post|
      school = self.find_school(post)
      ratings = self.get_ratings_hash(post)
      ratings.each do |topic, keyword_match|
        topic_record = Topic.find_by_name(topic)
        school_rating = Rating.find_or_create_by(topic_id: topic_record.id, school_id: school.id)
        if keyword_match.length == 1
          school_rating.total_post_count += 1
          keyword = ratings[topic].first
          #the first keyword within the keyword_match array, which in this nested if loop, should only ever be one element long
          if keyword.confidence.abs > 0.15
            sentiment = keyword.sentiment
            case sentiment
            when "positive" then school_rating.positive_post_count += 1
            when "negative" then school_rating.negative_post_count += 1
            when "neutral" then school_rating.neutral_post_count += 1
            when "mixed" then school_rating.mixed_post_count += 1
            end
          end
          school_rating.save
        elsif keyword_match.length > 1
          ##if there is more than one keyword associated with a particular topic within a post
          school_rating.total_post_count += 1
          ##increment the total post count on the rating for this school and topic
          # school_rating.save
          aggregated_keywords_data = self.aggregate_keywords(keyword_match)
          ##look at aggregate_keywords to figure out what the fuck is going on here.
          if aggregated_keywords_data[:positive_negative_difference] < 0.1 #changed from 0.3 to 0.1 so that when we start running we accrue more data
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
    #this method takes an array of keywords that are all associated with one particular topic and school
    counts = Hash.new(0)
    keywords_array.each do |keyword|
      sentiment = keyword.sentiment
      confidence = keyword.confidence
      if sentiment == "positive"
        counts["positive_count"] += confidence.abs
      elsif sentiment == "negative"
        counts["negative_count"] += confidence.abs
      elsif sentiment == "neutral"
        counts["neutral_count"] += confidence.abs
      elsif sentiment == "mixed"
        counts["mixed_count"] += confidence.abs
      end
      #increment the count associated with the sentiment in the keyword object by one
    end
    positive_negative_difference = (counts["positive_count"] - counts["negative_count"]).abs
    #take the positive post count and subtract the absolute value of the negative post count
    greatest_count = counts.max_by{|k,v| v}.first
    #find the strongest sentiment among all the keywords in the array
    {:greatest_count => greatest_count, :positive_negative_difference => positive_negative_difference}
    #check to make sure that the difference between positive and negative sentiment is big enough
  end
end

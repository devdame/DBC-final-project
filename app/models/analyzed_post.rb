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
        school_rating = Rating.where(topic_id: topic_record.id, school_id: school.id).first_or_create
        school_rating.total_post_count += 1
        aggregated_keywords_data = self.aggregate_keywords(keyword_match)
        case aggregated_keywords_data
        when "neutral" then school_rating.neutral_post_count +=1
        when "positive" then school_rating.positive_post_count +=1
        when "negative" then school_rating.negative_post_count +=1
        when "mixed" then school_rating.mixed_post_count +=1
        end
        school_rating.save
      end
    end
  end

  def self.aggregate_keywords(keywords_array)
    confidence_array = []
    keywords_array.each do |keyword|
      confidence = keyword.confidence
      confidence_array << confidence
    end

    confidence_sum = confidence_array.inject(:+)
    if confidence_sum == 0
      "neutral"
    elsif confidence_sum > 0.1
      "positive"
    elsif confidence_sum < -0.1
      "negative"
    else
      "mixed"
    end
  end
end

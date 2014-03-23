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
    #school should be identified up here - return from method call get_school
    reference_words = [] #SHOULD THIS BE GLOBAL?
    #extract helper method get_reference_words
    ReferenceWord.all.each do |reference_word|
      reference_words << reference_word.name
    end


    self.all.each do |post|
      ##For all the Analyzed posts in the database
      school = post.school
      ##Select the school associated with the post
      ratings = {}
      post.keywords.each do |keyword|
        ##Select the keywords associated with that analyzed post 
        if reference_words.index(keyword.text.downcase)
          ##we should downcase the text of the keyword on initialization
          ##does the keyword match any of the reference words we have in our database?
          index = reference_words.index(keyword.text.downcase)
          lookup_reference_word = ReferenceWord.find_by_name(reference_words[index])
          reference_word_topic = lookup_reference_word.topic.name
          ##Look up the topic that this reference/key word belongs to
          if ratings.has_key?("#{reference_word_topic}")
            ratings[reference_word_topic].push(keyword)
            ##if we have already identified a topic as being present in the post
            ##add this keyword to the array that logs how many keywords reference that topic
          else
            ratings[reference_word_topic] = [keyword]
            ##if this word is for a new topic in the ratings hash
            ##create a new array value associated with the topic key
          end
        end
      end

      ratings.each do |topic, keyword_match|
        ##after ratings hash with key(topic) value(keyword) pairs has been populated
        ##do this for each pair within the hash
        topic_record = Topic.find_by_name(topic)
        ##Find the topic associated with this key
        school_rating = Rating.find_or_create_by(topic_id: topic_record.id, school_id: school.id)
        ##Find the rating associated with the topic and the school in question
        if keyword_match.length == 1
          #keyword_match is the array (value) associated with the topic (key) 
          school_rating.total_post_count += 1
          #if there is only one keyword in the array
          #increment the post count attribute on the rating associated with this school and topic
          # school_rating.save
          keyword = ratings[topic].first
          #the first keyword within the keyword_match array, which in this nested if loop, should only ever be one element long
          if keyword.confidence.abs > 0.15
            #if keyword is confident enough
            if keyword.sentiment == "positive"
              school_rating.positive_post_count += 1
            elsif keyword.sentiment == "negative"
              school_rating.negative_post_count += 1
            elsif keyword.sentiment == "neutral"
              school_rating.neutral_post_count += 1
            elsif keyword.sentiment == "mixed"
              school_rating.mixed_post_count += 1
            end
            #increment the sentiment count on that particular rating object associated with the topic and school
          end
            school_rating.save
            # binding.pry
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
    counts = {"positive_count" => 0, "negative_count" => 0, "neutral_count" => 0, "mixed_count" => 0}
    #we start out with a count of zero in each of our dispositions
    keywords_array.each do |keyword|
      #for each keyword in the array
      if keyword.sentiment == "positive"
        counts["positive_count"] += keyword.confidence.abs
      elsif keyword.sentiment == "negative"
        counts["negative_count"] += keyword.confidence.abs
      elsif keyword.sentiment == "neutral"
        counts["neutral_count"] += keyword.confidence.abs
      elsif keyword.sentiment == "mixed"
        counts["mixed_count"] += keyword.confidence.abs
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

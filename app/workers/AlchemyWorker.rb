require 'httparty'
require 'json'
require 'find'
require './app/workers/alchemyapi.rb'
require 'fileutils'


class AlchemyWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(5, 35) }

  def perform
    puts "in the alchemy call now"
    alchemyapi = AlchemyAPI.new()
    OriginalPost.all.each do |post|
    	alchemy_post_response = alchemyapi.sentiment('text', post.text)
	    overall_sentiment = get_overall_sentiment(alchemy_post_response)
	    new_post = AnalyzedPost.new(school_id: post.school_id, original_publish_time: post.original_publish_time, overall_sentiment: overall_sentiment)
	    if new_post.save
	      new_analyzed_posts << new_post
	      alchemy_keywords_response = alchemyapi.keywords('text', post.text, options = {"sentiment" => 1})
	      alchemy_keywords_response["keywords"].each do |keyword|
	        analysis = analyze_sentiment(keyword)
	        new_keyword = Keyword.new(text: keyword["text"], sentiment: analysis[:sentiment], confidence: analysis[:confidence], analyzed_post_id: new_post.id)
	        if new_keyword.save
	          new_analyzed_keywords << new_keyword
	        else
	          puts "keyword didn't pass validations:"
	          puts new_keyword.inspect
	        end
	      end
	    else
	      puts "analyzed post didn't pass validations"
	    end
	    post.destroy
	  end
  end

  def get_overall_sentiment(alchemy_post_response)
    if alchemy_post_response["docSentiment"]
      alchemy_post_response["docSentiment"]["type"]
    else
      "neutral"
    end
	end

	def analyze_sentiment(keyword)
	  if keyword["sentiment"]
	    {sentiment: keyword["sentiment"]["type"], confidence: keyword["sentiment"]["score"]}
	  else
	    {sentiment: "neutral", confidence: 0.0}
	  end
	end
end
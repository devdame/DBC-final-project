require 'httparty'
require 'json'
require 'find'
require 'fileutils'


class AlchemyWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly.minute_of_hour(5, 20, 35, 50) }

  def perform
    puts "in the alchemy call now"
    alchemyapi = AlchemyAPI.new()
    new_analyzed_posts = []
    new_analyzed_keywords = []
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
	  end
	  OriginalPost.destroy_all
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

require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

class AlchemyAPI

	#Setup the endpoints
	@@ENDPOINTS = {}
	@@ENDPOINTS['sentiment'] = {}
	@@ENDPOINTS['sentiment']['url'] = '/url/URLGetTextSentiment'
	@@ENDPOINTS['sentiment']['text'] = '/text/TextGetTextSentiment'
	@@ENDPOINTS['sentiment']['html'] = '/html/HTMLGetTextSentiment'
	@@ENDPOINTS['sentiment_targeted'] = {}
	@@ENDPOINTS['sentiment_targeted']['url'] = '/url/URLGetTargetedSentiment'
	@@ENDPOINTS['sentiment_targeted']['text'] = '/text/TextGetTargetedSentiment'
	@@ENDPOINTS['sentiment_targeted']['html'] = '/html/HTMLGetTargetedSentiment'
	@@ENDPOINTS['author'] = {}
	@@ENDPOINTS['author']['url'] = '/url/URLGetAuthor'
	@@ENDPOINTS['author']['html'] = '/html/HTMLGetAuthor'
	@@ENDPOINTS['keywords'] = {}
	@@ENDPOINTS['keywords']['url'] = '/url/URLGetRankedKeywords'
	@@ENDPOINTS['keywords']['text'] = '/text/TextGetRankedKeywords'
	@@ENDPOINTS['keywords']['html'] = '/html/HTMLGetRankedKeywords'
	@@ENDPOINTS['concepts'] = {}
	@@ENDPOINTS['concepts']['url'] = '/url/URLGetRankedConcepts'
	@@ENDPOINTS['concepts']['text'] = '/text/TextGetRankedConcepts'
	@@ENDPOINTS['concepts']['html'] = '/html/HTMLGetRankedConcepts'
	@@ENDPOINTS['entities'] = {}
	@@ENDPOINTS['entities']['url'] = '/url/URLGetRankedNamedEntities'
	@@ENDPOINTS['entities']['text'] = '/text/TextGetRankedNamedEntities'
	@@ENDPOINTS['entities']['html'] = '/html/HTMLGetRankedNamedEntities'
	@@ENDPOINTS['category'] = {}
	@@ENDPOINTS['category']['url']  = '/url/URLGetCategory'
	@@ENDPOINTS['category']['text'] = '/text/TextGetCategory'
	@@ENDPOINTS['category']['html'] = '/html/HTMLGetCategory'
	@@ENDPOINTS['relations'] = {}
	@@ENDPOINTS['relations']['url']  = '/url/URLGetRelations'
	@@ENDPOINTS['relations']['text'] = '/text/TextGetRelations'
	@@ENDPOINTS['relations']['html'] = '/html/HTMLGetRelations'
	@@ENDPOINTS['language'] = {}
	@@ENDPOINTS['language']['url']  = '/url/URLGetLanguage'
	@@ENDPOINTS['language']['text'] = '/text/TextGetLanguage'
	@@ENDPOINTS['language']['html'] = '/html/HTMLGetLanguage'
	@@ENDPOINTS['text'] = {}
	@@ENDPOINTS['text']['url']  = '/url/URLGetText'
	@@ENDPOINTS['text']['html'] = '/html/HTMLGetText'
	@@ENDPOINTS['text_raw'] = {}
	@@ENDPOINTS['text_raw']['url']  = '/url/URLGetRawText'
	@@ENDPOINTS['text_raw']['html'] = '/html/HTMLGetRawText'
	@@ENDPOINTS['title'] = {}
	@@ENDPOINTS['title']['url']  = '/url/URLGetTitle'
	@@ENDPOINTS['title']['html'] = '/html/HTMLGetTitle'
	@@ENDPOINTS['feeds'] = {}
	@@ENDPOINTS['feeds']['url']  = '/url/URLGetFeedLinks'
	@@ENDPOINTS['feeds']['html'] = '/html/HTMLGetFeedLinks'
	@@ENDPOINTS['microformats'] = {}
	@@ENDPOINTS['microformats']['url']  = '/url/URLGetMicroformatData'
	@@ENDPOINTS['microformats']['html'] = '/html/HTMLGetMicroformatData'
		
	@@BASE_URL = 'http://access.alchemyapi.com/calls'
	
	
	def initialize()
		key = ENV['ALCHEMY_KEY']
		puts key
	end

	def sentiment(flavor, data, options = {})
		unless @@ENDPOINTS['sentiment'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'sentiment analysis for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['sentiment'][flavor], options)
	end

	def sentiment_targeted(flavor, data, target, options = {})
		if target == '' || target == nil
			return { 'status'=>'ERROR', 'statusMessage'=>'targeted sentiment requires a non-null target' }
		end

		unless @@ENDPOINTS['sentiment_targeted'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'targeted sentiment analysis for ' + flavor + ' not available' }
		end

		#Add the URL encoded data and the target to the options and analyze
		options[flavor] = data
		options['target'] = target
		return analyze(@@ENDPOINTS['sentiment_targeted'][flavor], options)
	end

	def entities(flavor, data, options = {})
		unless @@ENDPOINTS['entities'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'entity extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['entities'][flavor], options)
	end

	def author(flavor, data, options = {})
		unless @@ENDPOINTS['author'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'author extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['author'][flavor], options)
	end

	def keywords(flavor, data, options = {})
		unless @@ENDPOINTS['keywords'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'keyword extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['keywords'][flavor], options)
	end

	def concepts(flavor, data, options = {})
		unless @@ENDPOINTS['concepts'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'concept tagging for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['concepts'][flavor], options)
	end

	def category(flavor, data, options = {})
		unless @@ENDPOINTS['category'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'text categorization for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['category'][flavor], options)
	end

	def relations(flavor, data, options = {})
		unless @@ENDPOINTS['relations'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'relation extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['relations'][flavor], options)
	end

	def language(flavor, data, options = {})
		unless @@ENDPOINTS['language'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'language detection for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['language'][flavor], options)
	end

	def text(flavor, data, options = {})
		unless @@ENDPOINTS['text'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'clean text extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['text'][flavor], options)
	end

	def text_raw(flavor, data, options = {})
		unless @@ENDPOINTS['text_raw'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'raw text extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['text_raw'][flavor], options)
	end

	def title(flavor, data, options = {})
		unless @@ENDPOINTS['title'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'title extraction for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['title'][flavor], options)
	end

	def microformats(flavor, data, options = {})
		unless @@ENDPOINTS['microformats'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'microformats parsing for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['microformats'][flavor], options)
	end

	def feeds(flavor, data, options = {})
		unless @@ENDPOINTS['feeds'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'feed detection for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['feeds'][flavor], options)
	end

	private

	def analyze(url, options)

		#Insert the base URL
		url = @@BASE_URL + url

		#Add the API key and set the output mode to JSON
		options['apikey'] = @apiKey
		options['outputMode'] = 'json'

		uri = URI.parse(url)
		req = Net::HTTP::Post.new(uri)
		req.set_form_data(options)

		# disable gzip encoding which blows up in Zlib due to Ruby 2.0 bug
		# otherwise you'll get Zlib::BufError: buffer error
    req['Accept-Encoding'] = 'identity'		
		
		#Fire off the HTTP request
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
    	http.request(req)
    end
    
		#parse and return the response
		return JSON.parse(res.body)
	end
end

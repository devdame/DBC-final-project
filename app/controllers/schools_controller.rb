class SchoolsController < ApplicationController

  def index
    @schools = School.all
    @topics = Topic.all
  end

  def schoolcompare
    if request.xhr?
      @school = School.find(params[:school_id])
      # p @school
      @ratings = Rating.all.where(school_id: @school.id)
      @topics = Topic.all
      @random_pie_number = rand(1000000)
      @random_bar_number = rand(1000000)
      # @topic = Topic.find(params[:id])
      # @ratings = Rating.all

      #a hash of the 10 most talked about topics at each school
      #####################################################General School Activity Info
      sorted_ratings = @ratings.order("total_post_count desc").limit(10)

      @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio, :neutral_social_ratio => @school.neutral_vibe_ratio}.to_json
      #####################################################
      ratings_holding = {"ratings_profile" => []}

    sorted_ratings.each do |rating|
      # p sorted_ratings
      # @holding["ratings_profile"] << {"rating_#{rating.id}" => {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}}
      ratings_holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count, count: (rating.positive_post_count + rating.negative_post_count), multiplier: 3}
    end
    @ratings_profile = ratings_holding["ratings_profile"]
    p @ratings_profile
    #Post count and sentiment by topic and most popular words by topic for a particular school
    ##########################################
    school_data = {"school_topic_posts_count" => []}

    school_sorted_ratings = @ratings.order("total_post_count desc")

    @school.ratings.each_with_index do |rating, index|
      school_data["school_topic_posts_count"] << {school: rating.school.name, name: rating.topic.name, count: rating.total_post_count, positive_post_count: rating.positive_post_count, negative_post_count: rating.negative_post_count, neutral_post_count: rating.neutral_post_count, mixed_post_count: rating.mixed_post_count, top_twenty_topic_words: []}
      popular_words = []
      school_words = SchoolWordCount.where(school_id: @school.id, topic_id: rating.topic.id).all
      school_words.each do |word|
        popular_words << {name: word.reference_word.name, count: word.word_count, positive_word_count: word.positive_word_count, negative_word_count: word.negative_word_count, mixed_word_count: word.mixed_word_count, neutral_word_count: word.neutral_word_count, multiplier: 30}
      end
      top_twenty = popular_words.sort{|least_popular,most_popular| most_popular[:count] <=> least_popular[:count]}
      top_twenty.first(20).each do |popular_word_hash|
        school_data["school_topic_posts_count"][index][:top_twenty_topic_words] << popular_word_hash
      end
      popular_words = []
    end
    @all_school_data = school_data["school_topic_posts_count"]

      if params[:school_id] == "1"
        render "_school_compare", :layout => false
      elsif params[:school_id] == "2"
        render "_school_compare", :layout => false
      elsif params[:school_id] == "3"
        render "_school_compare", :layout => false
      elsif params[:school_id] == "4"
        render "_school_compare", :layout => false
      elsif params[:school_id] == "5"
        render "_school_compare", :layout => false
      end
      puts "Hello, I got here!"
    else
      render "_sadffsdadfs"
    end

  end

  def compare

  end

  def show
    @school = School.find(params[:id])
    @ratings = Rating.all.where(school_id: @school.id)
    @topics = Topic.all
    # @topic = Topic.find(params[:id])
    # @ratings = Rating.all

    #a hash of the 10 most talked about topics at each school
    #####################################################General School Activity Info
    sorted_ratings = @ratings.order("total_post_count desc")

    @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio, :neutral_social_ratio => @school.neutral_vibe_ratio}.to_json
    #####################################################
    ratings_holding = {"ratings_profile" => []}

    sorted_ratings.each do |rating|
      # p sorted_ratings
      # @holding["ratings_profile"] << {"rating_#{rating.id}" => {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}}
      ratings_holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count, count: (rating.positive_post_count + rating.negative_post_count), multiplier: 3}
    end
    @ratings_profile = ratings_holding["ratings_profile"]
    p @ratings_profile
    #Post count and sentiment by topic and most popular words by topic for a particular school
    ##########################################
    school_data = {"school_topic_posts_count" => []}

    school_sorted_ratings = @ratings.order("total_post_count desc")
    # p school_sorted_ratings
    @school.ratings.each_with_index do |rating, index|
      # puts "------------------------------------------"
      school_data["school_topic_posts_count"] << {school: rating.school.name, name: rating.topic.name, count: rating.total_post_count, positive_post_count: rating.positive_post_count, negative_post_count: rating.negative_post_count, neutral_post_count: rating.neutral_post_count, mixed_post_count: rating.mixed_post_count, top_twenty_topic_words: []}
      # puts school_data
      popular_words = []
      # puts "======================================="
      # puts rating.topic
      # ++++++++++++++
      school_words = SchoolWordCount.where(school_id: @school.id, topic_id: rating.topic.id).all
      # p school_words
      school_words.each do |word|
        # p topic
        # popular_word = SchoolWordCount.find_by_school_id_and_topic_id(@school.id, rating.topic.id)
        # p popular_word
        popular_words << {name: word.reference_word.name, count: word.word_count, positive_word_count: word.positive_word_count, negative_word_count: word.negative_word_count, mixed_word_count: word.mixed_word_count, neutral_word_count: word.neutral_word_count, multiplier: 30}
      end
      # +++++++++++++++
      # reference_words = rating.topic.reference_words.all
      # reference_words.each do |word|
      #   # puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
      #   popular_word = SchoolWordCount.find_by_school_id_and_reference_word_id(@school.id, word.id)
      #   if popular_word
      #     popular_words << {name: popular_word.reference_word.name, count: popular_word.word_count, positive_word_count: popular_word.positive_word_count, negative_word_count: popular_word.negative_word_count, mixed_word_count: popular_word.mixed_word_count, neutral_word_count: popular_word.neutral_word_count, multiplier: 30}
      #     # topics_count_holding["school_topic_posts_count"][index][:top_ten_topic_words] << {name: popular_word.reference_word.name, count: popular_word.word_count, positive_word_count: popular_word.positive_word_count, negative_word_count: popular_word.negative_word_count, mixed_word_count: popular_word.mixed_word_count, neutral_word_count: popular_word.neutral_word_count, multiplier: 30}
      #   end
      # end
      # puts "---------------------------"
      # p popular_words
      top_twenty = popular_words.sort{|least_popular,most_popular| most_popular[:count] <=> least_popular[:count]}
      top_twenty.first(20).each do |popular_word_hash|
        school_data["school_topic_posts_count"][index][:top_twenty_topic_words] << popular_word_hash
      end
      popular_words = []
    end
    # p school_data
    @all_school_data = school_data["school_topic_posts_count"]
    # p @all_school_data
      # rating.topic.reference_words.each do |reference_word|
      #   top_ten_school_word_counts = []
      #   SchoolWordCount.where(school_id: @school.id, reference_word_id: reference_word.id).order('word_count desc').limit(10)
      #   p top_ten_school_word_counts
      #   top_ten_school_word_counts.each do |keyword|
      #     topics_count_holding["school_topic_posts_count"][index][:top_ten_topic_words] << {name: keyword.reference_word.name, word_count: keyword.word_count, positive_word_count: keyword.positive_word_count, negative_word_count: keyword.negative_word_count, mixed_word_count: keyword.mixed_word_count, neutral_word_count: keyword.neutral_word_count}
      #   end
    #####################################################This school's activity by topic
  end

end

class SchoolsController < ApplicationController

  def index
    @schools = School.all
    @topics = Topic.all
  end

  def schoolcompare
    
    if request.xhr?
      @school = School.find(params[:school_id])
      @ratings = Rating.all.where(school_id: @school.id)
      @topics = Topic.all
      @random_pie_number = rand(1000000)
      @random_bar_number = rand(1000000)

      #General School Vibe Info      
      ##########################################

      @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio, :neutral_social_ratio => @school.neutral_vibe_ratio}.to_json
      
      ##########################################

      #a hash of the 10 most talked about topics at each school
      ##########################################
      
      ratings_holding = {"ratings_profile" => []}
      
      sorted_ratings = @ratings.order("total_post_count desc").limit(10)

      sorted_ratings.each do |rating|
        ratings_holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count, count: (rating.positive_post_count + rating.negative_post_count), multiplier: 3}
      end
      @ratings_profile = ratings_holding["ratings_profile"]

      ##########################################
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
    else
      redirect_to schools_path
    end

  end

  def compare

  end

  def show
    @school = School.find(params[:id])
    @ratings = Rating.all.where(school_id: @school.id)
    @topics = Topic.all  
    
    #General School Vibe Info
    ##########################################
    
    @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio, :neutral_social_ratio => @school.neutral_vibe_ratio}.to_json

    ##########################################

    
    #A hash of the 10 most talked about topics at each school
    ##########################################
    ratings_holding = {"ratings_profile" => []}

    sorted_ratings = @ratings.order("total_post_count desc")

    sorted_ratings.each do |rating|
      ratings_holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count, count: (rating.positive_post_count + rating.negative_post_count)}
    end
    @ratings_profile = ratings_holding["ratings_profile"]

    ##########################################

    
    #All School Data
    ##########################################
    # school_data = {"school_topic_posts_count" => []}

    # school_sorted_ratings = @ratings.order("total_post_count desc")

    # @school.ratings.each_with_index do |rating, index|
    #   school_data["school_topic_posts_count"] << {school: rating.school.name, name: rating.topic.name, count: rating.total_post_count, positive_post_count: rating.positive_post_count, negative_post_count: rating.negative_post_count, neutral_post_count: rating.neutral_post_count, mixed_post_count: rating.mixed_post_count, top_twenty_topic_words: []}
    #   popular_words = []
    #   school_words = SchoolWordCount.where(school_id: @school.id, topic_id: rating.topic.id).all
    #   school_words.each do |word|
    #     popular_words << {name: word.reference_word.name, count: word.word_count, positive_word_count: word.positive_word_count, negative_word_count: word.negative_word_count, mixed_word_count: word.mixed_word_count, neutral_word_count: word.neutral_word_count, multiplier: 30}
    #   end
    #   top_twenty = popular_words.sort{|least_popular,most_popular| most_popular[:count] <=> least_popular[:count]}
    #   top_twenty.first(20).each do |popular_word_hash|
    #     school_data["school_topic_posts_count"][index][:top_twenty_topic_words] << popular_word_hash
    #   end
    #   popular_words = []
    # end
    # @all_school_data = school_data["school_topic_posts_count"]
    ##########################################
  end

end

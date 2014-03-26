class SchoolsController < ApplicationController

  def index
    @schools = School.all
    @topics = Topic.all
  end

  def compare
    # http://localhost:3000/compare?school_one_id=1&school_two_id=4
    @school_one = School.find(params[:school_one_id])
    @school_two = School.find(params[:school_two_id])
  end

  def show
    @school = School.find(params[:id])
    # @topics = Topic.all
    @ratings = Rating.all.where(school_id: @school.id)

    # @topic = Topic.find(params[:id])
    # @ratings = Rating.all

    ##########################################

    #Most Popular Words in Topic

    school_data = {"school_topic_posts_count" => []}


    @school.ratings.each_with_index do |rating, index|
      # puts "------------------------------------------"
      school_data["school_topic_posts_count"] << {school: rating.school.name, topic_name: rating.topic.name, total_post_count: rating.total_post_count, positive_post_count: rating.positive_post_count, negative_post_count: rating.negative_post_count, neutral_post_count: rating.neutral_post_count, mixed_post_count: rating.mixed_post_count, top_ten_topic_words: []}
      puts school_data
      popular_words = []
      # puts "======================================="
      puts rating.topic
      reference_words = rating.topic.reference_words.all
      reference_words.each do |word|
        # puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        popular_word = SchoolWordCount.find_by(reference_word_id: word.id)
        if popular_word
          popular_words << {name: popular_word.reference_word.name, count: popular_word.word_count, positive_word_count: popular_word.positive_word_count, negative_word_count: popular_word.negative_word_count, mixed_word_count: popular_word.mixed_word_count, neutral_word_count: popular_word.neutral_word_count, multiplier: 30}
          # topics_count_holding["school_topic_posts_count"][index][:top_ten_topic_words] << {name: popular_word.reference_word.name, count: popular_word.word_count, positive_word_count: popular_word.positive_word_count, negative_word_count: popular_word.negative_word_count, mixed_word_count: popular_word.mixed_word_count, neutral_word_count: popular_word.neutral_word_count, multiplier: 30}
        end
      end
      # puts "---------------------------"
      # p popular_words
      top_ten = popular_words.sort{|a,b| b[:count] <=> a[:count]}
      top_ten.first(10).each do |popular_word_hash|
        school_data["school_topic_posts_count"][index][:top_ten_topic_words] << popular_word_hash
      end
      popular_words = []
    end
    @all_school_data = school_data["school_topics_post_count"]
    # p @all_school_data
      # rating.topic.reference_words.each do |reference_word|
      #   top_ten_school_word_counts = []
      #   SchoolWordCount.where(school_id: @school.id, reference_word_id: reference_word.id).order('word_count desc').limit(10)
      #   p top_ten_school_word_counts
      #   top_ten_school_word_counts.each do |keyword|
      #     topics_count_holding["school_topic_posts_count"][index][:top_ten_topic_words] << {name: keyword.reference_word.name, word_count: keyword.word_count, positive_word_count: keyword.positive_word_count, negative_word_count: keyword.negative_word_count, mixed_word_count: keyword.mixed_word_count, neutral_word_count: keyword.neutral_word_count}
      #   end
    #####################################################This school's activity by topic
    # SchoolWordCount.all.each do |topic|
    #   SchoolWordCount.where(school_id: @school.id, reference_word_id:
    # SchoolWordCount.each
    # p SchoolWordCount.where(school_id: @school.id).order('word_count desc').limit(190).count
    ###########################################

    # p @school_word_counts

       #a hash of the 10 most talked about topics at each school
    #####################################################General School Activity Info
    sorted_ratings = @ratings.order("total_post_count desc").limit(10)

    @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio}.to_json

    ratings_holding = {"ratings_profile" => []}

    sorted_ratings.each do |rating|
      # p sorted_ratings
      # @holding["ratings_profile"] << {"rating_#{rating.id}" => {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}}
      ratings_holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}
    end
    @ratings_profile = ratings_holding["ratings_profile"]

    #####################################################This school's activity by topic
    topics_count_holding = {"school_topic_posts_count" => []}

    @school.ratings.each do |rating|
      topics_count_holding["school_topic_posts_count"] << {school: rating.school.name, topic_name: rating.topic.name, total_post_count: rating.total_post_count, positive_post_count: rating.positive_post_count, negative_post_count: rating.negative_post_count, neutral_post_count: rating.neutral_post_count, mixed_post_count: rating.mixed_post_count}
    end
    @school_topics_activity = topics_count_holding["school_topic_posts_count"]

    #####################################################This school's activity by topic
  end

end

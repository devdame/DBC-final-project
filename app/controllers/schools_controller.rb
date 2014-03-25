require 'json'

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
    @topics = Topic.all
    @ratings = Rating.all.where(school_id: @school.id)
    social_media_profile = {:total_social_ratio => @school.social_media_activity,
      :positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio,
      :mixed_social_ratio => @school.mixed_vibe_ratio, :neutral_social_ratio => @school.neutral_vibe_ratio}
    @social_media_activity = social_media_activity.to_json
       #a hash of the 10 most talked about topics at each school
    sorted_ratings = @ratings.order("total_post_count desc").limit(10)





    #####################################################Send info to front
    @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio}.to_json

    holding = {"ratings_profile" => []}

    sorted_ratings.each do |rating|
      # p sorted_ratings
      # @holding["ratings_profile"] << {"rating_#{rating.id}" => {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}}
      holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}
    end
    @ratings_profile = holding["ratings_profile"]

  end
end

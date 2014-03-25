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
       #a hash of the 10 most talked about topics at each school
    sorted_ratings = @ratings.order("total_post_count desc").limit(10)





    #####################################################Send info to front
    @social_media_profile = {:positive_social_ratio => @school.positive_vibe_ratio, :negative_social_ratio => @school.negative_vibe_ratio}.to_json

    holding = {"ratings_profile" => []}

    sorted_ratings.each do |rating|
      # p sorted_ratings
      # @holding["ratings_profile"] << {"rating_#{rating.id}" => {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count}}
      holding["ratings_profile"] << {name: rating.topic.name, positive_count: rating.positive_post_count, negative_count: rating.negative_post_count, count: (rating.positive_post_count + rating.negative_post_count), multiplier: 3}
    end
    @ratings_profile = holding["ratings_profile"]
  end
end

require 'json'

class SchoolsController < ApplicationController

  def index
    @schools = School.all
    @topics = Topic.all
  end

  def compare
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
  end
end

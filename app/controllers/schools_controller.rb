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
  end
end

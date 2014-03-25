class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])


    ##########################################

    #Most Popular Words in Topic
    # holding = {"popular_words"}

    reference_words = @topic.reference_words.all
    @popular_words = []
    reference_words.each do |word|
      @popular_words << SchoolWordCount.find_by(reference_word_id: word.id)
    end
  end

end

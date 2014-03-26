class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @ratings = Rating.all

    ##########################################

    #Most Popular Words in Topic
    holding = {"popular_words" => []}

    reference_words = @topic.reference_words.all
    reference_words.each do |word|
      pop_word = SchoolWordCount.find_by(reference_word_id: word.id)
      if pop_word
        holding["popular_words"] << {name: pop_word.reference_word.name, count: pop_word.word_count, multiplier: 30}
      end
    end
    @popular_words = holding["popular_words"]


    #########################

    #School Total Post Activity in a topic
    #To use in a vertical bar chart or pie chart, but is not working in a reasonable amount of time tonight
    holding2 = {"ratings_by_school" => []}
    ratings_by_school = @ratings.where(topic_id: @topic.id).all
    ratings_by_school.each do |rating|
      if rating
        holding2["ratings_by_school"] << {name: rating.school.name, count: rating.total_post_count, multiplier: 15}
      end
    end
    @ratings_by_school = holding2["ratings_by_school"]
  end
end

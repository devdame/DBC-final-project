class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @ratings = Rating.all

    #Most Popular Words in Topic
    ##########################################

    holding = {"popular_words" => []}

    reference_words = @topic.reference_words
    reference_words.each do |word|
      pop_word = SchoolWordCount.find_by(reference_word_id: word.id)
      if pop_word
        holding["popular_words"] << {name: pop_word.reference_word.name, positive_count: pop_word.positive_word_count, negative_count: pop_word.negative_word_count}
      end
    end
    @popular_words = holding["popular_words"]


    ##########################################


    #School Total Post Activity in a topic
    ##########################################
    #To use in a vertical bar chart or pie chart, but is not working in a reasonable amount of time tonight
    holding_two = {"ratings_by_school" => []}
    ratings_by_school = @ratings.where(topic_id: @topic.id).all
    ratings_by_school.each do |rating|
      if rating
        holding_two["ratings_by_school"] << {name: rating.school.name, count: rating.total_post_count}
      end
    end
    @ratings_by_school = holding_two["ratings_by_school"]
  end


  ##########################################
end

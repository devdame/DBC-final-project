class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])


    ##########################################

    #Most Popular Words in Topic
    holding = {"popular_words" => []}

    reference_words = @topic.reference_words.all
    @popular_words = []
    reference_words.each do |word|
      pop_word = SchoolWordCount.find_by(reference_word_id: word.id)
      if pop_word
        holding["popular_words"] << {name: pop_word.reference_word.name, count: pop_word.word_count, multiplier: 30}
      end
    end
    @popular_words = holding["popular_words"]
  end

end

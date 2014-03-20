require 'spec_helper'

describe Topic do

  context "initialization" do

    let(:topic) {Topic.create}

    it "should exist" do
      expect(topic).to be_an_instance_of Topic
    end

    it "should be able to access its reference words" do
      topic.reference_words << ReferenceWord.create
      expect(topic.reference_words.count).to eq 1
      expect(topic.reference_words.first).to be_an_instance_of ReferenceWord
    end

    it "should be able to access its ratings" do
      rating = Rating.create(topic_id: topic.id)
      expect(topic.ratings.count).to eq 1
      expect(topic.ratings.first).to be_an_instance_of Rating
    end

  end



end

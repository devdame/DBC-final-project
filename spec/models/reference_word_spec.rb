require 'spec_helper'

describe ReferenceWord do

  context "initialization" do
    it "should exist" do
      reference_word = ReferenceWord.create();
      expect(reference_word).to be_an_instance_of ReferenceWord
    end

    it "should be able to access its topic" do
      topic = Topic.create
      word = ReferenceWord.create(topic_id: topic.id)
      expect(word.topic).to eq topic
    end

  end

end

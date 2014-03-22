require 'spec_helper'

describe Topic do

  let(:topic) {Topic.create(name: "Academics")}

  context "initialization" do
    it "should exist" do
      expect(topic).to be_an_instance_of Topic
    end
  end

  context "basic validations" do
    it "should have a name" do
      topic.name.should_not be_nil
    end

    it "should have a unique name" do
      topic_duplicate = Topic.create(name: "Academics")
      expect(Topic.all.count).to eq 1
    end
  end

  context "basic associations" do
    it "should be able to access its reference words" do
      ReferenceWord.create(topic_id: topic.id, name: "study")
      expect(topic.reference_words.count).to eq 1
      expect(topic.reference_words.first).to be_an_instance_of ReferenceWord
    end

    it "should be able to access its ratings" do
      rating = Rating.create(topic_id: topic.id, school_id: 1)
      expect(topic.ratings.count).to eq 1
      expect(topic.ratings.first).to be_an_instance_of Rating
    end
  end

end

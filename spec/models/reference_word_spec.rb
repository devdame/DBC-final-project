require 'spec_helper'

describe ReferenceWord do

  let(:topic) {Topic.create(name: "Social")}
  let(:reference_word) {ReferenceWord.create(topic_id: topic.id, name: "party")}

  context "initialization" do
    it "should exist" do
      expect(reference_word).to be_an_instance_of ReferenceWord
    end
  end

  context "basic validations" do
    it "should have a name" do
      reference_word.name.should_not be_nil
    end

    it "should have a topic id" do
      reference_word.topic_id.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its topic" do
      expect(reference_word.topic).to eq topic
    end
  end

end

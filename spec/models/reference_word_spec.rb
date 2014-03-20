require 'spec_helper'

describe ReferenceWord do

  context "initialization" do

    let(:reference_word) {ReferenceWord.create(topic_id: 1, name: "party")}
    it "should exist" do
      expect(reference_word).to be_an_instance_of ReferenceWord
    end

    it "should be able to access its topic" do
      topic = Topic.create(name: "Social")
      expect(reference_word.topic).to eq topic
    end

  end

end

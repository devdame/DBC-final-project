require 'spec_helper'

describe ReferenceWord do

  context "initialization" do

    let(:topic) {Topic.create(name: "Social")}
    let(:reference_word) {ReferenceWord.create(topic_id: topic.id, name: "party")}

    it "should exist" do
      expect(reference_word).to be_an_instance_of ReferenceWord
    end

    it "should be able to access its topic" do
      expect(reference_word.topic).to eq topic
    end

  end

end

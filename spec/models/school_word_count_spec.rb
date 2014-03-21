require 'spec_helper'

describe ReferenceWord do

  context "initialization" do

    let(:school_word_count) {SchoolWordCount.create(school_id: 1, reference_word_id: 1)}

    it "should exist" do
      expect(school_word_count).to be_an_instance_of SchoolWordCount
    end

    it "should be able to access its school and reference word" do
      school = School.create(name: "PSU", most_recent_post_time: "2014-03-21 15:14:33")
      reference_word = ReferenceWord.create(name: "Drinking", topic_id: 1)
      school_word_count.school = school
      school_word_count.reference_word = reference_word
      expect(school_word_count.school).to eq school
      expect(school_word_count.reference_word).to eq reference_word
    end

  end

end

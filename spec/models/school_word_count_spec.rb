require 'spec_helper'

describe SchoolWordCount do

  let(:school_word_count) {SchoolWordCount.create(school_id: 1, reference_word_id: 1)}

  context "initialization" do
    it "should exist" do
      expect(school_word_count).to be_an_instance_of SchoolWordCount
    end
  end

  context "basic validations" do
    it "should belong to a school" do
      school_word_count.school_id.should_not be_nil
    end

    it "should belong to a reference word" do
      school_word_count.reference_word_id.should_not be_nil
    end
  end

  context "basic associations" do
    it "should be able to access its school and reference word" do
      school = School.create(name: "PSu", student_body_count: 53_297, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "168734")
      reference_word = ReferenceWord.create(name: "Drinking", topic_id: 1)
      school_word_count.school = school
      school_word_count.reference_word = reference_word
      expect(school_word_count.school).to eq school
      expect(school_word_count.reference_word).to eq reference_word
    end
  end

end

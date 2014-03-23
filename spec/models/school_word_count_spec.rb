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

  context "activity ratio methods" do
    let(:rating) {Rating.create(topic_id: 1, school_id: 1, total_post_count: 10_000, positive_post_count: 3_000, negative_post_count: 1_250, neutral_post_count: 1_000, mixed_post_count: 600)}

    it "should calculate how much the word is talked about in relation to total posts at school" do
      school = School.create(name: "UGA", student_body_count: 43_297, post_count: 50_000, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "2985734")
      rating.school = school
      expect(rating.topic_activity_ratio).to eq 0.2
    end

    it "should calculate the pos/total sentiment ratio of this topic at this school" do
      expect(rating.topic_positivity_ratio).to eq 0.3
    end

    it "should calculate the neg/total sentiment ratio of this topic at this school" do
      expect(rating.topic_negativity_ratio).to eq 0.125
    end

    it "should calculate the neutral/total sentiment ratio of this topic at this school" do
      expect(rating.topic_neutral_ratio).to eq 0.1
    end

    it "should calculate the mixed/total sentiment ratio of this topic at this school" do
      expect(rating.topic_mixed_ratio).to eq 0.06
    end

  end

end

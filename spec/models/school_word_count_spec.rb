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
      school = School.create(name: "PSU", student_body_count: 53_297, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "168734")
      reference_word = ReferenceWord.create(name: "Drinking", topic_id: 1)
      school_word_count.school = school
      school_word_count.reference_word = reference_word
      expect(school_word_count.school).to eq school
      expect(school_word_count.reference_word).to eq reference_word
    end
  end

  context "activity ratio methods" do
    let(:school_word_count) {SchoolWordCount.create(school_id: 1, reference_word_id: 1, word_count: 400, positive_word_count: 200, negative_word_count: 100, neutral_word_count: 50, mixed_word_count: 20)}

    it "should calculate how much the word is talked about in relation to total topic posts" do
      school = School.create(name: "UGA", student_body_count: 43_297, post_count: 50_000, first_post_time: "2014-03-21 12:14:33", most_recent_post_time: "2014-03-21 15:14:33", geofeedia_id: "2985734")
      topic = Topic.create(name: "Academics")
      rating = Rating.create(topic_id: topic.id, school_id: school.id, total_post_count: 10_000, positive_post_count: 3_000, negative_post_count: 1_250, neutral_post_count: 1_000, mixed_post_count: 600)
      reference_word = ReferenceWord.create(name: "study", topic_id: topic.id)
      school_word_count.school = school
      school_word_count.reference_word = reference_word

      expect(school_word_count.reference_word_activity_ratio).to eq 0.04
    end

    it "should calculate the pos/total sentiment ratio of this word for the topic" do
      expect(school_word_count.word_positivity_ratio).to eq 0.5
    end

    it "should calculate the neg/total sentiment ratio of this word for the topic" do
      expect(school_word_count.word_negativity_ratio).to eq 0.25
    end

    it "should calculate the neutral/total sentiment ratio of this word for the topic" do
      expect(school_word_count.word_neutral_ratio).to eq 0.125
    end

    it "should calculate the mixed/total sentiment ratio of this word for the topic" do
      expect(school_word_count.word_mixed_ratio).to eq 0.05
    end

  end

end

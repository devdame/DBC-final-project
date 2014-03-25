class Keyword < ActiveRecord::Base
  validates :analyzed_post_id, presence: true
  validates :text, presence: true
  validates :sentiment, presence: true
  validates :confidence, presence: true
  before_save :remove_spaces
  before_save :check_for_confidence

  belongs_to :analyzed_post

  @@reference_words = []


  def remove_spaces
    self.text = self.text.downcase.split(' ').join.gsub("#", "").gsub(/sohf\d{3}/, '')
  end

  def self.reference_words
    @@reference_words
  end


  def check_for_confidence
    self.confidence = 0.0 unless confidence
  end


  def self.populate_reference_words
    ReferenceWord.all.each do |reference_word|
      @@reference_words << reference_word.canonical_name
    end
  end


  def self.determine_keyword_confidence(keyword, counter)
    confidence = keyword.confidence
    if confidence == 0
      counter.neutral_word_count += 1
    elsif confidence > 0.1
      counter.positive_word_count += 1
    elsif confidence < -0.1
      counter.negative_word_count += 1
    else
      counter.mixed_word_count += 1
    end
  end


  def self.create_or_update_school_word_counts
    self.all.each do |keyword|
      text = keyword.text.downcase
      confidence = keyword.confidence
      # puts text
      # puts @@reference_words.inspect
      if @@reference_words.include?(text)
        lookup_reference_word = ReferenceWord.find_by_canonical_name(text)
        puts "lookup reference word:"
        puts lookup_reference_word
        counter = SchoolWordCount.where(school_id: keyword.analyzed_post.school_id, reference_word_id: lookup_reference_word.id).first_or_create
        counter.word_count += 1
        self.determine_keyword_confidence(keyword, counter)
        counter.save
      end
    end
  end
end

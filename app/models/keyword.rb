class Keyword < ActiveRecord::Base
  validates :analyzed_post_id, presence: true
  validates :text, presence: true
  validates :sentiment, presence: true
  validates :confidence, presence: true
  before_save :remove_spaces
  before_save :check_for_confidence

  belongs_to :analyzed_post


  def remove_spaces
    self.text = self.text.downcase.split(' ').join.gsub("#", "").gsub(/sohf\d{3}/, '')
  end


  def check_for_confidence
    self.confidence = 0 unless confidence
  end


  def self.find_reference_words
    reference_words = []
    ReferenceWord.all.each do |reference_word|
      reference_words << reference_word.name
    end
    reference_words
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
    reference_words = self.find_reference_words
    self.all.each do |keyword|
      text = keyword.text.downcase
      confidence = keyword.confidence
      if reference_words.include?(text)
        lookup_reference_word = ReferenceWord.find_by_name(text)
        counter = SchoolWordCount.find_or_create_by(school_id: keyword.analyzed_post.school_id, reference_word_id: lookup_reference_word.id)
        counter.word_count += 1
        self.determine_keyword_confidence(keyword, counter)
        counter.save
      end
    end
  end
end

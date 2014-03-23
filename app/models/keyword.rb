class Keyword < ActiveRecord::Base
  validates :analyzed_post_id, presence: true
  validates :text, presence: true
  validates :sentiment, presence: true
  validates :confidence, presence: true

  belongs_to :analyzed_post


  def self.create_or_update_school_word_counts

    reference_words = [] #SHOULD THIS BE GLOBAL?
    ReferenceWord.all.each do |reference_word|
      reference_words << reference_word.name
    end

    self.all.each do |keyword|
      if keyword.confidence.abs > 0.15
        if reference_words.index(keyword.text.downcase)
          index = reference_words.index(keyword.text.downcase)
          lookup_reference_word = ReferenceWord.find_by_name(reference_words[index])
          school_word_count = SchoolWordCount.where(school_id: keyword.analyzed_post.school_id, reference_word_id: lookup_reference_word.id).first_or_create
          if keyword.sentiment == "positive"
            school_word_count.word_count += 1
            school_word_count.positive_word_count += 1
          elsif keyword.sentiment == "negative"
            school_word_count.word_count += 1
            school_word_count.negative_word_count += 1
          elsif keyword.sentiment == "neutral"
            school_word_count.word_count += 1
            school_word_count.neutral_word_count += 1
          elsif keyword.sentiment == "mixed"
            school_word_count.word_count += 1
            school_word_count.mixed_word_count += 1
          end
            school_word_count.save
        end
      end
    end
  end


end

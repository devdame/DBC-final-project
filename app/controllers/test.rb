def create_school_word_counts

  reference_words = [] SHOULD THIS BE GLOBAL?
  ReferenceWord.all.each do |reference_word|
    reference_words << reference_word
  end

  Keyword.all.each do |keyword|
    if keyword.confidence > 0.2
      if reference_words.index(keyword.text)
        index = reference_words.index(keyword.text)
        lookup_reference_word = ReferenceWord.find_by_name(reference_words[index])
        new_school_word_count = SchoolWordCount.create(school_id: keyword.analyzed_post[0].school_id, reference_word_id: lookup_reference_word.id)
        if keyword.sentiment == "positive"
          new_school_word_count.word_count += 1
          new_school_word_count.positive_word_count += 1
        elsif keyword.sentiment == "negative"
          new_school_word_count.word_count += 1
          new_school_word_count.negative_word_count += 1
        elsif keyword.sentiment == "neutral"
          new_school_word_count.word_count += 1
          new_school_word_count.neutral_word_count += 1
        elsif keyword.sentiment == "mixed"
          new_school_word_count.word_count += 1
          new_school_word_count.mixed_word_count += 1
        end
      end
    end
  end
end

def increment_school_ratings
  AnalyzedPost.all.each do |post|
    school = School.find(post.school_id)
    aggregate_keywords(post)
    if aggregated_keywords_data[-1] < 0.4
      ratings.mixed_post_count += 1
    elsif aggregated_keywords_data[0] == "positive_count"
      ratings.positive_post_count += 1
    elsif aggregated_keywords_data[0] == "negative_count"
      ratings.negative_post_count += 1
    elsif aggregated_keywords_data[0] == "neutral_count"
      ratings.neutral_post_count += 1
    elsif aggregated_keywords_data[0] == "mixed_count"
      ratings.mixed_count += 1
  end
end

def aggregate_keywords(analyzed_post)
  counts = {"positive_count" => 0, "negative_count" => 0, "neutral_count" => 0, "mixed_count" => 0}
  analyzed_post.keywords.each do |keyword|
    if keyword.sentiment == "positive"
      counts[0] += keyword.confidence
    elsif keyword.sentiment == "negative"
      counts[1] += keyword.confidence
    elsif keyword.sentiment == "neutral"
      counts[2] += keyword.confidence
    elsif keyword.sentiment == "mixed"
      counts[3] += keyword.confidence
    end
  end
  positive_negative_difference = (counts[positive_count] - counts[negative_count]).abs
  greatest_count = counts.max_by{|k,v| v}.first
  aggregated_keywords_data = [greatest_count, positive_negative_difference]
end

def increment_school_word_count
  AnalyzedPost.all.each do |post|
    school = School.find(post.school_id)
    if post.overall_sentiment == "positive"
      school.post_count += 1
      school.positive_post_count += 1
    elsif post.overall_sentiment == "negative"
      school.post_count += 1
      school.positive_post_count += 1
    elsif post.overall_sentiment == "neutral"
      school.post_count += 1
      school.neutral_post_count += 1
    elsif post.overall_sentiment == "mixed"
      school.post_count += 1
      school.mixed_word_count += 1
    end
  end

end






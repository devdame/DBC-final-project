require './alchemyapi.rb'

alchemyapi = AlchemyAPI.new()

puts '############################################'
puts '#  Keyword extraction                      #'
puts '############################################'
puts ''
puts ''
puts 'Processing text: '
puts ''

##

json = File.read('../db/seeds/uofm32206_3_20_1342.json')
parsed = JSON.parse(json)

sample_data = []

parsed["items"].each do |item|
  sample_data << item["title"]
end

sample_data
sample_selection = sample_data.sample(10)


sample_selection.each do |sample|

  puts ''
  puts ''
  puts ''
  puts '############################################'
  puts '#  Keyword extraction                      #'
  puts '############################################'
  puts ''
  puts ''
  puts 'Processing text: '
  puts ''

  puts "Sample Text = #{sample}"
  ##

  response = alchemyapi.keywords('text', sample, { 'sentiment'=>1 })

  if response['status'] == 'OK'
    puts '## Response Object ##'
    puts JSON.pretty_generate(response)


    puts ''
    puts '## Keywords ##'
    for keyword in response['keywords']
      puts 'text: ' + keyword['text']
      puts 'relevance: ' + keyword['relevance']
      print 'sentiment: ' + keyword['sentiment']['type'] 
      

      #Make sure score exists (it's not returned for neutral sentiment
      if keyword['sentiment'].key?('score')
        print ' (' + keyword['sentiment']['score'] + ')'
      end

      puts ''
    end
  else
    puts 'Error in keyword extraction call: ' + response['statusInfo']
  end


  puts ''
  puts ''
  puts ''
  puts '############################################'
  puts '#   Sentiment Analysis                     #'
  puts '############################################'
  puts ''
  puts ''

  puts 'Processing text: ' + sample
  puts ''

  response = alchemyapi.sentiment('text', sample)

  if response['status'] == 'OK'
    puts '## Response Object ##'
    puts JSON.pretty_generate(response)


    puts ''
    puts '## Document Sentiment ##'
    puts 'type: ' + response['docSentiment']['type']
    
    #Make sure score exists (it's not returned for neutral sentiment
    if response['docSentiment'].key?('score')
      puts 'score: ' + response['docSentiment']['score']
    end
  else
    puts 'Error in sentiment analysis call: ' + response['statusInfo']
  end

end

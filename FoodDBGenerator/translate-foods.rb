require 'http'
require 'json'
require 'nokogiri'

while line = gets
  STDERR.puts "Processing the line of: #{line}"

  words = line.split
  english_names = words.map do |word|
    params = { key: 'AIzaSyDtw-0OMtA-RCuD3JkpTC1jqyHBI-g1qyE', source: 'ja', target: 'en', q: word }
    response = HTTP.get("https://www.googleapis.com/language/translate/v2", params: params)
    JSON.load(response.body)['data']['translations'][0]['translatedText']
  end

  puts words.join('&') + '&&' + english_names.join('&')
end

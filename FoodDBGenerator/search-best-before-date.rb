require 'http'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'chronic'
require 'pry'

STILL_TASTY_SEARCH_URL_BASE = 'http://stilltasty.com/searchitems/search/'
STILL_TASTY_INDEX_URL_BASE = 'http://stilltasty.com/fooditems/index/'

while line = gets
  jnames, enames = line.chomp.split('&&').map { |words| words.split('&') }
  best_before_dates = []

  STDERR.puts "Processing the line of: #{line}"

  enames.map do |name|
    begin
      open(STILL_TASTY_SEARCH_URL_BASE + name) do |f|
        search_result_doc = Nokogiri::HTML.parse(f.read, nil, f.charset)

        search_result_doc.search('.categorySearch a').each do |node|
          label = node.children.first.text
          link = node.attributes['href'].value

          if label =~ /FRESH, RAW/
            open(link) do |f_|
              index_doc = Nokogiri::HTML.parse(f_.read, nil, f_.charset)

              index_doc.search('.slicedMainLeft').each do |sliced_main_left|
                how_to_save = sliced_main_left.search('span').first.children.first.text
                days = sliced_main_left.next_sibling.next_sibling.search('.days').first.children.first.text

                best_before_dates << days if how_to_save =~ /Refrigerator/
              end
            end
          end
        end
      end
    rescue => e
      STDERR.puts "\tPage not found: #{name}"
    end
  end

  puts jnames.join('&') + '&&' + enames.join('&') + '&&' + best_before_dates.join('&')
end

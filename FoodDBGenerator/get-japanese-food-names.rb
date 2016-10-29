# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'
require 'open-uri'
require 'pry'

url = 'http://shoku-joho.com/jiten/?page_id=1185'

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)

def to_katakana(s)
  s.tr('ぁ-ん','ァ-ン')
end

def to_hiragana(s)
  s.tr('ァ-ン', 'ぁ-ん')
end

def toggle_hiragana_katakana(s)
  return to_katakana(s) if s != to_katakana(s)
  return to_hiragana(s) if s != to_hiragana(s)
end

doc.search('.ichi04p > a').each do |node|
  synonyms = node.inner_text.split(/[（,）]/).reject { |word| word == "" }
  synonyms = [ synonyms + synonyms.map { |word| toggle_hiragana_katakana(word) } ].flatten.uniq.compact

  puts synonyms.join(' ')
end

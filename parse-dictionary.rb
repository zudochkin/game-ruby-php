# coding: utf-8

require 'mongo'
require 'mongo_mapper'

MongoMapper.database = 'words'

class Word
  include MongoMapper::Document

  key :word
  key :word2
end

f = File.open('./dic.txt', 'r')

# цикл по всем строкам словаря
f.lines.each do |line|
  word, word2 = line.split('#') # отделяем первое слово
  word2 = word2.split('%')[0] # и второе
  puts "#{word} #{word2}\n"
  
  # и сохраняем его
  Word.create(
    :word => word,
    :word2 => word2
  )
end
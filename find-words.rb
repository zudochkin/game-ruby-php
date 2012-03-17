# encoding: utf-8

require 'mongo'
require 'mongo_mapper'

MongoMapper.database = 'words'

class Word
  include MongoMapper::Document

  key :word
  key :word2
end

# файл с полученным в предыдущих шагах комбинациями
COMBINATIONS_FILE = './combinations.dat'
# файл с результатами
OUTPUT_FILE = './results.dat'

# наше игровое поле
alphabet = %w{
  к о ж
  а п у
  а р р
}

# поиск текущего слова в словаре
def find_a_word(word)
  w = Word.where(:word => word).first
  if w
    return w.word
  else
    return nil
  end
end

# из комбинации, учитывая alphabet, составляем "слово"
def number_to_letters(alphabet, line)
  letters = line.split(',')
  word = []
  letters.each do |letter|
    word << alphabet[letter.to_i - 1]
  end
  word.join()
end

# основной цикл приложение
# проходимся во всему списку комбинаций
File.open(COMBINATIONS_FILE, 'r') do |f|
  f.lines.each do |line|
    # составляем слово
    n_t_l = number_to_letters(alphabet, line)
    # находим в бд
    result = find_a_word(n_t_l)
    unless result.nil? then # если нашли
      puts n_t_l # выводим его 
      File.open(OUTPUT_FILE, 'a') do |output| 
        output.puts n_t_l # и записываем в файл
      end 
    end
  end
end

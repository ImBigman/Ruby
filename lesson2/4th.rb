 #Заполнить хеш гласными буквами,
#где значением будет являтся порядковый номер буквы в алфавите (a - 1).
abc = ('а'..'я').to_a
vowels = ['а', 'о', 'и', 'е', 'ё', 'э', 'ы', 'у', 'ю', 'я']
vowels_hash = {}
abc.each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels.include?(letter)
end
puts vowels_hash

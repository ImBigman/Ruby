#Заполнить хеш гласными буквами,
#где значением будет являтся порядковый номер буквы в алфавите (a - 1).
abc = ("а".."я").to_a
vowels = ["а", "о", "и", "е", "ё", "э", "ы", "у", "ю", "я"]
abc_index = []
abc_index = abc.to_enum(:each_with_index).map { |i, a| [a + 1, i] }
abc_hash = Hash[*abc_index.flatten(1)]
abc_hash_vowels = abc_hash.select { |num, letter| letter if vowels.include?(letter) }
puts abc_hash_vowels = abc_hash_vowels.invert

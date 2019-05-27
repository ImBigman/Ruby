abc = ["a","e","i","o","u"]
abc_hash = {}
("a".."z").each_with_index {|letter, index| abc_hash[letter] = index+1 if abc.include?(letter)}
puts abc_hash

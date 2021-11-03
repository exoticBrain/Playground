dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def has_word?(string_1, string_2)
  string_1.downcase.include?(string_2.downcase)
end

def count_word(array, word_to_count)
  count = 0

  array.each do |current_word|
    count += 1 if has_word?(current_word, word_to_count)
  end

count
end

def sub_strings(string, dictionary)
  sub_str = {}
  words_array = string.split(" ")

  words_array.each do |word_from_string|
    dictionary.each do |current_word|
      sub_str[current_word] = count_word(words_array, current_word) if has_word?(word_from_string, current_word)
    end
  end

  sub_str
end




# EXAPMLES

# => ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
# sub_strings("below", dictionary)
# => { "below" => 1, "low" => 1 }

# sub_strings("Howdy partner, sit down! How's it going?", dictionary)
# => { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
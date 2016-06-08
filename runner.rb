def process_hash(hash, file_name)
  sum = hash.values.inject(0) { |sum, n| sum + n }.to_f
  lines = []
  hash.sort {|a,b| b[1] <=> a[1]}.each do |item, count|
    lines << [item, count, (count / sum).round(4)].join("\t")
  end

  File.open(file_name, 'w') {|file_handle| file_handle.write(lines.join("\n")) }
end

def letter_frequency(words)
  hash = Hash.new(0)
  words.each do |word|
    word.split("").each {|letter| hash[letter] += 1}
  end

  process_hash(hash, 'frequency_of_letters.tsv')
end

def ngrams(n, word)
  word.split('').each_cons(n).to_a
end

def gram_frequency(words, n)
  hash = Hash.new(0)
  words.each do |word|
    ngrams(n, word).each {|letter_sequence| hash[letter_sequence.join('')] += 1}
  end

  process_hash(hash, "frequency_of_#{n}grams.tsv")
end

dictionary = "dictionary_small.txt"
dictionary = "dictionary.txt"
words = IO.readlines(dictionary).map {|word| word.strip}.map {|word| word.downcase}
letter_frequency(words)
gram_frequency(words, 2)
gram_frequency(words, 3)
gram_frequency(words, 4)
gram_frequency(words, 5)

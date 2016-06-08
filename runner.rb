module Enumerable
  def sum
    return self.inject(0){|accum, i| accum + i }
  end

  def mean
    return self.sum / self.length.to_f
  end

  def variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum + (i - m) ** 2 }
    return sum / self.length.to_f
  end

  def standard_deviation
    return Math.sqrt(self.variance)
  end
end

def process_hash(hash, file_name)
  sum = hash.values.inject(0) { |sum, n| sum + n }.to_f
  lines = []
  hash.sort {|a,b| b[1] <=> a[1]}.each do |item, count|
    lines << [item, count, (count / sum).round(8)].join("\t")
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

def add_hole_to_gram(word)
  word.split('').map.with_index {|char, index| index == 0 || index == (word.size - 1) ? char : '_' }.join('')
end

def gram_with_hole_frequency(words, n)
  hash = Hash.new(0)
  words.each do |word|
    ngrams(n, word).each {|letter_sequence| hash[add_hole_to_gram(letter_sequence.join(''))] += 1}
  end

  process_hash(hash, "frequency_of_#{n}grams_with_hole.tsv")
end

def compute_average_scores(words, file_name, gram_size)
  grader_array = IO.readlines(file_name).map {|line| line.strip}.map{|line| pieces = line.split(/\s+/); [pieces[0], pieces[2].to_f]}
  grader_hash = Hash[*grader_array.flatten]
  score_density_by_word_length = {}
  words.each do |word|
    grams = ngrams(gram_size, word).map {|letter_sequence| letter_sequence.join('')}
    score = grams.inject(0) { |sum, gram| sum + grader_hash[gram].to_f }
    score_density = score / word.size
    score_density_by_word_length[word.size] ||= []
    score_density_by_word_length[word.size] << score_density
  end

  lines = []
  score_density_by_word_length.sort {|a,b| a[0] <=> b[0]}.each do |word_length, score_density_array|
    lines << [word_length, score_density_array.mean.round(8), score_density_array.standard_deviation.round(8)].join("\t")
  end

  puts lines
end

dictionary = "dictionary_small.txt"
dictionary = "dictionary.txt"
words = IO.readlines(dictionary).map {|word| word.strip}.map {|word| word.downcase}
#letter_frequency(words)
#gram_frequency(words, 2)
#gram_frequency(words, 3)
#gram_frequency(words, 4)
#gram_frequency(words, 5)
#gram_with_hole_frequency(words, 3)
#gram_with_hole_frequency(words, 4)
#gram_with_hole_frequency(words, 5)
#gram_with_hole_frequency(words, 6)
#gram_with_hole_frequency(words, 7)

n=2
compute_average_scores(words, "frequency_of_#{n}grams.tsv", n)


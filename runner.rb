def process_hash(hash, file_name)
  sum = hash.values.inject(0) { |sum, n| sum + n }.to_f
  lines = []
  hash.sort {|a,b| b[1] <=> a[1]}.each do |item, count|
    lines << [item, count, (count / sum).round(4)].join("\t")
  end
  puts lines

  File.open(file_name, 'w') {|file_handle| file_handle.write(lines.join("\n")) }
end

def letter_frequency(words)
  hash = Hash.new(0)
  words.each do |word|
    word.split("").each {|letter| hash[letter] += 1}
  end

  puts hash
  process_hash(hash, 'letter_frequency.tsv')
end


words = IO.readlines("dictionary_small.txt").map {|word| word.strip}.map {|word| word.downcase}
letter_frequency(words)

puts words[0..9].inspect

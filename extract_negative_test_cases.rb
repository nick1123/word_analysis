def select_negative_test_cases(lines)
  lines.select {|line| line.index("false,") }
end

def select_positive_test_cases(lines)
  lines.select {|line| line.index("true,") }
end

def remove_junk(lines)
  lines
    .map {|line| line.gsub("true,", '') }
    .map {|line| line.gsub("false,", '') }
    .map {|line| line.gsub(/\s+|\"|:/, '') }
end

File.open('negative_test_cases.txt', 'w') do |file_handle|
  file_handle.write(
    remove_junk(
      select_negative_test_cases(
        IO.readlines('test_cases.txt')
      )
    ).join("\n")
  )
end

File.open('positive_test_cases.txt', 'w') do |file_handle|
  file_handle.write(
    remove_junk(
      select_positive_test_cases(
        IO.readlines('test_cases.txt')
      )
    ).join("\n")
  )
end

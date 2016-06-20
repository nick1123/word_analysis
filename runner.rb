require 'json'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/matchers/*.rb'].each {|file| require file }

##########
## Load test cases
def negative_test_cases
  IO.readlines('flat_files/negative_test_cases.txt').map {|line| line.strip}#[0..5000]
end

def positive_test_cases
  IO.readlines('flat_files/positive_test_cases.txt').map {|line| line.strip}#[0..5000]
end


##########
## Pre-sort matchers
#
# # Kind of slow, so we store the results in a flat file
# matcher_pre_sort = MatcherPreSort.new(positive_test_cases, negative_test_cases)
#
# File.open('flat_files/ranked_matches.txt', 'w') do |file_handle|
#   file_handle.write(
#     matcher_pre_sort.sort_by_frequency.join("\n")
#   )
# end

##########
## Build the matchers
def pre_sorted_matchers
  IO.readlines('flat_files/ranked_matches.txt')
  .map {|line| line.strip.split("\t")[0] }
end

matcher_generator = MatcherGenerator.new(pre_sorted_matchers, 20)

solution_tester = SolutionTester.new(positive_test_cases, negative_test_cases)

solution_generator = SolutionGenerator.new(matcher_generator)
solution_set = SolutionSet.new(solution_generator, max_population_size=20, solution_tester)


times_to_run = 10_000
(1..times_to_run).each do |iteration|
  solution_set.iterate

  if iteration % (times_to_run / 100) == 0
    puts "*** Iteration #{iteration}"
    puts ""
    puts solution_set
    puts ""
  end
end

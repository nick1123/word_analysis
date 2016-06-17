Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/matchers/*.rb'].each {|file| require file }

##########
## Load test cases
def negative_test_cases
  IO.readlines('flat_files/negative_test_cases.txt').map {|line| line.strip}
end

def positive_test_cases
  IO.readlines('flat_files/positive_test_cases.txt').map {|line| line.strip}
end


##########
## Pre-sort matchers so we don't have to waste time with ineffective matchers

# Kind of slow, slow we store the results in a flat file
matcher_pre_sort = MatcherPreSort.new(positive_test_cases, negative_test_cases)

File.open('flat_files/ranked_matches.txt', 'w') do |file_handle|
  file_handle.write(
    matcher_pre_sort.build_matchers.join("\n")
  )
end


# matcher_generator = MatcherGenerator.new
# solution_tester = SolutionTester.new(positive_test_cases, negative_test_cases)
#
# solution_generator = SolutionGenerator.new(matcher_generator, max_matchers_per_solution=15)
# solution_set = SolutionSet.new(solution_generator, max_population_size=50, solution_tester)
#
# puts solution_set
# puts ""
#
# times_to_run = 10_000
# (1..times_to_run).each do |iteration|
#   solution_set.iterate
#
#   if iteration % (times_to_run / 100) == 0
#     puts "*** Iteration #{iteration}"
#     puts ""
#     puts solution_set
#     puts ""
#   end
# end

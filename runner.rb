Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/matchers/*.rb'].each {|file| require file }

def negative_test_cases
  IO.readlines('test_cases/negative_test_cases.txt').map {|line| line.strip}
end

def positive_test_cases
  IO.readlines('test_cases/positive_test_cases.txt').map {|line| line.strip}
end


matcher_generator = MatcherGenerator.new
solution_tester = SolutionTester.new(positive_test_cases, negative_test_cases)
solution_set = SolutionSet.new(matcher_generator, max_population_size=10, matchers_per_solution=15, solution_tester)

puts solution_set

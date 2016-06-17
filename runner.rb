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

solution_generator = SolutionGenerator.new(matcher_generator, max_matchers_per_solution=15)
solution_set = SolutionSet.new(solution_generator, max_population_size=50, solution_tester)

puts solution_set
puts ""

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

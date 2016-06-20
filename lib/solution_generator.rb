class SolutionGenerator
  def initialize(matcher_generator)
    @matcher_generator = matcher_generator
  end

  def new_solution(create_random, all_solutions)
    if create_random || rand >= 0.5
      random_solution
    else
      mate_2_solutions(all_solutions)
    end
  end


   def create_mutant(old_solution)
     new_set_of_matchers = old_solution.matchers

     index_of_matcher_to_mutate = rand(new_set_of_matchers.count)
     matcher_to_mutate = new_set_of_matchers[index_of_matcher_to_mutate]
     copied_matcher = matcher_to_mutate.copy
     copied_matcher.mutate!
     new_set_of_matchers[index_of_matcher_to_mutate] = copied_matcher

     Solution.new(new_set_of_matchers, :mutant)
  end

  private


  def mate_2_solutions(all_solutions)
    min_score = all_solutions.min.score
    parents = TournamentSelector.select_2_solutions_for_mating(all_solutions, min_score)

    parents_matcher_count = parents[0].matchers.size
    new_set_of_matchers = (0..(parents_matcher_count - 1)).map.with_index do |i, index|
      random_bool ? parents[0].matchers[index].copy : parents[1].matchers[index].copy
    end

    Solution.new(new_set_of_matchers, :child)
  end

  def random_solution
    Solution.new(@matcher_generator.new_set_of_matchers, :random)
  end

  def random_bool
    rand >= 0.5
  end
end

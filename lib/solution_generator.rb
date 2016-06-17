class SolutionGenerator
  def initialize(matcher_generator, max_matchers_per_solution)
    @matcher_generator = matcher_generator
    @max_matchers_per_solution = max_matchers_per_solution
  end

  def new_solution(create_random, all_solutions)
    if create_random || rand >= 0.5
      random_solution
    else
      mate_2_solutions(all_solutions)
    end
  end

  # def create_mutant(old_solution)
  #   matchers = old_solution.matchers.shuffle.tap do |m|
  #     m.pop
  #     m << @matcher_generator.new_match
  #   end
  #
  #   Solution.new(matchers, :mutant)
  # end

  private

  def matchers_for_this_solution
    # rand(@max_matchers_per_solution) + 1
    @max_matchers_per_solution
  end

  def mate_2_solutions(all_solutions)
    min_score = all_solutions.min.score
    parents = TournamentSelector.select_2_solutions_for_mating(all_solutions, min_score)

    child_matchers = parents.map do |solution|
      solution.matchers
    end.flatten.shuffle[0..(matchers_for_this_solution - 1)].sort

    Solution.new(child_matchers, :child)
  end

  def random_matchers
    (1..matchers_for_this_solution).map { |i| @matcher_generator.new_match}.sort
  end

  def random_solution
    Solution.new(random_matchers, :random)
  end
end

class SolutionSet
  def initialize(solution_generator, max_population_size, solution_tester)
    @solution_generator = solution_generator
    @max_population_size = max_population_size
    @solution_tester = solution_tester
    @solutions = {}

    populate(true)
  end

  def iterate
    increment_age
    kill_off_solution
    populate(false)
    mutate_a_solution
  end

  private

  def increment_age
    @solutions.values.each {|s| s.increment_age }
  end

  def mutate_a_solution
    finger_print = @solutions.values.shuffle[0].finger_print
    old_solution = @solutions[finger_print]
    mutant_solution = @solution_generator.create_mutant(old_solution)
    add_solution(mutant_solution)
    reaper(finger_print)
  end

  def kill_off_solution
    finger_print = TournamentSelector.find_solution_to_kill_off(@solutions.values)
    #puts "#{finger_print} has died"
    reaper(finger_print)
  end

  def reaper(finger_print)
    @solutions.delete(finger_print)
  end

  def populate(create_random)
    while @solutions.keys.size < @max_population_size
      solution = @solution_generator.new_solution(create_random, @solutions.values)
      add_solution(solution)
    end
  end

  def add_solution(solution)
    solution.score = @solution_tester.solution_score(solution)
    @solutions[solution.finger_print] = solution
  end

  def to_s
    @solutions.values.sort.reverse[0..59].flatten.join("\n")
  end
end

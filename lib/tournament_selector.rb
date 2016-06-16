module TournamentSelector
  MIN_SCORE = 47

  def self.find_solution_to_kill_off(solutions)
    solutions.map do |solution|
      (1..(100 - solution.score)).map { solution.finger_print }
    end.flatten.shuffle[0]
  end

  def self.select_2_solutions_for_mating(solutions)
    solutions
    .select {|s| s.score >= MIN_SCORE }
    .map do |solution|
      (MIN_SCORE..solution.score).map { solution.finger_print }
    end.flatten.shuffle.uniq[0..1]
  end
end

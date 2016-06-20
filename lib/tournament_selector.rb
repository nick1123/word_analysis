module TournamentSelector
  # Returns a solution's finger_print
  def self.find_solution_to_kill_off(solutions)
    raffle(solutions, :low_score_density)[0]
  end

  def self.select_2_solutions_for_mating(solutions, min_score)
    finger_prints = raffle(solutions, :high_score_density).uniq[0..1]
    solutions.select {|s| finger_prints.include?(s.finger_print)}
  end

  def self.raffle_favoring_high_score_density(solutions)
    solutions.map do |solution|
      tickets = (10 * solution.score_density).round
      (0..tickets).map { solution.finger_print }
    end.flatten.shuffle
  end

  def self.raffle(solutions, gets_more_tickets)
    max = max_score_density(solutions)
    min = min_score_density(solutions)
    solutions.map do |solution|
      tickets = 0
      if gets_more_tickets == :low_score_density
        tickets = (10 * (max - solution.score_density)).round
      elsif gets_more_tickets == :high_score_density
        tickets = (10 * (solution.score_density - min)).round
      else
        raise "Unknown type for 'gets_more_tickets'"
      end

      (0..tickets).map { solution.finger_print }
    end.flatten.shuffle
  end

  def self.max_score_density(solutions)
    solutions.sort.reverse[0].score_density
  end

  def self.min_score_density(solutions)
    solutions.sort[0].score_density
  end
end

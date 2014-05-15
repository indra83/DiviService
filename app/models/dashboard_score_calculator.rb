class DashboardScoreCalculator < Array
  def initialize(attempts, group_by)
    attempts = attempts.where('(correct_attemptt + wrong_attempts) != 0')

    points_table = attempts.group(group_by).sum(ATTEMPT_POINTS)
    accuracy_table = attempts.group(group_by).average(ATTEMPT_ACCURACY)
    points_table.each do |k, v|
      push({
        :id => k,
        group_by.to_s.camelize(:lower) => k,
        :points => v.to_i,
        :accuracy => accuracy_table[k].to_i
      })
    end
  end
private
  ATTEMPT_POINTS = "(total_points * correct_attempts) / subquestions"
  ATTEMPT_ACCURACY = "100 * correct_attempts / (correct_attempts + wrong_attempts)"
end

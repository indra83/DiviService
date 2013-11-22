class DashboardScoreCalculator < Array
  def initialize(items, group_by)
    points_table = items.group(group_by).sum(ATTEMPT_POINTS)
    accuracy_table = items.group(group_by).average(ATTEMPT_ACCURACY)
    points_table.each do |k, v|
      push({
        :id => k,
        group_by => k,
        :points => v.to_i,
        :accuracy => accuracy_table[k].to_i
      })
    end
  end
private
  ATTEMPT_POINTS = "(total_points * correct_attempts) / subquestions"
  ATTEMPT_ACCURACY = "100 * correct_attempts / (correct_attempts + wrong_attempts)"
end

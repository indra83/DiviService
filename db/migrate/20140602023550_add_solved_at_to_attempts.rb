class AddSolvedAtToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :solved_at, :datetime
  end
end

class AddEndingTimeToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :ends_at, :datetime
  end
end

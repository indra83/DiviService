class AddStatusToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :status, :string
  end
end

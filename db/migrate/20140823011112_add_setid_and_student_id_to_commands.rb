class AddSetidAndStudentIdToCommands < ActiveRecord::Migration
  def change
    add_column :commands, :setid, :string
    add_reference :commands, :student, index: true
  end
end

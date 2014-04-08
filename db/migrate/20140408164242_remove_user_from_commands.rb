class RemoveUserFromCommands < ActiveRecord::Migration
  def change
    remove_reference :commands, :user, index: true
  end
end

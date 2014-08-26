class AddTokenIndexToUsersTable < ActiveRecord::Migration
  def change
    add_index :users, :token, unique: true
  end
end

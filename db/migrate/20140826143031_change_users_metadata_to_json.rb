class ChangeUsersMetadataToJson < ActiveRecord::Migration
  def up
    remove_column :users, :metadata, :string
    add_column    :users, :metadata, :json
  end

  def down
    change_column :users, :metadata, :string
  end
end

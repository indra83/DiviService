class AddMetadataToTablets < ActiveRecord::Migration
  def change
    add_column :tablets, :metadata, :json
  end
end

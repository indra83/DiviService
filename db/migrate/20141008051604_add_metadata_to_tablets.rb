class AddMetadataToTablets < ActiveRecord::Migration
  def change
    add_column :tablets, :metadata, :text
  end
end

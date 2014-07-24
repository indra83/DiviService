class AddMetadataToCdns < ActiveRecord::Migration
  def change
    add_column :cdns, :metadata, :json
  end
end

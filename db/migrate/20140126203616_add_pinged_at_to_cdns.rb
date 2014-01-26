class AddPingedAtToCdns < ActiveRecord::Migration
  def change
    add_column :cdns, :pinged_at, :datetime
  end
end

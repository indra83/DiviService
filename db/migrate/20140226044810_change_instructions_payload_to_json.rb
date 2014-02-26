class ChangeInstructionsPayloadToJson < ActiveRecord::Migration
  def change
    remove_column :instructions, :payload
    add_column :instructions, :payload, :json
  end
end

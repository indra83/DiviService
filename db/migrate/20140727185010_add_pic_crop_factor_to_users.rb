class AddPicCropFactorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pic_crop_factor, :json
  end
end

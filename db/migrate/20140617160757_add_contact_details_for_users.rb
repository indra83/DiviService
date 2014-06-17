class AddContactDetailsForUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :phone
      t.string :email
      t.string :parent_phone
      t.string :parent_email
      t.timestamp :report_starts_at
    end
  end
end

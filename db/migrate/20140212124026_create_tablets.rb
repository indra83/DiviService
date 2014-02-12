class CreateTablets < ActiveRecord::Migration
  def change
    create_table :tablets do |t|
      t.string :device_id
      t.string :device_tag
      t.string :token
      t.belongs_to :user, index: true
      t.json :content

      t.timestamps
    end
  end
end

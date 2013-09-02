class CreateCdns < ActiveRecord::Migration
  def change
    create_table :cdns do |t|
      t.string :base_url
      t.references :school, index: true

      t.timestamps
    end
  end
end

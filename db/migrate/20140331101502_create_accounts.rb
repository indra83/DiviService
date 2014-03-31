class CreateAccounts < ActiveRecord::Migration
  class User < ActiveRecord::Base;;end
  class Account < ActiveRecord::Base;;end

  def change
    create_table :accounts do |t|
      t.string :password_digest
      t.belongs_to :user, polymorphic: true, index: true
      t.string :token

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        User.all.each do |user|
          Account.create user.attributes.extract!(*Account.attribute_names).merge(user_id: user.id, user_type: 'User')
        end
      end
    end
  end
end

class RemoveRedundantColumnsFromUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base;;end
  class Account < ActiveRecord::Base;;end

  def change
    reversible do |dir|
      dir.down do
        User.all.each do |user|
          user.update_attributes! Account.find(user.id).attributes.extract!('password_digest', 'token')
        end
      end
    end

    remove_column :users, :password_digest, :string
    remove_column :users, :token, :string
  end
end

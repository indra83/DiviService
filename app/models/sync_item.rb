class SyncItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
end

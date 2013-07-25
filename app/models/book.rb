class Book < ActiveRecord::Base
  belongs_to :course
  has_many :updates
end

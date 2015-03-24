class Cdn < ActiveRecord::Base
  has_paper_trail

  belongs_to :school

  #validates :school_id, presence: true
  validates :base_url, presence: true,
                       length: {minimum: 10}

  def updates
    return [] unless school
    school.books.map(&:cdn_updates).flatten
  end
end

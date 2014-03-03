ActiveAdmin.register SyncItem do
  actions :index

  index do
    column :id
    column :user_id
    column :book_id
    column :assessment_id
    column :question_id
    column :total_points
    column :attempts
    column :data
    column :last_updated_at
    column :correct_attempts
    column :wrong_attempts
    column :subquestions
    column :course_id
    column :created_at
    column :updated_at
  end

  csv do
    column :id
    column :user_id
    column :book_id
    column :assessment_id
    column :question_id
    column :total_points
    column :attempts
    column :data
    column :last_updated_at
    column :correct_attempts
    column :wrong_attempts
    column :subquestions
    column :course_id
    column :created_at
    column :updated_at
  end

  controller do
    def per_page
      return max_per_page if request.format == 'text/csv'
      super
    end
  end
end

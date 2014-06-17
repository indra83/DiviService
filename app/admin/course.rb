ActiveAdmin.register Course do
  menu priority: 4

  index do
    column :id
    column :name
    actions
    column do |c|
      link_to 'Books', admin_course_books_path(c)
    end
  end

  action_item only: [:show, :edit] do
    link_to "Books", admin_course_books_path(course)
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

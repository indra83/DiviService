ActiveAdmin.register Course do
  menu priority: 4

  action_item only: [:show, :edit] do
    link_to "Books", admin_course_books_path(course)
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

ActiveAdmin.register Book do
  belongs_to :course, parent_class: Course, optional: true
  menu false

  action_item only: [:show, :edit] do
    link_to "Updates", admin_book_updates_path(book)
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

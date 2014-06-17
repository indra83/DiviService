ActiveAdmin.register ClassRoom do
  belongs_to :school, parent_class: School, optional: true
  menu false

  index do
    column :id
    column :standard
    column :section
    actions
    column do |c|
      link_to 'Users', admin_class_room_users_path(c)
    end
  end

  action_item only: [:show, :edit] do
    link_to "Users", admin_class_room_users_path(class_room)
    link_to "Commands", admin_class_room_commands_path(class_room)
  end

  form do |f|
    f.inputs "Class Room Detials" do
      f.input :school
      f.input :standard
      f.input :section
      f.input :courses
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

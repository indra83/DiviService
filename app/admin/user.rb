ActiveAdmin.register User do

  form do |f|
    f.inputs "Security" do
      f.input :name
      f.input :password
      f.input :password_confirmation
      f.input :role, collection: %w[student teacher]
      f.input :class_rooms
    end

    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

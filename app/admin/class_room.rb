ActiveAdmin.register ClassRoom do
  menu parent: 'User', priority: 2

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

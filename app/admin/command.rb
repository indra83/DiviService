ActiveAdmin.register Command do
  belongs_to :class_room, parent_class: ClassRoom

  form do |f|
    f.inputs :status
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

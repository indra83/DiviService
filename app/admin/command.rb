ActiveAdmin.register Command do
  belongs_to :class_room, parent_class: ClassRoom

  controller do
    def permitted_params
      params.permit!
    end
  end
end

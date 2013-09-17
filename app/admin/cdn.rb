ActiveAdmin.register Cdn do
  belongs_to :school, parent_class: School

  controller do
    def permitted_params
      params.permit!
    end
  end
end

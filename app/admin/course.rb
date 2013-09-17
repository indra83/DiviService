ActiveAdmin.register Course do
  menu parent: 'Content', priority: 4


  controller do
    def permitted_params
      params.permit!
    end
  end
end

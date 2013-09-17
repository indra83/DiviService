ActiveAdmin.register Book do
  menu parent: 'Content', priority: 5


  controller do
    def permitted_params
      params.permit!
    end
  end
end

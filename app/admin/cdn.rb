ActiveAdmin.register Cdn do
  menu parent: 'Content', priority: 7

  controller do
    def permitted_params
      params.permit!
    end
  end
end

ActiveAdmin.register School do
  menu parent: 'User', priority: 1

  controller do
    def permitted_params
      params.permit!
    end
  end
end

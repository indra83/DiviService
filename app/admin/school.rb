ActiveAdmin.register School do
  menu priority: 1

  action_item only: [:show, :edit] do
    link_to "Class Rooms", admin_school_class_rooms_path(school)
  end

  action_item only: [:show, :edit] do
    link_to "CDN", admin_school_cdns_path(school)
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

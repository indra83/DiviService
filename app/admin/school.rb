ActiveAdmin.register School do
  menu priority: 1

  index do
    column :id
    column :name
    column :location
    actions
    column do |s|
      link_to 'Class Rooms', admin_school_class_rooms_path(s)
    end
    column do |s|
      link_to 'Labs', admin_school_labs_path(s)
    end
  end

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

ActiveAdmin.register Tablet do
  actions :index, :show

  index do
    column :id
    column :device_id
    column :device_tag
    column :battery_level
    column :token
    column :user
  end
end

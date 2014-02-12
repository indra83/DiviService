ActiveAdmin.register Tablet do
  actions :index, :show

  index do
    column :id
    column :device_id
    column :device_tag
    column :token
    column :user
  end
end

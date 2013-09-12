ActiveAdmin.register Lecture do
  actions :index
  index do
    column :id
    column :name
    column :teacher
    column :status
    column :class_room
    column :start_time
    column :created_at
    column :updated_at
  end
end


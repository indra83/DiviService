ActiveAdmin.register Lecture do
  actions :index
  index do
    column :name
    column :teacher
    column :class_room
    column :start_time
    column :created_at
    column :updated_at
  end
end


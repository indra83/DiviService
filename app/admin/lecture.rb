ActiveAdmin.register Lecture do
  actions :index
  index do
    column :id
    column :name
    column :teacher
    column :class_room
    column :status
    column :start_time
    column :computed_status
  end
end


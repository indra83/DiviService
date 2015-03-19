ActiveAdmin.register Lab do
  belongs_to :school, parent_class: School, optional: true
  menu false

  index do
    column :id
    column :name
    column :class_room
    column :pending_user_ids
    actions
  end

  form do |f|
    f.inputs "Lab Details" do
      f.input :name
      f.input :class_room, collection: f.object.school.class_rooms
    end
    f.actions
  end

  permit_params :name, :class_room
end

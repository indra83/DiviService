ActiveAdmin.register User do

  form do |f|
    f.inputs "Security" do
      f.input :name
      f.input :password
      f.input :password_confirmation
      f.input :role, collection: %w[student teacher]
      f.input :class_rooms
    end

		f.inputs "Profile Picture" do
			f.input :pic, as: :filepicker
		end

    f.actions
  end

	index do
		column :id
		column :name
		column :role
		column :class_rooms do |user|
			user.class_rooms.map(&:name).join(', ')
		end
		column :created_at
		column :updated_at

		actions
	end

  index as: :grid, default: true do |user|
  	link_to admin_user_path user do
  		image = filepicker_image_tag user.pic, user.profile_pic_opts
  		name = content_tag :h3, user.name

  		image + name
  	end
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

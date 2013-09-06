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

	index as: :grid do |user|
		link_to admin_user_path user do
			image = image_tag user.profile_pic
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

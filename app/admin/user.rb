ActiveAdmin.register User do
  belongs_to :class_room, parent_class: ClassRoom

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

    f.inputs "extra" do
      f.input :metadata
    end

    f.actions
  end

	index default: true do
		column :id
		column :name
		column :role
    column :tablet do |user|
      next 'n/a' unless user.tablet
      link_to admin_tablet_path(user.tablet) do
        span user.tablet.device_id
        text_node "<br>".html_safe
        span user.tablet.device_tag
      end
    end
    column :content_status do |user|
      case user.is_content_up_to_date?
      when nil
        'n/a'
      when true
        status_tag 'up to date'
      when false
        link_to 'pending', admin_tablet_path(user.tablet), class: 'status_tag error'
      end
    end
    column :last_check_in do |user|
      if user.last_check_in
        time_in_words = time_ago_in_words user.last_check_in
        if user.last_check_in > 10.minutes.ago
          css_status = 'ok'
        elsif user.last_check_in > 30.minutes.ago
          css_status = 'warning'
        else
          css_status = 'error'
        end
        status_tag "#{time_in_words} ago", css_status
      else
        text_node 'n/a'
      end
    end
    column :battery_level

		actions
	end

  index as: :grid do |user|
  	link_to resource_path user do
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

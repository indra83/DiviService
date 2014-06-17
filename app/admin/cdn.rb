ActiveAdmin.register Cdn do
  belongs_to :school, parent_class: School

  config.sort_order = "pinged_at_desc"

  controller do
    def permitted_params
      params.permit!
    end
  end

  index do
    column :id
    column :base_url
    column :pinged_at do |cdn|
      css_status = if cdn.pinged_at > 10.minutes.ago
                     'ok'
                   elsif cdn.pinged_at > 30.minutes.ago
                     'warning'
                   else
                     'error'
                   end
      status_tag distance_of_time_in_words_to_now(cdn.pinged_at), css_status
    end
    column :created_at

    actions
  end
end

ActiveAdmin.register Cdn, as: "Orphan CDN" do
  config.sort_order = "pinged_at_desc"

  index do
    column :id
    column :base_url
    column :pinged_at do |cdn|
      css_status = if cdn.pinged_at > 10.minutes.ago
                     'ok'
                   elsif cdn.pinged_at > 30.minutes.ago
                     'warning'
                   else
                     'error'
                   end
      status_tag distance_of_time_in_words_to_now(cdn.pinged_at), css_status
    end
    column :created_at

    actions
  end

  controller do
    def collection
      super.where school_id: nil
    end

    def update
      update! do |format|
        format.html { redirect_to resource.admin_path }
      end
    end

    def permitted_params
      params.permit!
    end

  end
end

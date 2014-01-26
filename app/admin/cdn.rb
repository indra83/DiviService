ActiveAdmin.register Cdn do
  belongs_to :school, parent_class: School

  config.sort_order = "pinged_at_desc"

  controller do
    def permitted_params
      params.permit!
    end
  end
end

ActiveAdmin.register Cdn, as: "Orphan CDN" do
  config.sort_order = "pinged_at_desc"

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

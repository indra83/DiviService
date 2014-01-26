ActiveAdmin.register Cdn do
  belongs_to :school, parent_class: School

  controller do
    def permitted_params
      params.permit!
    end
  end
end

ActiveAdmin.register Cdn, as: "Orphan CDN" do
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

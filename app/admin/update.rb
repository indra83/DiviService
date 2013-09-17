ActiveAdmin.register Update do
  belongs_to :book, parent_class: Book

  form do |f|
    filepicker_js_include_tag
    f.inputs "Details" do
      f.input :book, member_label: :full_name
      f.input :version
      f.input :description
      f.input :details
      f.input :status, collection: %w[testing staging live], include_blank: false
      f.input :strategy, collection: %w[replace], include_blank: false
    end
    f.inputs "File Upload" do
      f.input :file, as: :filepicker
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

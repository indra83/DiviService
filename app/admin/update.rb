ActiveAdmin.register Update do

  form do |f|
    filepicker_js_include_tag
    f.inputs "Details" do
      f.input :book, member_label: :full_name
      f.input :description
      f.input :details
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

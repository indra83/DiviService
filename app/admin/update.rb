ActiveAdmin.register Update do

  form do |f|
    filepicker_js_include_tag
    f.inputs "Details" do
      f.input :book
      f.input :description
      f.input :details
    end
    f.inputs "File Upload" do
      f.input :file, as: :filepicker
    end
    f.actions
  end
end

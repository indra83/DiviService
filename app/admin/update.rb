ActiveAdmin.register Update do
  belongs_to :book, parent_class: Book

  index do
    column :id
    column :decription
    column :details
    column :book_version
    column :book_from_version
    column :status
    column :strategy
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :book, member_label: :full_name
      f.input :book_version
      f.input :book_from_version
      f.input :description
      f.input :details
      f.input :status, collection: %w[testing staging live], include_blank: false
      f.input :strategy, collection: %w[replace patch], include_blank: false
    end

    unless resource.persisted?
      f.inputs "File Upload" do
        f.input :file, as: :fileuploader
        f.input :copy, as: :hidden, input_html: {value: true}
      end
    end

    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end

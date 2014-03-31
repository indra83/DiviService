ActiveAdmin.register Version do
  actions :index, :show

  member_action :restore, method: :post do
    version = Version.find params[:id]
    item = version.reify
    item.save
    redirect_to item.admin_path
  end

  index do
    column :id
    column "Item" do |v|
      item = v.item || v.reify || Version.where(item_id: v.item_id).where("created_at > ?", v.created_at).order('created_at ASC').first.reify
      name = item.try(:name) || item
      if item.respond_to? :admin_path
        link_to name, item.admin_path
      else
        name
      end
    end

    # column "Item" do |v| link_to v.item, [:admin, v.item] end # Uncomment to display as link
    column "Type" do |v|
      v.item_type.underscore.humanize
    end
    column :event
    column "Modified at" do |v|
      v.created_at.to_s :long
    end
    column "Admin" do |v|
      link_to AdminUser.find(v.whodunnit).email, admin_admin_user_path(AdminUser.find(v.whodunnit))
    end
    column "Restore" do |v|
      link_to 'restore', restore_admin_version_path(v), method: :post
    end
  end
end

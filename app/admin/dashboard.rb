ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    panel "Recently updated content" do
      table_for PaperTrail::Version.order('id desc').limit(20) do # Use PaperTrail::Version if this throws an error
        column :id
        column "Item" do |v|
          begin
            item = v.item || v.reify || PaperTrail::Version.where(item_id: v.item_id).where("created_at > ?", v.created_at).order('created_at ASC').first.reify
            item.try(:name) || item
          rescue NameError
            "#{v.item_type}: #{v.item_id}"
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
          begin
            link_to AdminUser.find(v.whodunnit).email, admin_admin_user_path(AdminUser.find(v.whodunnit))
          rescue ActiveRecord::RecordNotFound
            v.whodunnit || 'Unknown user'
          end
        end
      end
    end
  end # content
end

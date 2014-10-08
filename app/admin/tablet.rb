ActiveAdmin.register Tablet do
  actions :index, :show

  index do
    column :id do |t|
      link_to t.id, admin_tablet_path(t)
    end
    column :device_id do |t|
      link_to t.id, admin_tablet_path(t)
    end
    column :device_tag
    column :battery_level
    column :token
    column :user
    column :timestamps do |t|
      span "attempts: #{time_ago_in_words Time.from_millistr t.timestamps['attempts'] } ago"
      tag :br
      span "commands: #{time_ago_in_words Time.from_millistr t.timestamps['commands'] } ago"
      tag :br
      span "content:  #{time_ago_in_words Time.from_millistr t.timestamps['content']  } ago"
      tag :br
      span "logs:     #{time_ago_in_words Time.from_millistr t.timestamps['logs']     } ago"
      tag :br
      span "reports:  #{time_ago_in_words Time.from_millistr t.timestamps['reports']  } ago"
    end
  end

  show do
    attributes_table do
      row :id
      row :device_id
      row :device_tag
      row :user
      row :battery_level
      row :created_at
      row :updated_at
    end

    panel "Time Stamps" do
      attributes_table_for tablet.timestamps do
        row('attempts') { "#{time_ago_in_words Time.from_millistr tablet.timestamps['attempts'] } ago" }
        row('commands') { "#{time_ago_in_words Time.from_millistr tablet.timestamps['commands'] } ago" }
        row('content')  { "#{time_ago_in_words Time.from_millistr tablet.timestamps['content']  } ago" }
        row('logs')     { "#{time_ago_in_words Time.from_millistr tablet.timestamps['logs']     } ago" }
        row('reports')  { "#{time_ago_in_words Time.from_millistr tablet.timestamps['reports']  } ago" }
      end
    end

    panel "Pending Updates" do
      table_for tablet.pending_updates do
        column :id
        column :description
        column :book
        column :book_version
        column :strategy do |update|
          status_map = {
            'patch'   => 'orange',
            'replace' => 'red'
          }
          status_tag update.strategy, status_map[update.strategy]
        end
        column :status
        column :file do |update|
          link_to update.file, update.file
        end
      end
    end

    panel "metadata" do
      attributes_table do
        row :metadata
      end
    end
  end
end

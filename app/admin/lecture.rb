ActiveAdmin.register Lecture do
  menu priority: 8

  actions :index
  index do
    column :id
    column :name
    column :teacher
    column :class_room
    column :status
    column :start_time do |lecture|
      time_in_words = distance_of_time_in_words_to_now lecture.start_time
      if lecture.start_time > Time.now
        css_status = 'ok'
        time_in_words += " from now"
      else
        time_in_words += " ago"
        css_status = lecture.status == 'expired' ? 'error' : 'warning'
      end
      status_tag time_in_words, css_status
    end
  end
end


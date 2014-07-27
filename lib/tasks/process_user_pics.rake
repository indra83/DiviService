desc 'Auto expire lectures older than one hour'
task process_user_pics: [:environment] do
  User.need_pic_processing.each &:crop_and_resize_pic
end

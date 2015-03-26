namespace :process_uploads do
  desc 'Copy update files from temp uploads directory'
  task update_files: [:environment] do
    Update.copy_needed.each &:process_file
  end

  desc 'Crop and copy pics from temp uploads directory'
  task user_pics: [:environment] do
    User.need_pic_processing.each &:process_pic
  end
end

desc 'Process the file uploads'
task :process_uploads => %w(process_uploads:update_files process_uploads:user_pics)

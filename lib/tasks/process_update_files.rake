desc 'Auto expire lectures older than one hour'
task process_update_files: [:environment] do
  Update.copy_needed.each &:process_file
end

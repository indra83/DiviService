json.key_format! camelize: :lower

json.diary_entries @diary_entries do |entry|
  json.partial! 'command_save_status', command: entry[0]
  json.subcommands entry[1] do |subcommand|
    json.partial! 'command_save_status', command: subcommand
  end
end


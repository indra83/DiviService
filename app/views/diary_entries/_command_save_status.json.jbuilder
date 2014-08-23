json.command do
  json.partial! 'sync/command', item: command
end
if command.errors.empty?
  json.saved true
else
  json.saved false
  json.errors command.errors
end

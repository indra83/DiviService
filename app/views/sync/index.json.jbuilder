json.key_format! camelize: :lower

json.attempts @attempts, partial: 'attempt', as: :item
json.commands @commands, partial: 'command', as: :item
json.has_more_data @has_more_data

json.key_format! camelize: :lower

json.attempts @items, partial: 'attempt', as: :item
json.commands @commands

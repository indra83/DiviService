json.key_format! camelize: :lower

json.sync_items @items, partial: 'sync_item', as: :item
json.commands @commands

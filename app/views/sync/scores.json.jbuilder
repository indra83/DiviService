json.key_format! camelize: :lower

json.attempts @attempts, partial: 'attempt', as: :item

json.extract! list, :id, :title, :ord
json.cards list.cards, 'card', as: :card

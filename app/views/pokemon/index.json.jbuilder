json.array! @pokemon do |pokemon|
  json.partial!('pokemon/pokemon', locals: { pokemon: pokemon, display_toys: false } )
end

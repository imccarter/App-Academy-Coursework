module Movement

  adj_pos = ([-1, 1, 0].product([-1, 1, 0]))[0...-1]
  dir_name = [:NW, :NE, :N, :SW, :SE, :S, :W, :E]
  DIRECTION_HASH = (0...8).to_a.map { |i| [dir_name[i], adj_pos[i]]}.to_h
  
end

def day9(string)
  map = string.split("\n").map { |line| line.split("").map { |char| char.to_i } }
  cave_map = Array.new(map.size) { Array.new(map[1].size, 0) }
  
  current_cave_index = 1
  map.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if cell < 9 && cave_map[i][j] == 0
        cave_map[i][j] = current_cave_index
        propagate(map, cave_map, i, j, current_cave_index)
        current_cave_index += 1
      end
    end
  end
  cave_map = cave_map.flatten
  n_cave = cave_map.max
  cave_sizes = (1..n_cave).map do |cave_num|
    cave_map.count(cave_num)
  end

  cave_sizes.sort!.reverse!
  cave_sizes[0] * cave_sizes[1] * cave_sizes[2]
end
  
def propagate (map, cave_map, i, j, current_cave_index)
  adjacents = [[i-1, j], [i+1, j], [i, j-1], [i, j+1]]
  adjacents.each do |a_i, a_j|
    next if a_i < 0 || a_j < 0
    next if map.dig(a_i, a_j).nil?
    if map[a_i][a_j] < 9 && cave_map[a_i][a_j] == 0
      cave_map[a_i][a_j] = current_cave_index
      propagate(map, cave_map, a_i, a_j, current_cave_index)
    end
  end
end
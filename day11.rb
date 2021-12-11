def day11(string)
  map = string.split("\n").map { |line| line.split("").map { |char| char.to_i } }
  count = map.size * map[0].size
  (1..10000).each do |index|
    if count == step(map)
      return index
    end
  end
end

def step(map)
  map.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      map[i][j] += 1
    end
  end
  flash_map = Array.new(map.size) { Array.new(map[0].size, 0) }
  map.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if cell > 9 && flash_map[i][j] == 0
        flash_map[i][j] = 1
        propagate(map, flash_map, i, j)
      end
    end
  end
  flash_map.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if cell == 1
        map[i][j] = 0
      end
    end
  end
  flash_map.flatten.sum
end

def propagate (map, flash_map, i, j)
  adjacents = [[i-1, j], [i+1, j], [i, j-1], [i, j+1], [i+1, j+1], [i+1, j-1], [i-1, j+1], [i-1, j-1]]
  adjacents.each do |a_i, a_j|
    next if a_i < 0 || a_j < 0
    next if map.dig(a_i, a_j).nil?
    map[a_i][a_j] += 1
    if map[a_i][a_j] > 9 && flash_map[a_i][a_j] == 0
      flash_map[a_i][a_j] = 1
      propagate(map, flash_map, a_i, a_j)
    end
  end
end
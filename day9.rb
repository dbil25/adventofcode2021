def day9(string)
  map = string.split("\n").map { |line| line.split("").map { |char| char.to_i } }
  
  current_cave_index = 1
  map.each_with_index.sum do |row, i|
    row.each_with_index.sum do |cell, j|
      top = i > 0 ? map.dig(i-1, j) : nil
      left = j > 0 ? row[j-1] : nil
      adjactents = [left, row[j+1], top, inmapput.dig(i+1, j)]
      adjactents.all? { |adj| adj.nil? || cell < adj } ? cell + 1 : 0
    end
  end
end

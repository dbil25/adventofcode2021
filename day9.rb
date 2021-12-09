def day9(string)
  input = string.split("\n").map { |line| line.split("").map { |char| char.to_i } }
  input.each_with_index.sum do |row, i|
    row.each_with_index.sum do |cell, j|
      top = i > 0 ? input.dig(i-1, j) : nil
      left = j > 0 ? row[j-1] : nil
      adjactents = [left, row[j+1], top, input.dig(i+1, j)]
      adjactents.all? { |adj| adj.nil? || cell < adj } ? cell + 1 : 0
    end
  end
end
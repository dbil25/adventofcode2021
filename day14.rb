def day14(string)
  polymer, recipe = string.split("\n\n")
  polymer = polymer.split("")
  recipe = recipe.split("\n").map { |line| line.split(" -> ") }
  recipe = recipe.map { |line| [line[0].split(""), line[1]] }.to_h
  recipe.inspect
  (1..10).each do |i|
    polymer = process_polymer(polymer, recipe)
  end
  puts polymer.join("")
  distinct_chars = polymer.uniq
  counts = distinct_chars.map do |char|
    polymer.count(char)
  end
  puts counts.max
  puts counts.min
  counts.max - counts.min
end

def process_polymer(polymer, recipe)
  new_polymer = []
  polymer.each_with_index do |char, i|
    new_polymer << char
    next_char = polymer[i + 1]
    new_char = recipe[[char, next_char]]
    new_polymer << new_char if new_char
  end
  new_polymer
end
def day14(string)
  polymer, recipe = string.split("\n\n")
  polymer = polymer.split("")
  recipe = recipe.split("\n").map { |line| line.split(" -> ") }
  recipe = recipe.map { |line| [line[0].split(""), line[1]] }.to_h
  count_per_key = recipe.keys.map { |key| [key, 0] }.to_h
  polymer.each_with_index do |char, i|
    count_per_key[[char, polymer[i + 1]]] += 1 unless polymer[i + 1].nil?
  end
  last_char = polymer.last
 
  (1..40).each do |i|
    count_per_key = process_polymer(count_per_key, recipe)
  end
  count_per_char = {}
  count_per_key.each do |key, count|
    count_per_char[key[0]] = count_per_char[key[0]].nil? ? count : count_per_char[key[0]] + count
  end
  count_per_char[last_char] = count_per_char[last_char].nil? ? 1 : count_per_char[last_char] + 1
  puts count_per_char.values.max
  puts count_per_char.values.min
  count_per_char.values.max - count_per_char.values.min
end

def process_polymer(count_per_key, recipe)
  new_count_per_key = {}
  count_per_key.each do |key, count|
    if recipe[key]
      new_char = recipe[key]
      new_count_per_key[[key[0], new_char]] = new_count_per_key[[key[0], new_char]].nil? ? count : new_count_per_key[[key[0], new_char]] + count
      new_count_per_key[[new_char, key[1]]] = new_count_per_key[[new_char, key[1]]].nil? ? count : new_count_per_key[[new_char, key[1]]] + count
    else
      new_count_per_key[key] += count
    end
  end
  new_count_per_key
end
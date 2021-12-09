def day6(string)
  fishes = Array.new(9, 0)

  string.split(",").map(&:to_i).each { |i| fishes[i] += 1 }
  (0..255).each do
    new_fishes = Array.new(9, 0)
    fishes.each_with_index do |number, i|
      if i == 0
        new_fishes[8] = number
        new_fishes[6] += number
      else
        new_fishes[i-1] += number
      end
    end
    fishes = new_fishes
  end
  fishes.sum
end

def day7(string)
  positions = string.split(",").map(&:to_i)
  max_position = positions.max
  crabs_in_each_position = Array.new(max_position+1, 0)
  total_cost_in_each_position = Array.new(max_position+1, 0)

  positions.each do |position|
    crabs_in_each_position[position] += 1
  end

  total_cost_in_each_position = total_cost_in_each_position.each_with_index.map do |position, i|
    crabs_in_each_position.each_with_index.sum do |crab_amount, crab_index|
      distance = (crab_index - i).abs
      fuel = (distance+1)*distance/2
      crab_amount * fuel
    end
  end

  total_cost_in_each_position.each_with_index.min
end
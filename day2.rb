def compute(array)
  x = 0
  depth = 0
  aim = 0
  array.each do |direction, amount|
    amount = amount.to_i
    if direction == "forward"
      x += amount
      depth += amount * aim
    end
    if direction == "down"
      aim += amount
    end
    if direction == "up"
      aim -= amount
    end
  end
  return x, depth
end
def compute(array)
  byte_size = array.first.size

  array2 = array
  (0..byte_size-1).each do |index|
    most_common = (array2.sum { |i| i[index].to_i(2) } < array2.size/2.0 ? "0" : "1" )
    array2 = array2.map do |bits|
      bits[index] == most_common ? bits : nil
    end.compact
    if array2.size == 1
      break
    end
  end
  oxygen = array2.first
  puts oxygen

  array2 = array
  (0..byte_size-1).each do |index|
    most_common = (array2.sum { |i| i[index].to_i(2) } < array2.size/2.0 ? "0" : "1" )
    array2 = array2.map do |bits|
      bits[index] == most_common ? nil : bits
    end.compact
    if array2.size == 1
      break
    end
  end
  co2 = array2.first
  puts co2
  oxygen.to_i(2) * co2.to_i(2)
end
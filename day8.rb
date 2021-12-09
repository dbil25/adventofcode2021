def day8(string)
  values = string.split("\n").map { |line| line.split(" | ").map { |v| v.split(" ")} }
  values.sum do |row|
    mapping = deduce_row(row[0])
    sum_output(row[1], mapping)
  end
end

def deduce_row(row)
  mapping = {}
  one = row.find { |v| v.size == 2 }.split("")
  seven = row.find { |v| v.size == 3 }.split("")
  four = row.find { |v| v.size == 4 }.split("")
  eight = row.find { |v| v.size == 7 }.split("")

  mapping["a"] = (seven - one).first
  b_or_d = four - one
  c_or_f = one
  e_or_g = eight - seven - four
  zero_or_six_or_nine = row.select { |v| v.size == 6 }.map { |v| v.split("") }
  six = zero_or_six_or_nine.find { |v| !c_or_f.all? { |o| v.include?(o) } }
  mapping["c"] = (eight - six).first
  mapping["f"] = (one - [mapping["c"]]).first
  nine = zero_or_six_or_nine.find { |v| !e_or_g.all? { |o| v.include?(o) } }
  mapping["e"] = (eight - nine).first
  mapping["g"] = (e_or_g - [mapping["e"]]).first
  zero = ((zero_or_six_or_nine - [six]) - [nine]).first
  mapping["d"] = (eight - zero).first
  mapping["b"] = (b_or_d - [mapping["d"]]).first
  mapping
end

def sum_output(row, mapping)
  mapping = mapping.map { |k, v| [v, k] }.to_h
  row.sum do |number|
    case number.size
    when 2
      ["1"]
    when 3
      ["7"]
    when 4
      ["4"]
    when 5
      correct_mapping = number.split("").map { |n| mapping[n] }
      if correct_mapping - ["a", "c", "d", "e", "g"] == []
        ["2"]
      elsif correct_mapping - ["a", "b", "d", "f", "g"] == []
        ["5"]
      else
        ["3"]
      end
    when 6
      correct_mapping = number.split("").map { |n| mapping[n] }
      if correct_mapping - ["a", "b", "c", "e", "f", "g"] == []
        ["0"]
      elsif correct_mapping - ["a", "b", "c", "d", "f", "g"] == []
        ["9"]
      else
        puts correct_mapping.inspect
        ["6"]
      end
    when 7
      ["8"]
    end
  end.join("").to_i
end

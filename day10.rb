def day10(string)
  lines = string.split("\n")
  lines.sum { |line| parse_line(line) }
end

def parse_line(line)
  line = line.split("")
  my_stack = []
  line.each do |char|
    case char
    when "["
      my_stack.push("]")
    when "("
      my_stack.push(")")
    when "<"
      my_stack.push(">")
    when "{"
      my_stack.push("}")
    when "]"
      poped = my_stack.pop
      if poped == nil
        return 0
      elsif poped != "]"
        return 57
      end
    when ")"
      poped = my_stack.pop
      if poped == nil
        return 0
      elsif poped != ")"
        return 3
      end 
    when ">"
      poped = my_stack.pop
      if poped == nil
        return 0
      elsif poped != ">"
        return 25137
      end 
    when "}"
      poped = my_stack.pop
      if poped == nil
        return 0
      elsif poped != "}"
        return 1197
      end 
    end
  end
  0
end
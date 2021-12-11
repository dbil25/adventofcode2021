def day10(string)
  lines = string.split("\n")
  scores = lines.map { |line| parse_line(line) }.reject { |score| score == 0 }.sort
  scores[scores.size/2]
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
      if poped != "]"
        return 0
      end
    when ")"
      poped = my_stack.pop
      if poped != ")"
        return 0
      end 
    when ">"
      poped = my_stack.pop
      if poped != ">"
        return 0
      end 
    when "}"
      poped = my_stack.pop
      if poped != "}"
        return 0
      end 
    end
  end
  score = 0
  my_stack.reverse.each do |missing_char|
    char_score = 0
    case missing_char
    when ")"
      char_score = 1
    when "]"
      char_score = 2
    when "}"
      char_score = 3
    when ">"
      char_score = 4
    end
    score = score * 5 + char_score
  end
  score
end
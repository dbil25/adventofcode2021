def day13(string)
  dots, folds = string.split("\n\n")
  dots = dots.split("\n").map { |line| line.split(',').map(&:to_i) }
  folds = folds.split("\n").map { |line| line.split('fold along ')[1].split("=") }

  dotmap = Array.new(dots.max_by { |dot| dot[1] }[1] +1) { Array.new(dots.max_by { |dot| dot[0] }[0] + 1, 0) }
  dots.each do |dot|
    dotmap[dot[1]][dot[0]] = 1
  end

  folds.each do |fold|
    dotmap = fold(dotmap, fold)
  end

  dotmap.each { |line| puts line.map { |char| char == 1 ? "#" : "."}.join(" ") }
  dotmap.flatten.sum
end

def fold(dotmap, fold)
  axis = fold[0]
  index = fold[1].to_i
  if axis == 'x'
    (0..dotmap.length-1).each do |i|
      (0..index-1).each do |j|
        dotmap[i][j] = dotmap[i][j] | dotmap[i][-j-1]
      end
    end
    dotmap.map{ |line| line[0..index-1] }
  elsif axis == 'y'
    (0..index - 1).each do |i|
      (0..dotmap[0].length - 1).each do |j|
        dotmap[i][j] = dotmap[i][j] | dotmap[-i - 1][j]
      end
    end
    dotmap[0..index-1]
  end
end
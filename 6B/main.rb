class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def manhattan(x, y)
    return (@x - x).abs + (@y - y).abs
  end
end

limit = 10000
max_x = 0
max_y = 0
points = $stdin.each_line.map do |input|
  x, y = input.chomp.split(', ').map(&:to_i)
  max_x = x if x > max_x
  max_y = y if y > max_y
  Point.new(x, y)
end
max_x+=1
max_y+=1

matrix = Array.new(max_y) { Array.new(max_x) { 0 } }

count = 0
for i in 0..max_y-1
  for j in 0..max_x-1
    selected_point = nil
    min_dist = max_x + max_y
    for point in points
      dist = point.manhattan(j, i)
      matrix[i][j] += dist
    end

    count += 1 if matrix[i][j] < limit
  end
end

p count
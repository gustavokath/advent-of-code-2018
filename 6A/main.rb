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

max_x = 0
max_y = 0
max_map = {}
points = $stdin.each_line.map do |input|
  x, y = input.chomp.split(', ').map(&:to_i)
  max_x = x if x > max_x
  max_y = y if y > max_y
  point = Point.new(x, y)
  max_map[point] = 0
  point
end
max_x+=1
max_y+=1

matrix = Array.new(max_y) { Array.new(max_x) { 0 } }
infinit_points = {}


for i in 0..max_y-1
  for j in 0..max_x-1
    selected_point = nil
    min_dist = max_x + max_y
    equal_dist = false

    for point in points
      dist = point.manhattan(j, i)
      if dist < min_dist
        min_dist = dist
        selected_point = point
        equal_dist = false
      elsif dist == min_dist
        equal_dist = true
      end
    end

    unless equal_dist
      max_map[selected_point] += 1
      matrix[i][j] = selected_point
      if i == 0 || j == 0 || i == max_y-1 || j == max_x-1
        infinit_points[selected_point] = true
      end
    end
  end
end

max_area = 0
max_map.each do |key, value|
  if !infinit_points.key?(key) && value > max_area
    max_area = value
  end
end

p max_area
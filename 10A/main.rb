class Point
    attr_accessor :position_x, :position_y, :velocity_x, :velocity_y
    
    def initialize(position_x, position_y, velocity_x, velocity_y)
        @position_x = position_x
        @position_y = position_y
        @velocity_x = velocity_x
        @velocity_y = velocity_y
    end
end

def future(points, time)
    points.map { |p| [p.position_x + p.velocity_x * time, p.position_y + p.velocity_y * time]}
end

def display(maps)
    (100..130).each do |y|
        line = (150..300).map do |x|
            maps.include?([x, y]) ? '#' : '.'
        end
        puts line.join('')
    end
end

def distance(points, seconds)
    cur = 0
    for i in 0..points.length-2
        for j in i+1..points.length-1
            dist_x = (points[i].position_x + (seconds * points[i].velocity_x)) - (points[j].position_x + (seconds * points[j].velocity_x))
            dist_y = (points[i].position_y + (seconds * points[i].velocity_y)) - (points[j].position_y + (seconds * points[j].velocity_y))
            cur += dist_x.abs + dist_y.abs
        end
    end
    cur
end

points = $stdin.each_line.map do |input|
    position_x, position_y, velocity_x, velocity_y = input[10..-1].chomp.split(/,|> velocity=<|x/).map(&:to_i)
    Point.new(position_x, position_y, velocity_x, velocity_y)
end

min_dist = 999999999999
cur = 0
seconds = 0
window = 100
while window > 0
    cur = distance(points, seconds)
    if min_dist >= cur
        min_dist = cur 
        min_sec = seconds
    else
        break if window / 2 == 0
        seconds = min_sec - window 
        min_dist = distance(points, seconds)
        window = window / 2
    end 
    seconds += window
end

display(future(points, seconds -1))
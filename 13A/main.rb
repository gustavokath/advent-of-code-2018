class Car
  attr_accessor :x, :y, :dir_x, :dir_y

  def initialize(x, y)
    @x = x
    @y = y
    @dir_x = 0
    @dir_y = 0
  end
end

def colision?(cars)
  for i in 0..cars.length-2
    if cars[i].x == cars[i+1].x && cars[i].y == cars[i+1].y
      p "#{cars[i].x},#{cars[i].y}"
      return true
    end
  end
  false
end

cars = []
intersections = {}
y = 0
map = $stdin.each_line.map do |input|
  line = input.split('')
  for x in 0..line.length-1
    if line[x] == '+'
      intersections["#{x},#{y}"] = 'L'
    elsif line[x] == 'v' || line[x] == '^' || line[x] == '>' || line[x] == '<'
      car = Car.new(x, y)
      car.dir_y = 1 if line[x] == 'v'
      car.dir_y = -1 if line[x] == '^'
      car.dir_x = -1 if line[x] == '<'
      car.dir_x = 1 if line[x] == '>'

      cars.push(car)
    end
  end
  y += 1
  line
end


cars.sort_by!{|car| [car.y, car.x] }
colision = false

while !colision?(cars)
  for car in cars
    position = map[car.y][car.x]
    if position == '\\' || (position == '+' && intersections["#{car.x},#{car.y}"] == 'R')
      temp_x = car.dir_x
      car.dir_x = car.dir_y
      car.dir_y = temp_x
      intersections["#{car.x},#{car.y}"] == 'S' if position == '+'
    elsif position == '/' || (position == '+' && intersections["#{car.x},#{car.y}"] == 'L')
      temp_x = car.dir_x
      car.dir_x = car.dir_y * -1
      car.dir_y = temp_x * -1
      intersections["#{car.x},#{car.y}"] == 'R' if position == '+'
    elsif position == "+"
      intersections["#{car.x},#{car.y}"] == 'L'
    end

    car.x += car.dir_x
    car.y += car.dir_y
    cars.sort_by!{|car| [car.y, car.x] }
  end
end

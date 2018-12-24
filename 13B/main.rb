class Car
  attr_accessor :x, :y, :dir_x, :dir_y, :turn

  def initialize(x, y, turn)
    @x = x
    @y = y
    @dir_x = 0
    @dir_y = 0
    @turn = turn
  end
end

def collision(cars, car)
  cars.each do |other|
    if car.x == other.x && car.y == other.y && car != other
      return [other, car]
    end
  end
  []
end

def display(map, cars)
  temp_map = map.map(&:clone)
  cars.each do |car|
    temp_map[car.y][car.x] = 'C'
  end

  for i in 0..temp_map.length-1
    for j in 0..temp_map[i].length-1
      print temp_map[i][j]
    end
    p
  end
end

cars = []
y = 0
map = $stdin.each_line.map do |input|
  line = input.split('')
  for x in 0..line.length-1
    if line[x] == 'v' || line[x] == '^' || line[x] == '>' || line[x] == '<'
      car = Car.new(x, y, 'L')
      car.dir_y = 1 if line[x] == 'v'
      car.dir_y = -1 if line[x] == '^'
      car.dir_x = -1 if line[x] == '<'
      car.dir_x = 1 if line[x] == '>'
      line[x] = '.'

      cars.push(car)
    end
  end
  y += 1
  line
end


cars.sort_by!{|car| [car.y, car.x] }
collision = false

while cars.length > 1
  remove = []
  for car in cars
    position = map[car.y][car.x]
    if position == '\\' || (position == '+' && ((car.turn == 'L' && car.dir_y != 0) || (car.turn == 'R' && car.dir_x != 0)))
      temp_x = car.dir_x
      car.dir_x = car.dir_y
      car.dir_y = temp_x
      if position == '+' && car.turn == 'R'
        car.turn = 'L'
      elsif position == '+' && car.turn == 'L'
        car.turn = 'S'
      end
    elsif position == '/' || (position == '+' && ((car.turn == 'L' && car.dir_x != 0) || (car.turn == 'R' && car.dir_y != 0)))
      temp_x = car.dir_x
      car.dir_x = car.dir_y * -1
      car.dir_y = temp_x * -1
      if position == '+' && car.turn == 'R'
        car.turn = 'L'
      elsif position == '+' && car.turn == 'L'
        car.turn = 'S'
      end
    elsif car.turn == 'S' && position == '+'
      car.turn = 'R'
    end

    car.x += car.dir_x
    car.y += car.dir_y

    remove += collision(cars, car)
  end
  cars = cars - remove
  cars.sort_by!{|car| [car.y, car.x] }
end

p "#{cars.first.x},#{cars.first.y}"

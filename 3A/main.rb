require 'matrix'
matrix = Array.new(1000) { Array.new(1000) { 0 } }
count = 0

$stdin.each_line do |line|
    elements = line.split(' @ ')
    id = elements[0]
    elements = elements[1].chomp.split(': ')
    x, y = elements[0].chomp.split(',').map(&:to_i)
    width, height = elements[1].chomp.split('x').map(&:to_i)

    for i in y..y+height-1
        for j in x..x+width-1
            matrix[i][j] += 1
            count += 1 if matrix[i][j] == 2
        end
    end
end

puts count

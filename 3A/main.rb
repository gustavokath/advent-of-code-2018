require 'matrix'
matrix = Matrix.empty(1000)
count = 0

$stdin.each_line do |line|
    elements = line.split(' @ ')
    id = elements[0].to_i
    elements = elements[1].chomp.split(': ')
    puts elements
    x, y = elements[0].chomp.split(',').map(&:to_i)
    width, height = elements[1].chomp.split('x').map(&:to_i)
    puts id
    puts x.to_s + " " + y.to_s
    puts width.to_s + " " + height.to_s
    puts " ------ "

    for i in x..width-1
        for j in y..height-1
            if matrix[i][j] == 0
                matrix[i][j] = 1
                count += 1
            end
        end
    end
end

puts count

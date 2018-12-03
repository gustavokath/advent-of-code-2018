require 'matrix'
matrix = Array.new(1000) { Array.new(1000) { 0 } }
inputs = []

inputs = $stdin.each_line.map do |input|
    entry = input[1..-1].chomp.split(/@ |: |,|x/).map(&:to_i)
    {
        id: entry[0],
        x: entry[1],
        y: entry[2],
        width: entry[3],
        height: entry[4]
    }
end

inputs.each do |entry|
    for i in entry[:y]..entry[:y]+entry[:height]-1
        for j in entry[:x]..entry[:x]+entry[:width]-1
            matrix[i][j] += 1
        end
    end
end

inputs.each do |entry|
    overlap = false
    for i in entry[:y]..entry[:y]+entry[:height]-1
        for j in entry[:x]..entry[:x]+entry[:width]-1
            overlap = true if matrix[i][j] >= 2
        end
    end
    p entry[:id] unless overlap
end

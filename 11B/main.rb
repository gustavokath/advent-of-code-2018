serial = $stdin.readline.chomp.to_i

grid = Array.new(300){ Array.new(300) {0} }

def cell_fuel(x, y, serial)
  rack_id = x + 10
  power_starts = rack_id * y
  value = (serial + power_starts) * rack_id
  digit = (value/100).digits[0]
  digit - 5
end

for i in 0..grid.length-1
  for j in 0..grid.length-1
    grid[i][j] = cell_fuel(i+1, j+1, serial)
  end
end

max = 0
corner = []
for size in 0..299
  for i in 0..grid.length-(size+1)
    for j in 0..grid.length-(size+1)
      cur = 0
      for k in 0..size
        for l in 0..size
          cur += grid[i+k][j+l]
        end
      end
      if cur > max
        max = cur
        corner = [i+1,j+1,size+1]
      end
    end
  end
  p "#{size} - #{corner}"
end

p corner


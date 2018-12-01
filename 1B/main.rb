sum = 0
set = {}
found = false
array = $stdin.each_line.map(&:to_i)

while !found do
  array.each do |value|
    sum += value
    found = set.key?(sum)
    break if found
    set[sum] = true
  end
end
p sum
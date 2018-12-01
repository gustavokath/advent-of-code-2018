sum = 0
$stdin.each_line do |line|
  value = line.to_i
  puts value
  sum += value
  puts sum
end
p sum
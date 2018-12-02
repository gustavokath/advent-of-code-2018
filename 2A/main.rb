sum = 0
count_two = 0
count_three = 0
$stdin.each_line do |line|
  map = {}
  found_two = false
  found_three = false
  line.split('').each do |letter|
    map[letter] = 0 unless map.key?(letter)
    map[letter] += 1
  end

  map.each do |letter, count|
    break if found_three && found_two

    if !found_two && count == 2
      found_two = true
      count_two += 1
    end

    if !found_three && count == 3
      found_three = true
      count_three += 1
    end
  end
end

puts count_two * count_three
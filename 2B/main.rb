sum = 0
count_two = 0
count_three = 0
lines = $stdin.each_line.map(&:to_s)

for i in 0..lines.length-2
  for j in i+1..lines.length-1
    dif = 0
    first_word = lines[i]
    next_word = lines[j]

    #puts first_word
    #puts next_word
    for k in 0..first_word.length
      dif += 1 if first_word[k] != next_word[k]
    end

    #puts dif

    if dif < 1
      puts "AQUI"
      for k in 0..first_word.length
        if first_word[k] == next_word[k]
          print first_word[k]
        end
      end
    end
  end

end
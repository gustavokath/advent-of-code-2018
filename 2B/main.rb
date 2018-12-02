def main
  string = ""
  lines = $stdin.each_line.map(&:chomp)

  for i in 0..lines.length-2
    first_word = lines[i]
    for j in i+1..lines.length-1
      dif = 0
      next_word = lines[j]

      for k in 0..first_word.length-1
        dif += 1 if first_word[k] != next_word[k]
      end

      if dif == 1
        for k in 0..first_word.length-1
          string += first_word[k] if first_word[k] == next_word[k]
        end

        return string
      end
    end
  end
end

puts main
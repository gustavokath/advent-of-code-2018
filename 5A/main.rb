input = $stdin.readline.chomp.split('')

j= 0
i = 0
while i < input.length-2
  j = i+1

  #Check for case diference based on ASCII table
  if(input[i].downcase == input[j].downcase && ((input[i].ord > 90 && input[j].ord <=90) || (input[i].ord <= 90 && input[j].ord >90)))
    input.slice!(i,2)
    i -= 1
    i = 0 if i <= 0
  else
    i += 1
  end
end

p input.length
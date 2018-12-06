input = $stdin.readline.chomp.split('')
options = ('a'..'z').to_a

min_lenght = (2**(0.size * 8 -2) -1) #MAX Integer

for letter in options do
  manipulate = input.map(&:clone)
  manipulate.delete(letter)
  manipulate.delete(letter.upcase)

  j= 0
  i = 0
  while i < manipulate.length-2
    j = i+1

    #Check for case diference based on ASCII table
    if(manipulate[i].downcase == manipulate[j].downcase && ((manipulate[i].ord > 90 && manipulate[j].ord <=90) || (manipulate[i].ord <= 90 && manipulate[j].ord >90)))
      manipulate.slice!(i,2)
      i -= 1
      i = 0 if i <= 0
    else
      i += 1
    end
  end

  min_lenght = manipulate.length if min_lenght > manipulate.length


end

p min_lenght
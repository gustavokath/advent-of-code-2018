def sum_metadata(index, sum, input)
    n_childs = input[index]
    n_metadata = input[index+1]

    index += 2
    for i in 0..n_childs-1
        index, sum = sum_metadata(index, sum, input)
    end


    for i in 0..n_metadata-1
        sum += input[index]
        index += 1
    end
    return index, sum
end

input = $stdin.readline.chomp.split(' ').map(&:to_i)

index, sum = sum_metadata(0,0, input)
p sum

def sum_metadata(index, input)
    start = index
    n_childs = input[index]
    n_metadata = input[index+1]
    childs = []

    index += 2
    sum_cur = 0
    for i in 0..n_childs-1
        index, sum = sum_metadata(index, input)
        childs.push(sum)
    end

    if n_childs == 0
        for i in 0..n_metadata-1
            sum_cur += input[index]
            index += 1
        end
    else
        for i in 0..n_metadata-1
            access_child = input[index]
            sum_cur += childs[access_child-1] if access_child > 0 && access_child <= childs.length
            index += 1
        end
    end
    return index, sum_cur
end

input = $stdin.readline.chomp.split(' ').map(&:to_i)

index, sum = sum_metadata(0, input)
p sum

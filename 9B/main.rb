class Node
    attr_accessor :value, :prev, :next

    def initialize(value, prev=nil, nxt=nil)
        @value = value
        @prev = prev
        @next = nxt
    end
end

def remove_seven_before(node, count=0)
    return remove_seven_before(node.prev, count+1) if count != 7

    node.prev.next = node.next
    node.next.prev = node.prev
    node
end

input = $stdin.readline.chomp.split(' ')
n_players = input[0].to_i
last = input[6].to_i * 100

current_marble = Node.new(0)
current_marble.prev = current_marble
current_marble.next = current_marble
players = Array.new(n_players){0}

next_marble = 1
current_player = 0
max_score = 0

while next_marble <= last
    if next_marble % 23 == 0
        players[current_player] += next_marble
        removed = remove_seven_before(current_marble)
        players[current_player] += removed.value
        current_marble = removed.next
        if players[current_player] > max_score
            max_score = players[current_player] 
        end
    else
        new_marble = Node.new(next_marble)
        new_marble.prev = current_marble.next
        new_marble.next = current_marble.next.next

        new_marble.prev.next = new_marble
        new_marble.next.prev = new_marble
        current_marble = new_marble
    end
    current_player = (current_player + 1) % players.length
    next_marble += 1
end

p max_score

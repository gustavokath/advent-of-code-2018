input = $stdin.readline.chomp.split(' ')
n_players = input[0].to_i
last = input[6].to_i

marbles = [0]
players = Array.new(n_players){0}

next_marble = 1
current_player = 0
current_marble = 0
current_marble_index = 0
max_score = 0

p n_players
p last
p marbles
p players

while next_marble <= last
    p next_marble
    p current_marble_index 
    p marbles.length
    p '---------'
    next_position = (current_marble_index + 1) % marbles.length
    next_position += 1 if next_position == 0
    if next_marble % 23 == 0
        p "Adding for player #{current_player}"
        players[current_player] += next_marble
        p players[current_player]
        p next_marble
        p next_position
        p marbles
        remove_index = (next_position - 7) % marbles.length
        removed = marbles.delete_at(remove_index)
        p removed
        p '-----------'
        players[current_player] += removed
        current_marble_index = remove_index
        current_marble = marbles[remove_index]
        if players[current_player] > max_score
            max_score = players[current_player] 
        end
    else
        marbles.insert(next_position, next_marble)
        current_marble = next_marble
        current_marble_index = next_position
    end
    current_player = (current_player + 1) % players.length
    next_marble += 1
end

p max_score

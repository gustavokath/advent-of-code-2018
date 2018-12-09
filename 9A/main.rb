input = $stdin.readline.chomp.split(' ')
n_players = input[0].to_i
last = input[6].to_i

marbles = [0]
players = Array.new(n_players){0}

next_marble = 1
current_player = 0
current_marble_index = 0
max_score = 0

while next_marble <= last
    next_position = (current_marble_index + 2) % (marbles.length + 1)
    next_position = 1 if next_position == 0
    if next_marble % 23 == 0
        players[current_player] += next_marble 
        remove_index = (current_marble_index - 7) % marbles.length
        removed = marbles.delete_at(remove_index)
        players[current_player] += removed
        current_marble_index = remove_index
        max_score = players[current_player]  if players[current_player] > max_score
    else
        marbles.insert(next_position, next_marble)
        current_marble_index = next_position
    end
    current_player = (current_player + 1) % players.length
    next_marble += 1
end

p max_score

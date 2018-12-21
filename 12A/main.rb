state = $stdin.readline.chomp[15..-1]
start_position = 4
state = '....' + state + '..'
$stdin.readline.chomp # skip one line

rule_hash = {}
$stdin.each_line do |input|
  rule, result = input.chomp.split(' => ')
  rule_hash[rule] = result if result == '#'
end

p rule_hash

count = 0
p state
20.times do
  new_state = state.clone
  for i in 2..state.length-3
    current = state[i-2..i+2]
    if rule_hash.key?(current)
      #p i
      #p current
      #p rule_hash[current]
      new_state[i] = rule_hash[current]
      #p state
      #p new_state
      #p '-----------------------------------------'
    else
      new_state[i] = '.'
    end
  end

  state = new_state
  if state[-1] == '#' || state[-2] == '#' || state[-3] == '#'
    state += '..'
  end
end

state.split('').each_with_index do |value, index|
  count += index - start_position if value == '#'
end

p count
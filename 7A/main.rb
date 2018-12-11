require 'set'
class Node
  attr_accessor :letter, :dependencies, :unlocks

  def initialize(letter)
    @letter = letter
    @dependencies = []
    @unlocks = []
  end
end

letter_map = {}
available = Set[]
executed = Set[]
execution = []

$stdin.each_line do |line|
  items = line.split(' ')
  dependency = items[1]
  unlock = items[7]

  unless letter_map.key?(dependency)
    letter_map[dependency] = Node.new(dependency)
    available.add(dependency)
  end

  unless letter_map.key?(unlock)
    letter_map[unlock] = Node.new(unlock)
  end

  available.delete?(unlock)

  letter_map[dependency].unlocks.push(unlock)
  letter_map[unlock].dependencies.push(dependency)
end


available = available.to_a
while !available.empty?
  available.sort!
  current = letter_map[available.shift]
  executed.add(current.letter)
  execution.push(current.letter)

  current.unlocks.each do |letter|
    node = letter_map[letter]
    node.dependencies.each do |dependency|
      node.dependencies.delete(dependency) if executed.include?(dependency)
    end
    available.push(node.letter) if node.dependencies.empty?
  end
end

p execution.join('')
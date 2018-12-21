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
inprogres = {}
execution = []
workers_num = 5
workers = Array.new(workers_num){nil}

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
num_nodes = letter_map.keys.length

time = 0
available = available.to_a
while num_nodes > executed.length
  inprogres.each do |job, value|
    next if time < value

    inprogres.delete(job)
    executed.add(job)
    execution.push(job)

    current = letter_map[job]
    current.unlocks.each do |letter|
      node = letter_map[letter]
      node.dependencies.each do |dependency|
        node.dependencies.delete(dependency) if executed.include?(dependency)
      end
      available.push(node.letter) if node.dependencies.empty?
    end
  end

  available.sort!

  workers.each_with_index do |job, worker|
    next if job != nil && inprogres.key?(job)

    unless available.empty?
      next_job = letter_map[available.shift]
      inprogres[next_job.letter] = (next_job.letter.ord - 'A'.ord) + 1 + 60 + time
      workers[worker] = next_job.letter
    else
      workers[worker] = nil
    end
  end

  time += 1 if num_nodes != executed.length
end

p time
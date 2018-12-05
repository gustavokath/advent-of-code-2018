require 'date'
class Entry
  attr_accessor :id, :datetime, :action

  def initialize(datetime, action, id=nil)
    @id = id
    @datetime = datetime
    @action = action
  end

  def start?
    action == 'begins'
  end

  def sleep?
    action == 'falls'
  end

  def wake?
    action == 'wakes'
  end
end

inputs = $stdin.each_line.map do |input|
  elements = input[1..-1].chomp.split(/] /)
  date = DateTime.parse(elements[0])
  elements = elements[1].chomp.split(' ')
  if elements[0] == 'Guard'
    id = elements[1][1..-1].to_i
    action = elements[2]
  else
    id = nil
    action = elements[0]
  end

  Entry.new(date, action, id)
end

inputs.sort_by! {|entry| entry.datetime }

cur_sleep = 0
cur_id = 0
sleep_map = {}
inputs.each do |entry|
  cur_id = entry.id if entry.start?
  cur_sleep = entry.datetime if entry.sleep?

  if entry.wake?
    sleep_map[cur_id] = { sleep: Array.new(60, 0), max: 0, time: -1, total: 0 } unless sleep_map.key?(cur_id)
    for i in cur_sleep.minute..entry.datetime.minute-1
      sleep_map[cur_id][:sleep][i] += 1
      sleep_map[cur_id][:total] += 1
      if sleep_map[cur_id][:sleep][i] > sleep_map[cur_id][:max]
        sleep_map[cur_id][:max] = sleep_map[cur_id][:sleep][i]
        sleep_map[cur_id][:time] = i
      end
    end
  end
end

max_id = 0
max_sleep = 0
max_time = 0
sleep_map.each do |key, value|
  if value[:total] > max_sleep
    max_sleep = value[:total]
    max_time = value[:time]
    max_id = key
  end
end

p max_id
p max_time
p max_id * max_time



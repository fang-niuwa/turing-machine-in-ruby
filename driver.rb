$LOAD_PATH << '.'
require 'turingMachine'
require 'state'
require 'set'

# input = ARGV[0]
#print input.split("##")[0] + "#\n"
input = "#q0,_->qr,_,R#q0,a->qr,a,R#q0,a->q1,a,R#q0,b->q1,b,R#q1,a->q2,a,R#q1,b->q2,b,R#q2,b->q2,b,R#q2,_->q2,_,R#q1,a->qa,a,R##abbb#"
arr_input = input.split("#")
arr_input.delete_at(arr_input.length - 2)
arr_input.delete_at(0)
constructor = arr_input[0..arr_input.length - 2]
string = arr_input.last.split("")

states = Set[]
constructor.each do |t|
  states << State.new(t.split("->")[0].split(",")[0])
  states << State.new(t.split("->")[1].split(",")[0])
end

s = states.to_a

constructor.each do |t|
  current_state = t.split("->")[0].split(",")[0]
  pop = t.split("->")[0].split(",")[1] == "_"? nil : t.split("->")[0].split(",")[1]
  push = t.split("->")[1].split(",")[1] == "_"? nil : t.split("->")[1].split(",")[1]
  next_state = t.split("->")[1].split(",")[0]
  direction = t.split("->")[1].split(",")[2] == "R"? 1 : -1
  i = s.index(State.new(current_state))
  j = s.index(State.new(next_state))
  trans = Transection.new(s[i], s[j], pop, push, direction)
  index = s.index(State.new(current_state))
  s[index].add_transection(trans)
end

output1 = input.split("##")
puts "#{output1[0]}#"
puts s.length
puts string.length

index = s.index(State.new("q0"))
turingMachine = TuringMachine.new(s, s[index], 0)
case turingMachine.read_string(string)
when -1
  puts "M is still running"
when 0
  puts "M stops and rejects w"
when 1
  puts "M stops and accepts w"
end

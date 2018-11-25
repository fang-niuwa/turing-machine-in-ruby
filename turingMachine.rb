$LOAD_PATH << '.'
require 'transection'
require 'state'
require 'set'

class TuringMachine
  def initialize(states, current_state, tape_head = 0)
    @states = states
    @current_state = current_state
    @tape_head = tape_head
    #puts "#{@tape_head}"
  end
  attr_accessor :states, :current_state, :tape_head

  # add a state to the TM
  def add_state(state)
    @states << state
  end

  # the method takes an Array input, and return integer
  # return lo if machine is still running
  # return qr if machine is accepted
  # return qa if machine is rejected
  def read_string(string, steps = 0)
    return -1 if steps == 21
    return 0 if @current_state.name == "qr"
    return 1 if @current_state.name == "qa"
    result = -1
    @current_state.transections.each do |t|
      if t.pop == string[@tape_head]
        # binding.pry
        #puts "#{@tape_head} #{string[@tape_head]} #{t.current_state.name} #{t.next_state.name} pop: #{t.pop} push: #{t.push} #{string}"
        string[@tape_head] = t.push
        next_step = TuringMachine.new(@states, t.next_state, @tape_head + t.direction)
        #puts "tape head take moves #{t.direction}"
        feedback = next_step.read_string(string, steps + 1)
        result = feedback if feedback > result
      end
    end
    result
  end
end

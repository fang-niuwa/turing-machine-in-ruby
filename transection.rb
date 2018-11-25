class Transection
  include Comparable
  def initialize(current_state, next_state, pop, push, direction)
    @current_state = current_state
    @next_state = next_state
    @pop = pop
    @push = push
    @direction = direction
  end
  attr_reader :current_state, :next_state, :pop, :push, :direction

  def ==(other)
    return false if @current_state != other.current_state
    return false if @next_state != other.next_state
    return false if @pop != other.pop
    return false if @push != other.push
    return false if @direction != other.direction
    true
  end
end

class State
  include Comparable
  def initialize(name)
    @name = name
    @transections = []
  end
  attr_accessor :name, :transections

  def add_transection(transection)
    @transections << transection
  end

  def ==(other)
    @name == other.name
  end
  alias eql? ==

  def hash
    @name.hash
  end
end

class Value
  attr_accessor :data, :label, :gradient, :backward
  attr_reader :operation, :children

  def initialize(data:, label: nil, operation: nil, children: [], gradient: 0.0)
    @data = data
    @label = label
    @operation = operation
    @children = children
    @gradient = gradient
    @backward = -> {} # default is no-op, e.g. for leaf nodes
  end

  # Coerce is called when calling an operation on a Numeric
  # e.g. 4 + Value.new(data: 2) => <Value(: 6)>
  # see: https://stackoverflow.com/questions/2799571/in-ruby-how-does-coerce-actually-work
  def coerce(other)
    [self, other]
  end

  def +(other)
    other = Value.new(data: other) unless other.is_a?(Value)
    out = Value.new(
      data: data + other.data,
      operation: :+,
      children: [self, other]
    )
    out.backward = -> {
      self.gradient += 1.0 * out.gradient
      other.gradient += 1.0 * out.gradient
    }
    out
  end

  def *(other)
    other = Value.new(data: other) unless other.is_a?(Value)
    out = Value.new(
      data: data * other.data,
      operation: :*,
      children: [self, other]
    )
    out.backward = -> {
      self.gradient += other.data * out.gradient
      other.gradient += data * out.gradient
    }
    out
  end

  def **(other)
    raise ArgumentError.new("Only implemented for scalar values") unless other.is_a?(Numeric)
    out = Value.new(
      data: data**other,
      operation: :"**#{other}",
      children: [self]
    )
    out.backward = -> {
      self.gradient += other * (data**(other - 1)) * out.gradient
    }
    out
  end

  def exp
    out = Value.new(
      data: Math.exp(data),
      operation: :exp,
      children: [self]
    )
    out.backward = -> {
      self.gradient += out.data * out.gradient
    }
    out
  end

  def tanh
    out = Value.new(
      data: Math.tanh(data),
      operation: :tanh,
      children: [self]
    )
    out.backward = -> {
      self.gradient += 1.0 - (out.data**2)
    }
    out
  end

  def -@
    self * -1
  end

  def -(other)
    self + -other
  end

  def /(other)
    self * (other**-1)
  end

  def backpropagate
    topological_sort.reverse_each do |value|
      value.backward.call
    end
  end

  # Recursively traverse each child before adding the parent to the sorted list
  def topological_sort(visited = [], sorted = [])
    if !visited.include?(self)
      visited << self
      children.each do |child|
        child.topological_sort(visited, sorted)
      end
      sorted << self
    end
    sorted
  end

  def to_s
    "<Value(#{label}: #{sprintf("%0.04f", data)})>"
  end
end

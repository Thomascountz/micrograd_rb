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

  def +(other)
    out = Value.new(
      data: data + other.data,
      operation: :+,
      children: [self, other]
    )
    backward = -> {
      self.gradient = 1.0 * out.gradient
      other.gradient = 1.0 * out.gradient
    }
    out.backward = backward
    out
  end

  def *(other)
    out = Value.new(
      data: data * other.data,
      operation: :*,
      children: [self, other]
    )
    backward = -> {
      self.gradient = other.data * out.gradient
      other.gradient = data * out.gradient
    }
    out.backward = backward
    out
  end

  def tanh
    out = Value.new(
      data: Math.tanh(data),
      operation: :tanh,
      children: [self]
    )
    backward = -> {
      self.gradient = 1.0 - (out.data**2)
    }
    out.backward = backward
    out
  end

  def to_s
    "<Value(#{label}: #{@data})>"
  end
end

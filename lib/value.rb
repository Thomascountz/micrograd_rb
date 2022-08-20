class Value
  attr_accessor :data, :label, :gradient
  attr_reader :operation, :children

  def initialize(data:, label: nil, operation: nil, children: [], gradient: 0.0)
    @data = data
    @label = label
    @operation = operation
    @children = children
    @gradient = gradient
  end

  def +(other)
    Value.new(
      data: data + other.data,
      operation: :+,
      children: [self, other]
    )
  end

  def *(other)
    Value.new(
      data: data * other.data,
      operation: :*,
      children: [self, other]
    )
  end

  def tanh
    Value.new(
      data: Math.tanh(data),
      operation: :tanh,
      children: [self]
    )
  end

  def to_s
    "<Value(#{label}: #{@data})>"
  end
end

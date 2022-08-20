class Value
  attr_accessor :data, :label
  attr_reader :operation, :children

  def initialize(data:, label: nil, operation: nil, children: [])
    @data = data
    @label = label
    @operation = operation
    @children = children
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

  def to_s
    "<Value(#{label}: #{@data})>"
  end
end

require "./lib/value"

class Neuron
  attr_reader :weights, :bias
  def initialize(size:)
    @weights = Array.new(size) { Value.new(data: rand(-1.0..1.0)) }
    @bias = Value.new(data: rand(-1.0..1.0))
  end

  def parameters
    weights + [bias]
  end

  def call(inputs:)
    raise ArgumentError.new("Neuron expects #{weights.size} inputs. Got #{inputs.size}.") unless inputs.size == weights.size
    activation = inputs.zip(weights).map { |xi, wi| xi * wi }.sum(bias)
    activation.tanh
  end
end

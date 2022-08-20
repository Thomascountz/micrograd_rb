require "./lib/neuron"

class Layer
  attr_reader :neurons, :input_size, :output_size

  def initialize(input_size:, output_size:)
    @input_size = input_size
    @output_size = output_size
    @neurons = Array.new(output_size) { Neuron.new(size: input_size) }
  end

  def parameters
    neurons.map(&:parameters).flatten
  end

  def call(inputs:)
    raise ArgumentError.new("Layer expects #{input_size} inputs. Got #{inputs.size}.") unless inputs.size == input_size
    out = neurons.map { |n| n.call(inputs: inputs) }
    out.size == 1 ? out.first : out
  end
end

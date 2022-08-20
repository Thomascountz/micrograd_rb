require "./lib/layer"

class MLP
  attr_reader :layers

  def initialize(layer_sizes:)
    @layers = []
    @input_size = layer_sizes.first
    layer_sizes.each_cons(2) do |input_size, output_size|
      @layers << Layer.new(input_size: input_size, output_size: output_size)
    end
  end

  def parameters
    layers.map(&:parameters).flatten
  end

  def call(inputs:)
    raise ArgumentError.new("MLP expects #{@input_size} inputs. Got #{inputs.size}.") unless inputs.size == @input_size
    @layers.each do |layer|
      inputs = layer.call(inputs: inputs)
    end
    inputs
  end
end

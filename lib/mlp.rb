require "./lib/layer"

class MLP
  attr_reader :input_size, :output_sizes, :layers

  def initialize(input_size:, output_sizes:)
    @input_size = input_size
    @output_sizes = output_sizes
    @layers = []
    ([input_size] + output_sizes).each_cons(2) do |input_size, output_size|
      @layers << Layer.new(input_size: input_size, output_size: output_size)
    end
  end

  def call(inputs:)
    raise ArgumentError.new("MLP expects #{input_size} inputs. Got #{inputs.size}.") unless inputs.size == input_size
    @layers.each do |layer|
      inputs = layer.call(inputs: inputs)
    end
    inputs
  end
end

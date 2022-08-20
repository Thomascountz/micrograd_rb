require "./lib/layer"

RSpec.describe Layer do
  it "initializes `output_size` number of Nuerons with `input_size` size" do
    layer = Layer.new(input_size: 2, output_size: 3)
    expect(layer.neurons.length).to eq(3)
    expect(layer.neurons.all? { |n| n.weights.length == 2 }).to be_truthy
  end

  describe "#parameters" do
    it "returns the weights and bias of all neurons" do
      layer = Layer.new(input_size: 2, output_size: 3)
      expect(layer.parameters).to eq(layer.neurons.map(&:parameters).flatten)
    end
  end

  describe "#call" do
    it "returns the activation of the layer" do
      layer = Layer.new(input_size: 2, output_size: 3)
      result = layer.call(inputs: [1, 1])
      expect(result.length).to eq(3)
      expect(result.all? { |n| n.data.between?(-1, 1) }).to be_truthy
    end

    it "raises an error if the number of inputs doesn't match the number of neurons" do
      layer = Layer.new(input_size: 2, output_size: 3)
      expect { layer.call(inputs: [1]) }.to raise_error(ArgumentError)
    end
  end
end

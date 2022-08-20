require "./lib/mlp"

RSpec.describe MLP do
  it "initializes a layer for each pair of input and output sizes" do
    mlp = MLP.new(layer_sizes: [3, 4, 4, 1])
    expect(mlp.layers.length).to eq(3)
    expect(mlp.layers[0].input_size).to eq(3)
    expect(mlp.layers[0].output_size).to eq(4)
    expect(mlp.layers[1].input_size).to eq(4)
    expect(mlp.layers[1].output_size).to eq(4)
    expect(mlp.layers[2].input_size).to eq(4)
    expect(mlp.layers[2].output_size).to eq(1)
  end

  describe "#parameters" do
    it "returns the parameters of all layers" do
      mlp = MLP.new(layer_sizes: [3, 4, 4, 1])
      expect(mlp.parameters).to eq(mlp.layers.map(&:parameters).flatten)
    end
  end

  describe "#call" do
    it "returns the value of the final layer" do
      mlp = MLP.new(layer_sizes: [3, 4, 4, 1])
      expect(mlp.call(inputs: [1, 1, 1])).to a_kind_of(Value)
    end

    it "returns a list of values if the output size is > 1" do
      mlp = MLP.new(layer_sizes: [3, 4, 4, 3])
      expect(mlp.call(inputs: [1, 1, 1])).to be_a(Array).and all(be_a(Value))
    end

    it "raises an error if the number of inputs doesn't match input size" do
      mlp = MLP.new(layer_sizes: [3, 4, 4, 3])
      expect { mlp.call(inputs: [1]) }.to raise_error(ArgumentError)
    end
  end
end

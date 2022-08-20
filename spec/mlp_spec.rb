require "./lib/mlp"

RSpec.describe MLP do
  it "initializes a layer for each pair of input and output sizes" do
    mlp = MLP.new(input_size: 3, output_sizes: [4, 4, 1])
    expect(mlp.layers.length).to eq(3)
    expect(mlp.layers.first.input_size).to eq(3)
    expect(mlp.layers.last.output_size).to eq(1)
  end

  describe "#call" do
    it "returns the value of the final layer" do
      mlp = MLP.new(input_size: 3, output_sizes: [4, 4, 1])
      expect(mlp.call(inputs: [1, 1, 1])).to a_kind_of(Value)
    end

    it "returns a list of values if the output size is > 1" do
      mlp = MLP.new(input_size: 3, output_sizes: [4, 4, 3])
      expect(mlp.call(inputs: [1, 1, 1])).to be_a(Array).and all(be_a(Value))
    end

    it "raises an error if the number of inputs doesn't match input size" do
      mlp = MLP.new(input_size: 3, output_sizes: [4, 4, 1])
      expect { mlp.call(inputs: [1]) }.to raise_error(ArgumentError)
    end
  end
end

require "./lib/neuron"

RSpec.describe Neuron do
  it "initializes with `x` random weights between -1 and 1" do
    neuron = Neuron.new(size: 2)
    expect(neuron.weights.length).to eq(2)
    expect(neuron.weights.all? { |w| w.data >= -1 && w.data <= 1 }).to be_truthy
  end
  it "initializes with a random bias between -1 and 1" do
    neuron = Neuron.new(size: 2)
    expect(neuron.bias.data).to be_between(-1, 1)
  end

  describe "#parameters" do
    it "returns the weights and bias" do
      neuron = Neuron.new(size: 2)
      expect(neuron.parameters).to eq([neuron.weights, neuron.bias].flatten)
    end
  end

  describe "#call" do
    it "returns the activation of the neuron" do
      neuron = Neuron.new(size: 2)
      expect(neuron.call(inputs: [1, 1]).data).to be_between(-1, 1)
    end

    it "raises an error if the number of inputs doesn't match the number of weights" do
      neuron = Neuron.new(size: 2)
      expect { neuron.call(inputs: [1]) }.to raise_error(ArgumentError)
    end
  end
end

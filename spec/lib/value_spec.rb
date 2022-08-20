require "./lib/value"

RSpec.describe Value do
  it "holds data" do
    expect(Value.new(data: 1).data).to eq 1
  end

  it "has a label" do
    expect(Value.new(data: 1, label: :foo).label).to eq :foo
  end

  it "has a gradient" do
    expect(Value.new(data: 1, gradient: 5.1).gradient).to eq 5.1
  end

  it "prints nicely" do
    expect(Value.new(data: 1, label: :a).to_s).to eq "<Value(a: 1)>"
  end

  describe "+" do
    it "returns a Value object whose data is the sum of data in the operand Values" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      result_value = a + b
      expect(result_value.data).to eq 2
    end

    it "returns a Value object whose result operation is :+" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      result_value = a + b
      expect(result_value.operation).to eq :+
    end

    it "returns a Value object whose children are the operand Values" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      result_value = a + b
      expect(result_value.children).to eq [a, b]
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      result_value = a + b
      result_value.gradient = 1.0
      result_value.backward.call
      expect(a.gradient).to eq 1.0
      expect(b.gradient).to eq 1.0
    end
  end

  describe "*" do
    it "returns a Value object whose data is the sum of the operand Values" do
      a = Value.new(data: 1)
      b = Value.new(data: 2)
      expect((a * b).data).to eq 2
    end

    it "returns a Value object whose result operation is :*" do
      a = Value.new(data: 1)
      b = Value.new(data: 2)
      result_value = a * b
      expect(result_value.operation).to eq :*
    end

    it "returns a Value object whose children are the operand Values" do
      a = Value.new(data: 1)
      b = Value.new(data: 2)
      result_value = a * b
      expect(result_value.children).to eq [a, b]
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 1)
      b = Value.new(data: 2)
      result_value = a * b
      result_value.gradient = 2.0
      result_value.backward.call
      expect(a.gradient).to eq 4.0
      expect(b.gradient).to eq 2.0
    end
  end

  describe "tanh" do
    it "returns a Value object whose data is the tanh of the operand" do
      a = Value.new(data: 1)
      expect(a.tanh.data).to eq Math.tanh(1)
    end

    it "returns a Value object whose result operation is :tanh" do
      a = Value.new(data: 1)
      expect(a.tanh.operation).to eq :tanh
    end

    it "returns a Value object whose children is the operand Value" do
      a = Value.new(data: 1)
      expect(a.tanh.children).to eq [a]
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 0.8814)
      result_value = a.tanh
      result_value.gradient = 1.0
      result_value.backward.call
      expect(a.gradient).to be_within(0.0001).of(0.5)
    end
  end

  describe "topological sort" do
    it "returns a list of Values in topological order" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      c = a + b
      d = Value.new(data: 1)
      e = c + d
      expect(e.topological_sort).to eq [a, b, c, d, e]
    end
  end

  describe "backpropagate" do
    it "calls the backward function of each Values in reverse topological order" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      c = a + b
      d = Value.new(data: 1)
      e = c + d
      e.gradient = 1.0
      expect(d.backward).to receive(:call).ordered
      expect(c.backward).to receive(:call).ordered
      expect(b.backward).to receive(:call).ordered
      expect(a.backward).to receive(:call).ordered
      e.backpropagate 
    end
  end
end

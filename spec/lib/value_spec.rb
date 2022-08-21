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
    expect(Value.new(data: 1, label: :a).to_s).to eq "<Value(a: 1.0000)>"
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

    it "accepts a non-Value operand" do
      a = Value.new(data: 1)
      b = 1
      result_value = a + b
      expect(result_value.data).to eq 2
    end

    it "can be coerced into a Numeric" do
      a = 1
      b = Value.new(data: 1)
      result_value = a + b
      expect(result_value.data).to eq 2
    end
  end

  describe "*" do
    it "returns a Value object whose data is the mutiplication of the operand Values" do
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

    it "accepts a non-Value operand" do
      a = Value.new(data: 1)
      b = 2
      expect((a * b).data).to eq 2
    end

    it "can be coerced into a Numeric" do
      a = 2
      b = Value.new(data: 1)
      result_value = a * b
      expect(result_value.data).to eq 2
    end
  end

  describe "**" do
    it "returns a Value object whose data is the raising of one operand by the other" do
      a = Value.new(data: 2)
      expect((a**2).data).to eq 4.0
    end

    it "returns a Value object whose result operation is :**<other>" do
      a = Value.new(data: 2)
      result_value = a**2
      expect(result_value.operation).to eq :"**2"
    end

    it "returns a Value object whose children are the operand Value" do
      a = Value.new(data: 1)
      result_value = a**2
      expect(result_value.children).to eq [a]
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 2)
      result_value = a**2
      result_value.gradient = 12.0
      result_value.backward.call
      expect(a.gradient).to eq 48.0
    end

    it "the exponent must be Numberic" do
      a = Value.new(data: 2)
      expect { a**"2" }.to raise_error(ArgumentError)
    end
  end

  describe "exp" do
    it "returns a Value object whose data is the natural exponetiation of the operand Value" do
      a = Value.new(data: 2)
      result_value = a.exp
      expect(result_value.data).to be_within(0.001).of(7.389)
    end

    it "returns a Value object whose result operation is :exp" do
      a = Value.new(data: 2)
      result_value = a.exp
      expect(result_value.operation).to eq :exp
    end

    it "returns a Value object whose children is the operand Value" do
      a = Value.new(data: 2)
      result_value = a.exp
      expect(result_value.children).to eq [a]
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 2)
      result_value = a.exp
      result_value.gradient = 2.0
      result_value.backward.call
      expect(a.gradient).to within(0.0001).of(14.77811)
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
      a = Value.new(data: 0.5)
      result_value = a.tanh
      result_value.gradient = 14.0
      result_value.backward.call
      expect(a.gradient).to be_within(0.01).of(11.0102682)
    end
  end

  describe "@-" do
    it "returns a Value object whose data is the negation of data in the operand Value" do
      a = Value.new(data: 1)
      result_value = -a
      expect(result_value.data).to eq(-1)
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 1)
      result_value = -a
      result_value.gradient = 1.0
      result_value.backward.call
      expect(a.gradient).to eq(-1.0)
    end
  end

  describe "-" do
    it "returns a Value object whose data is the negation of data in the operand Value" do
      a = Value.new(data: 2)
      b = Value.new(data: 1)
      result_value = a - b
      expect(result_value.data).to eq(1)
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

  describe "/" do
    it "returns a Value object whose data is the division of the operand Values" do
      a = Value.new(data: 1)
      b = Value.new(data: 2)
      expect((a / b).data).to eq 0.5
    end

    it "returns a Value whose backward is a proc to set the derivative of its children according to the chain rule" do
      a = Value.new(data: 3)
      b = Value.new(data: 2)
      result_value = a / b
      result_value.gradient = 3.0
      result_value.backward.call
      expect(a.gradient).to eq 1.5
      expect(b.gradient).to eq 0.0
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

    it "allows gradients to accumulate when the same Value is used in an operation" do
      a = Value.new(data: 1)
      b = a + a
      b.gradient = 1.0
      b.backpropagate
      expect(a.gradient).to eq 2.0
    end

    it "allows gradients to accumulate when the same Value is used in a multiple operations" do
      a = Value.new(data: 2)
      b = Value.new(data: 1)
      c = a * b
      d = a * b
      e = c * d
      e.gradient = 1.0
      e.backpropagate
      expect(a.gradient).to eq 4.0
      expect(b.gradient).to eq 8.0
    end
  end
end

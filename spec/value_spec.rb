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
  end

  describe "*" do
    it "returns a Value object whose data is the sum of the operand Values" do
      a = Value.new(data: 2)
      b = Value.new(data: 2)
      expect((a * b).data).to eq 4
    end

    it "returns a Value object whose result operation is :*" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      result_value = a * b
      expect(result_value.operation).to eq :*
    end

    it "returns a Value object whose children are the operand Values" do
      a = Value.new(data: 1)
      b = Value.new(data: 1)
      result_value = a * b
      expect(result_value.children).to eq [a, b]
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
  end
end

require "./lib/value"
require "./mermaid/graph_html_writer"

# tanh(w1x1 + w2x2 + b)
x1 = Value.new(data: 2.0, label: :x1)
w1 = Value.new(data: -3.0, label: :w1)
x2 = Value.new(data: 0.0, label: :x2)
w2 = Value.new(data: 1.0, label: :w2)
b = Value.new(data: 6.8813735870195432, label: :b)

x1w1 = x1 * w1
x1w1.label = :x1w1
x2w2 = x2 * w2
x2w2.label = :x2w2
x1w1x2w2 = x1w1 + x2w2
x1w1x2w2.label = :x1w1x2w2
n = x1w1x2w2 + b
n.label = :n
o = n.tanh
o.label = :o

# default gradient is 1.0
o.gradient = 1.0

# Gradient of tanh is 1 - tanh^2(n) and we already know the value of
# tanh(n) = o.data

# tanh(n) = o
n.gradient = 1 - o.data**2

# Gradient of x1w1x2w2 is the gradient of n because the gradient of
# addition is always 1 and the chain rule multiplies 1 by the gradient
# of n which is just n.gradient

# x1w1x2w2 + b = n
x1w1x2w2.gradient = n.gradient
b.gradient = n.gradient

# Continually, the gradient of the operands of the addition w.r.t. o
# is the gradient of the result of the addition w.r.t. o

# x1w1 + x2w2 = x1w1x2w2
x1w1.gradient = x1w1x2w2.gradient
x2w2.gradient = x1w1x2w2.gradient

# With multiplication, the local gradient of the operands is equal to
# the value of the other operand, then the chain rule multiplies the
# local gradient of the operand by the gradient of the resultant

# x1 * w1 = x1w1
x1.gradient = x1w1.gradient * w1.data
w1.gradient = x1w1.gradient * x1.data

# x2 * w2 = x2w2
x2.gradient = x2w2.gradient * w2.data
w2.gradient = x2w2.gradient * x2.data

# Use the Mermaid::GraphHTMLWriter to write the mermaid graph to an 
# html file that we can open in the browswer
Mermaid::GraphHTMLWriter.write(o, "perceptron_manual_backprop.html")

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
o.backpropagate

Mermaid::GraphHTMLWriter.write(o, "perceptron_auto_backprop.html")

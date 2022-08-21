require "./lib/mlp"
require "./mermaid/graph_html_writer"

xs = [
  [2.0, 3.0, -1.0],
  [3.0, -1.0, 0.5],
  [0.5, 1.0, 1.0],
  [1.0, 1.0, -1.0]
]
ys = [1.0, -1.0, -1.0, 1.0] # desired targets

mlp = MLP.new(layer_sizes: [3, 4, 4, 1])
loss = nil
50.times do |i|
  # forward pass
  predictions = xs.map { |x| mlp.call(inputs: x) }
  loss = predictions.zip(ys).sum { |ypred, y| (ypred - y)**2 }

  # backward pass
  # First, set all of the parameter gradients to 0 so that we don't accumulate gradients from previous iterations
  mlp.parameters.each { |p| p.gradient = 0.0 }
  loss.backpropagate

  # update weights
  mlp.parameters.each { |param| param.data += -0.1 * param.gradient }

  puts "Iteration #{i}: loss = #{loss.data}"
end

mlp.parameters.each_with_index { |param, i| param.label = "param#{i}" }

Mermaid::GraphHTMLWriter.write(loss, "trained_mlp.html")

require "./lib/mlp"
require "./mermaid/graph_html_writer"

mlp = MLP.new(layer_sizes: [3, 4, 4, 1])
result = mlp.call(inputs: [1.0, 0.25, 3.5])
result.backpropagate
Mermaid::GraphHTMLWriter.write(result, "mlp.html")

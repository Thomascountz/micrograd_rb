class MermaidGraph
  GRAPH = "graph"
  LEFT_TO_RIGHT = "LR"

  # Outputs a mermaid.js graph string for a given root node
  # Node Format: node.label.upcase[node.label.upcase | (node.gradient) | node.data]
  # Operation Format: node.label.upcase + operation_to_s(node.operation)[(node.operation)]
  # Edge Format: node.label.upcase + operation_to_s(node.operation) --> node.label.upcase
  def self.output(root)
    out = GRAPH + " " + LEFT_TO_RIGHT + "\n"

    trace = trace(root)

    trace[:nodes].each do |node|
      out << node_string(node) # C["C | (1.000) | 2.000"]
      if node.operation
        out << operation_node_string(node, node.operation) # Cplus(("+"))
        out << result_edge_string(node, node.operation) # Cplus --> K
      end
    end

    trace[:edges].each do |edge|
      out << operand_edge_string(edge) # A --> Cplus, B --> Cplus
    end

    out
  end

  def self.trace(root, nodes = [], edges = [])
    raise "Missing label for node: #{root}" unless root.label
    if !nodes.include?(root)
      nodes << root
      root.children.each do |child|
        edges << [child, root]
        trace(child, nodes, edges)
      end
    end
    {nodes: nodes, edges: edges}
  end

  def self.node_string(node)
    "#{node.label.upcase}[\"#{node.label.upcase} | (GRAD) | #{sprintf("%0.03f", node.data)}\"]\n"
  end

  def self.operation_node_string(node, operation)
    "#{node.label.to_s.upcase + operation_to_s(operation)}((\"#{operation}\"))\n"
  end

  def self.result_edge_string(node, operation)
    "#{node.label.to_s.upcase + operation_to_s(node.operation)} --> #{node.label.to_s.upcase}\n"
  end

  def self.operand_edge_string(edge_nodes)
    "#{edge_nodes[0].label.upcase} --> #{edge_nodes[1].label.to_s.upcase + operation_to_s(edge_nodes[1].operation)}\n"
  end

  def self.operation_to_s(operation)
    if operation == :+
      "plus"
    elsif operation == :*
      "mul"
    else
      raise "Unknown operation: #{operation}"
    end
  end
end

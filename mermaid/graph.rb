module Mermaid
  class Graph
    GRAPH = "graph".freeze
    LEFT_TO_RIGHT = "LR".freeze
    GREEN_FILL = "classDef green fill:#3ddc97;".freeze

    # Outputs a mermaid.js graph string for a given root node
    # Node Format: node.label.upcase[node.label.upcase | (node.gradient) | node.data]
    # Operation Format: node.label.upcase + operation_to_s(node.operation)[(node.operation)]
    # Edge Format: node.label.upcase + operation_to_s(node.operation) --> node.label.upcase
    def self.output(root, **opts)
      out = GRAPH + " " + LEFT_TO_RIGHT + "\n" + GREEN_FILL + "\n"

      trace = trace(root)
      labeled = trace[:nodes].map { |n| n.label.to_s.upcase }.reject { |n| n.empty? }

      trace[:nodes].each do |node|
        node.label = node.object_id.to_s if node.label.nil?
        out << node_string(node) # C["C | (1.000) | 2.000"]
        if node.operation
          out << operation_node_string(node, node.operation) # Cplus(("+"))
          out << result_edge_string(node, node.operation) # Cplus --> K
        end
      end

      trace[:edges].each do |edge|
        out << operand_edge_string(edge) # A --> Cplus, B --> Cplus
      end

      out << "class #{labeled.join(",")} green;"
    end

    def self.trace(root, nodes = [], edges = [])
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
      "#{node.label.upcase}[\"#{node.label.upcase} | grad:#{sprintf("%0.04f", node.gradient)} | data:#{sprintf("%0.04f", node.data)}\"]\n"
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
      case operation
      when :+
        "plus"
      when :*
        "mul"
      when :tanh
        "tanh"
      when :exp
        "exp"
      when ->(op) { op.to_s.start_with?("**") }
        "pow"
      else
        raise "Unknown operation: #{operation}"
      end
    end
  end
end

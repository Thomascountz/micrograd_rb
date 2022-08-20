require_relative "./graph"

module Mermaid
  class GraphHTMLWriter
    OUT_FILE = "index.html"

    def self.write(root, outfile = OUT_FILE)
      graph = Mermaid::Graph.output(root)
      File.write(File.join("out", outfile), html_string(graph))
    end

    def self.html_string(graph)
      %{<!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
    </head>
    <body style="font-family:monospace">
      <div class="mermaid">
        #{graph}
      </div>
     <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
     <script>mermaid.initialize({startOnLoad:true, fontFamily: 'monospace'});</script>
    </script>
    </body>
    </html>}
    end
  end
end

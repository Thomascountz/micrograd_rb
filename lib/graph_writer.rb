require "./mermaid_graph"

class MermaidGraphHTMLWriter
  OUT_FILE = "./out/index.html"

  def self.write(root, outfile = OUTFILE)
    graph = MermaidGraph.output(root)
    File.write(out_file, html_string(graph))
  end

  def self.html_string(graph)
    %{<!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
    </head>
    <body>
      <div class="mermaid">
        #{graph}
      </div>
     <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
     <script>mermaid.initialize({startOnLoad:true});
    </script>
    </body>
    </html>}
  end
end

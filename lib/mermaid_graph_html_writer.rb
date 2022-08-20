require_relative "./mermaid_graph"

class MermaidGraphHTMLWriter
  OUT_FILE = "index.html"

  def self.write(root, outfile = OUTFILE)
    graph = MermaidGraph.output(root)
    File.open(File.join("out", outfile), "w") do |f|
      f.write(html_string(graph))
    end
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

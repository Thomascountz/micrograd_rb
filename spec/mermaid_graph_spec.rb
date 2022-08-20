require "./lib/mermaid_graph"
require "./lib/value"

RSpec.describe MermaidGraph do
  describe ".output" do
    it "EXAMPLE 1" do
      a = Value.new(data: 1, label: :a)
      b = Value.new(data: 2, label: :b)
      c = a + b
      c.label = :c
      d = Value.new(data: 3, label: :d)
      e = c * d
      e.label = :e
      f = Value.new(data: 5, label: :f)
      g = e + f
      g.label = :g
      expect(MermaidGraph.output(g)).to eq "graph LR\nG[\"G | grad:0.0000 | data:14.0000\"]\nGplus((\"+\"))\nGplus --> G\nE[\"E | grad:0.0000 | data:9.0000\"]\nEmul((\"*\"))\nEmul --> E\nC[\"C | grad:0.0000 | data:3.0000\"]\nCplus((\"+\"))\nCplus --> C\nA[\"A | grad:0.0000 | data:1.0000\"]\nB[\"B | grad:0.0000 | data:2.0000\"]\nD[\"D | grad:0.0000 | data:3.0000\"]\nF[\"F | grad:0.0000 | data:5.0000\"]\nE --> Gplus\nC --> Emul\nA --> Cplus\nB --> Cplus\nD --> Emul\nF --> Gplus\n"
    end

    it "EXAMPLE 2" do
      a = Value.new(data: 3, label: :a)
      b = Value.new(data: 1, label: :b)
      c = a + b
      c.label = :c
      d = Value.new(data: 30, label: :d)
      e = c * d
      e.label = :e
      f = Value.new(data: 99, label: :f)
      g = e + f
      g.label = :g
      h = Value.new(data: 14, label: :h)
      i = g * h
      i.label = :i
      j = Value.new(data: 1, label: :j)
      k = i + j
      k.label = :k
      expect(MermaidGraph.output(k)).to eq "graph LR\nK[\"K | grad:0.0000 | data:3067.0000\"]\nKplus((\"+\"))\nKplus --> K\nI[\"I | grad:0.0000 | data:3066.0000\"]\nImul((\"*\"))\nImul --> I\nG[\"G | grad:0.0000 | data:219.0000\"]\nGplus((\"+\"))\nGplus --> G\nE[\"E | grad:0.0000 | data:120.0000\"]\nEmul((\"*\"))\nEmul --> E\nC[\"C | grad:0.0000 | data:4.0000\"]\nCplus((\"+\"))\nCplus --> C\nA[\"A | grad:0.0000 | data:3.0000\"]\nB[\"B | grad:0.0000 | data:1.0000\"]\nD[\"D | grad:0.0000 | data:30.0000\"]\nF[\"F | grad:0.0000 | data:99.0000\"]\nH[\"H | grad:0.0000 | data:14.0000\"]\nJ[\"J | grad:0.0000 | data:1.0000\"]\nI --> Kplus\nG --> Imul\nE --> Gplus\nC --> Emul\nA --> Cplus\nB --> Cplus\nD --> Emul\nF --> Gplus\nH --> Imul\nJ --> Kplus\n"
    end
  end
end

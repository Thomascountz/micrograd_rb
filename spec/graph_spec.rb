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
      expect(MermaidGraph.output(g)).to eq "graph LR\nG[\"G | (GRAD) | 14.000\"]\nGplus((\"+\"))\nGplus --> G\nE[\"E | (GRAD) | 9.000\"]\nEmul((\"*\"))\nEmul --> E\nC[\"C | (GRAD) | 3.000\"]\nCplus((\"+\"))\nCplus --> C\nA[\"A | (GRAD) | 1.000\"]\nB[\"B | (GRAD) | 2.000\"]\nD[\"D | (GRAD) | 3.000\"]\nF[\"F | (GRAD) | 5.000\"]\nE --> Gplus\nC --> Emul\nA --> Cplus\nB --> Cplus\nD --> Emul\nF --> Gplus\n"
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
      expect(MermaidGraph.output(k)).to eq "graph LR\nK[\"K | (GRAD) | 3067.000\"]\nKplus((\"+\"))\nKplus --> K\nI[\"I | (GRAD) | 3066.000\"]\nImul((\"*\"))\nImul --> I\nG[\"G | (GRAD) | 219.000\"]\nGplus((\"+\"))\nGplus --> G\nE[\"E | (GRAD) | 120.000\"]\nEmul((\"*\"))\nEmul --> E\nC[\"C | (GRAD) | 4.000\"]\nCplus((\"+\"))\nCplus --> C\nA[\"A | (GRAD) | 3.000\"]\nB[\"B | (GRAD) | 1.000\"]\nD[\"D | (GRAD) | 30.000\"]\nF[\"F | (GRAD) | 99.000\"]\nH[\"H | (GRAD) | 14.000\"]\nJ[\"J | (GRAD) | 1.000\"]\nI --> Kplus\nG --> Imul\nE --> Gplus\nC --> Emul\nA --> Cplus\nB --> Cplus\nD --> Emul\nF --> Gplus\nH --> Imul\nJ --> Kplus\n"
    end
  end
end

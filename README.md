# micrograd_rb

Reimplementation of the scalar-value backpropagation library, [karpathy/micrograd](https://github.com/karpathy/micrograd), but in Ruby and **WITH TESTS**! 

Follow along with [karpathy](https://github.com/karpathy)'s video here: https://www.youtube.com/watch?v=VMj-3S1tku0

Here's an example of a backprop on a single perceptron found in [/examples/perceptron_auto_backprop.rb](./examples/perceptron_auto_backprop.rb):

```mermaid
graph LR
  O["O | grad:1.0000 | data:0.7071"]
  Otanh(("tanh"))
  Otanh --> O
  N["N | grad:0.5000 | data:0.8814"]
  Nplus(("+"))
  Nplus --> N
  X1W1X2W2["X1W1X2W2 | grad:0.5000 | data:-6.0000"]
  X1W1X2W2plus(("+"))
  X1W1X2W2plus --> X1W1X2W2
  X1W1["X1W1 | grad:0.5000 | data:-6.0000"]
  X1W1mul(("*"))
  X1W1mul --> X1W1
  X1["X1 | grad:-1.5000 | data:2.0000"]
  W1["W1 | grad:1.0000 | data:-3.0000"]
  X2W2["X2W2 | grad:0.5000 | data:0.0000"]
  X2W2mul(("*"))
  X2W2mul --> X2W2
  X2["X2 | grad:0.5000 | data:0.0000"]
  W2["W2 | grad:0.0000 | data:1.0000"]
  B["B | grad:0.5000 | data:6.8814"]
  N --> Otanh
  X1W1X2W2 --> Nplus
  X1W1 --> X1W1X2W2plus
  X1 --> X1W1mul
  W1 --> X1W1mul
  X2W2 --> X1W1X2W2plus
  X2 --> X2W2mul
  W2 --> X2W2mul
  B --> Nplus
```

> **Warning**
> Like [karpathy](https://github.com/karpathy)'s, this is for pedagogical purposes only.
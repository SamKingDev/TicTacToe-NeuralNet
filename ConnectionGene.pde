class ConnectionGene {
  Node fromNode;
  Node toNode;
  float weight;
  boolean enabled = true;
  int innovationNo;
  ConnectionGene(Node from, Node to, float w, int inno) {
    fromNode = from;
    toNode = to;
    weight = w;
    innovationNo = inno;
  }
  void mutateWeight() {
    if (random(1) < 0.1) weight = random(-1, 1);
    else {
      weight += randomGaussian()/50;
      if (weight > 1) {
        weight = 1;
      } else if (weight < -1) {
        weight = -1;
      }
    }
  }
  ConnectionGene clone(Node from, Node to) {
    ConnectionGene clone = new ConnectionGene(from, to, weight, innovationNo);
    clone.enabled = enabled;
    return clone;
  }
}

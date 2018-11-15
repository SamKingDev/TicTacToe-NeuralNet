class Player {
  float fitness;
  Genome brain;
  boolean won = false;
  float steps = 0;

  int genomeInputs = 9;
  int genomeOutputs = 9;

  float[] vision = new float[genomeInputs];
  float[] decision = new float[genomeOutputs];

  Player() {
    brain = new Genome(genomeInputs, genomeOutputs);
    vision = new float[genomeInputs];
  }

  float[] think(Space[] spaces) {
    for(int i = 0; i < spaces.length; i++){
      vision[i] = spaces[i].team;
    }
    return brain.feedForward(vision);
  }
  
  Player clone() {
    Player clone = new Player();
    clone.brain = brain.clone();
    clone.fitness = fitness;
    clone.brain.generateNetwork();
    return clone;
  }
  
  void calculateFitness() {
    if (won == true) {
      fitness = 10 * ((6 - steps)/10);
    }
    else if(won == false) fitness = 0;
  }
  
  Player crossover(Player parent2) {
    Player child = new Player();
    child.brain = brain.crossover(parent2.brain);
    child.brain.generateNetwork();
    return child;
  }
}

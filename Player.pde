class Player {
  float fitness;
  Genome brain;
  float wins = 0;
  float losses = 0;
  float draws = 0;
  float gamesPlayed = 0;

  int genomeInputs = 9;
  int genomeOutputs = 9;

  float[] vision = new float[genomeInputs];
  float[] decision = new float[genomeOutputs];

  Player() {
    brain = new Genome(genomeInputs, genomeOutputs);
    vision = new float[genomeInputs];
  }

  float[] think(Space[] spaces, boolean isTeamCorrect) {
    for(int i = 0; i < spaces.length; i++){
      if(isTeamCorrect) vision[i] = spaces[i].team;
      else{
        if(spaces[i].team == -1) vision[i] = 1;
        else if(spaces[i].team == 1) vision[i] = -1;
      }
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
    fitness = ((draws * 7.5) + (wins * 10) + (losses * -10)) / gamesPlayed;
  }
  
  Player crossover(Player parent2) {
    Player child = new Player();
    child.brain = brain.crossover(parent2.brain);
    child.brain.generateNetwork();
    return child;
  }
}

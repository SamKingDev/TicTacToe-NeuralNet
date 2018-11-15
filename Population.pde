class Population {
  ArrayList<Player> originalPlayers = new ArrayList<Player>();
  int player1;
  int player2;
  int bestScore = 0;
  int gen = 0;
  int boardNo = 0;
  ArrayList<ConnectionHistory> innovationHistory = new ArrayList<ConnectionHistory>();
  ArrayList<Player> genPlayers = new ArrayList<Player>();
  Board board;
  int totalPlayers;
  Player bestPlayer;//the best ever player 

  boolean massExtinctionEven = false;
  boolean newStage = false;
  int populationLife = 0;

  Population(int size) {
    totalPlayers = size;
    gen = 0;
    for (int i =0; i<size; i++) {
      originalPlayers.add(new Player());
      originalPlayers.get(i).brain.generateNetwork();
      originalPlayers.get(i).brain.mutate(innovationHistory);
    }
    setRandomPlayers();
  }

  void showGo() {
    board.showGo();
  }

  void performGo() {
    gen++;
    if (board.winner == -1) board.haveGo();
    else {
      genPlayers.add(board.getPlayer1());
      genPlayers.add(board.getPlayer2());
      board = null;
      if (player1 > player2) {
        originalPlayers.remove(player1);
        originalPlayers.remove(player2);
      } else {
        originalPlayers.remove(player2);
        originalPlayers.remove(player1);
      }
      if (originalPlayers.size() > 0) { //pick new players
        boardNo++;
        setRandomPlayers();
      } else {
        //Generate next generation and mutate
        naturalSelection();
        setRandomPlayers();
        genPlayers.clear();
      }
    }
  }

  void naturalSelection() {
    println(genPlayers.size());
    genPlayers = sortPlayers();
    println(genPlayers.size());
    cullPlayers();
    originalPlayers.add(genPlayers.get(genPlayers.size() - 1).clone());
    println("won : " + genPlayers.get(genPlayers.size() - 1).won);
    println("steps : " + genPlayers.get(genPlayers.size() - 1).steps);
    println("fitness : " + genPlayers.get(genPlayers.size() - 1).fitness);
    println();
    while (originalPlayers.size() < totalPlayers) {
      originalPlayers.add(giveMeBaby());
    }
    for (int i = 0; i< originalPlayers.size(); i++) {//generate networks for each of the children
      originalPlayers.get(i).brain.generateNetwork();
    }
    gen++;
  }

  Player giveMeBaby() {
    Player baby;
    if (random(1) < 0.25) {//25% of the time there is no crossover and the child is simply a clone of a random(ish) player
      baby =  selectPlayer().clone();
    } else {//75% of the time do crossover 

      //get 2 random(ish) parents 
      Player parent1 = selectPlayer();
      Player parent2 = selectPlayer();

      //the crossover function expects the highest fitness parent to be the object and the lowest as the argument
      if (parent1.fitness < parent2.fitness) {
        baby =  parent2.crossover(parent1);
      } else {
        baby =  parent1.crossover(parent2);
      }
    }
    baby.brain.mutate(innovationHistory);//mutate that baby brain
    return baby;
  }

  Player selectPlayer() {
    float fitnessSum = 0;
    for (int i =0; i<genPlayers.size(); i++) {
      fitnessSum += genPlayers.get(i).fitness;
    }

    float rand = random(fitnessSum);
    float runningSum = 0;

    for (int i = 0; i<genPlayers.size(); i++) {
      runningSum += genPlayers.get(i).fitness; 
      if (runningSum > rand) {
        return genPlayers.get(i);
      }
    }
    //unreachable code to make the parser happy
    return genPlayers.get(0);
  }
  //-

  void cullPlayers() {
    int total = genPlayers.size() / 2;
    for (int i = 0; i < total; i++) {
      genPlayers.remove(0);
    }
  }

  ArrayList<Player> sortPlayers() {
    ArrayList<Player> tmpPlayers = new ArrayList<Player>();
    int size = genPlayers.size();
    for (int i = 0; i < size; i++) {
      float lowestFitness = genPlayers.get(0).fitness;
      int lowestFitnessId = 0;
      for (int j = 0; j < genPlayers.size(); j++) {
        if (lowestFitness > genPlayers.get(j).fitness) {
          lowestFitness =  genPlayers.get(j).fitness;
          lowestFitnessId = j;
        }
      }
      tmpPlayers.add(genPlayers.get(lowestFitnessId));
      genPlayers.remove(lowestFitnessId);
    }
    return tmpPlayers;
  }

  void setRandomPlayers() {
    player1 = int(random(originalPlayers.size()));
    player2 = int(random(originalPlayers.size()));
    while (player1 == player2) {
      player2 = int(random(originalPlayers.size()));
    }
    board = new Board(originalPlayers.get(player1), originalPlayers.get(player2));
  }
}

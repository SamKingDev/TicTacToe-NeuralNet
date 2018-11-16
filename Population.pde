class Population {
  ArrayList<Player> originalPlayers = new ArrayList<Player>();
  int player1;
  int player2;
  ArrayList<ConnectionHistory> innovationHistory = new ArrayList<ConnectionHistory>();
  ArrayList<Player> genPlayers = new ArrayList<Player>();
  Board board;
  int totalPlayers;
  Player bestPlayer;//the best ever player 
  int currentPlayer = 0; //current player 
  int currentPlaying = 0; //Who the current player is playing against
  int generation = 0;
  boolean isPlayer1 = true;
  ArrayList<Integer> playersPlayed = new ArrayList<Integer>();

  Population(int size) {
    totalPlayers = size;
    for (int i =0; i<size; i++) {
      originalPlayers.add(new Player());
      originalPlayers.get(i).brain.generateNetwork();
      originalPlayers.get(i).brain.mutate(innovationHistory);
    }
    getNextPlayer();
    board = new Board(originalPlayers.get(currentPlayer), originalPlayers.get(currentPlaying));
  }

  void showGo() {
    board.showGo();
  }

  void performGo() {
    if (board.winner == 0) board.haveGo(); //If there isn't a winner have a go
    else { //Else someone has won
      if (!(currentPlayer == originalPlayers.size() - 1 && playersPlayed.size() == 50)) { //If this generation isn't over
        if (playersPlayed.size() < 50) {
          getNextPlayer();
        } else {
          playersPlayed.clear();
          currentPlayer++;
          getNextPlayer();
        }
        board = null;
        if(playersPlayed.size() > 25) board = new Board(originalPlayers.get(currentPlayer), originalPlayers.get(currentPlaying));
        else  board = new Board(originalPlayers.get(currentPlaying), originalPlayers.get(currentPlayer));
      } else {//Generation is over
        generation++;
        for (int i = 0; i < originalPlayers.size(); i++) {
          originalPlayers.get(i).calculateFitness();
          genPlayers.add(originalPlayers.get(i));
        }
        originalPlayers.clear();
        naturalSelection();
        currentPlaying = 0;
        currentPlayer = 0;
        getNextPlayer();
      }
    }
  }

  void naturalSelection() {
    genPlayers = sortPlayers();
    cullPlayers();
    originalPlayers.add(genPlayers.get(genPlayers.size() - 1).clone());
    println("wins : " + genPlayers.get(genPlayers.size() - 1).wins);
    println("draws : " + genPlayers.get(genPlayers.size() - 1).draws);
    println("losses : " + genPlayers.get(genPlayers.size() - 1).losses);
    println("fitness : " + genPlayers.get(genPlayers.size() - 1).fitness);
    println();
    while (originalPlayers.size() < totalPlayers) {
      originalPlayers.add(giveMeBaby());
    }
    for (int i = 0; i< originalPlayers.size(); i++) {//generate networks for each of the children
      originalPlayers.get(i).brain.generateNetwork();
    }
  }

  Player giveMeBaby() {
    Player baby;
    if (random(1) < 0.10) {//10% of the time there is no crossover and the child is simply a clone of a random(ish) player
      baby =  selectPlayer().clone();
    } else {//90% of the time do crossover 

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
  
  void getNextPlayer() {
    boolean playerFound = false;
    while (!playerFound) {
      boolean duplicate = false;
      currentPlaying = int(random(originalPlayers.size() - 1));
      if(currentPlaying != currentPlayer) {
        if(playersPlayed.size() > 0){
         for(int played : playersPlayed){
           if(played == currentPlaying) duplicate = true;
         }
        } 
         if(!duplicate) playerFound = true;
      }
    }
    playersPlayed.add(currentPlaying);
  }
}

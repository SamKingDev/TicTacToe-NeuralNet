class Board {
  Space[] spaces;
  Player player1;
  Player player2;
  int currentGo = -1;
  int totalGoes = 0;
  int winner = 0;
  Board(Player player1, Player player2) {
    spaces = new Space[9];
    for (int i = 0; i < spaces.length; i++) {
      spaces[i] = new Space();
    }
    this.player1 = player1;
    this.player2 = player2;
  }
  boolean checkIfWin(int currentGo, int positionNumber) {
    int c = currentGo;
    switch (positionNumber) {
    case 0:
      if ((spaces[1].team == c && spaces[2].team == c) || (spaces[3].team == c && spaces[6].team == c) || (spaces[4].team == c && spaces[8].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 1:
      if ((spaces[4].team == c && spaces[7].team == c) || (spaces[0].team == c && spaces[2].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 2:
      if ((spaces[1].team == c && spaces[0].team == c) || (spaces[4].team == c && spaces[6].team == c) || (spaces[5].team == c && spaces[8].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 3:
      if ((spaces[0].team == c && spaces[6].team == c) || (spaces[4].team == c && spaces[5].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 4:
      if ((spaces[0].team == c && spaces[8].team == c) || (spaces[1].team == c && spaces[7].team == c) || (spaces[2].team == c && spaces[6].team == c) || (spaces[5].team == c && spaces[3].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 5:
      if ((spaces[2].team == c && spaces[8].team == c) || (spaces[3].team == c && spaces[4].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 6:
      if ((spaces[0].team == c && spaces[3].team == c) || (spaces[4].team == c && spaces[2].team == c) || (spaces[7].team == c && spaces[8].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 7:
      if ((spaces[4].team == c && spaces[1].team == c) || (spaces[6].team == c && spaces[8].team == c)) {
        winner = c;
        return true;
      }
      break;
    case 8:
      if ((spaces[6].team == c && spaces[7].team == c) || (spaces[0].team == c && spaces[4].team == c) || (spaces[2].team == c && spaces[5].team == c)) {
        winner = c;
        return true;
      }
      break;
    }
    return false;
  }

  void haveGo() {
    float[] results;
    int selectedSquare = 0;
    float highestValue = 0;
    if (currentGo == -1) results = player1.think(spaces, true);
    else results = player2.think(spaces, false);
    boolean[] squareTested = new boolean[results.length];
    for (int i = 0; i < squareTested.length; i++) {
      squareTested[i] = false;
    }
    for (int i = 0; i < results.length; i++) {
      if (highestValue < results[i]) {
        highestValue = results[i];
        selectedSquare = i;
      }
    }
    squareTested[selectedSquare] = true;
    while (spaces[selectedSquare].team != 0) {
      selectedSquare = 0;
      highestValue = -1000;
      for (int i = 0; i < results.length; i++) {
        if (highestValue < results[i] && squareTested[i] == false) {
          highestValue = results[i];
          selectedSquare = i;
        }
      }
      squareTested[selectedSquare] = true;
    }
    spaces[selectedSquare].team = currentGo;
    totalGoes++;
    if (checkIfWin(currentGo, selectedSquare)) {
      winnerFound();
    } else if (totalGoes == 9) {
      player1.draws++;
      player2.draws++;
      player1.gamesPlayed++;
      player2.gamesPlayed++;
      winner = -2;
    }

    if (winner == 0) {
      if (currentGo == -1) currentGo = 1;
      else currentGo = -1;
    }
  }
  void winnerFound() {
    if (currentGo == -1) 
    {
      player1.wins++;
      player2.losses++;
      player1.gamesPlayed++;
      player2.gamesPlayed++;
    } else {
      player1.losses++;
      player2.wins++;
      player1.gamesPlayed++;
      player2.gamesPlayed++;
    }
  }
  void showGo() {
    player1.brain.drawGenome(15, 400, 370, 260);
    player2.brain.drawGenome(15, 640, 370, 260);
    PImage zero = loadImage("0.png");
    PImage cross = loadImage("1.png");
    PImage nothing = loadImage("-1.png");

    if (spaces[0].team == 0) image(nothing, 21, 56);
    else if (spaces[0].team == -1) image(zero, 21, 56);
    else if (spaces[0].team == 1) image(cross, 21, 56);

    if (spaces[1].team == 0) image(nothing, 131, 56);
    else if (spaces[1].team == -1) image(zero, 131, 56);
    else if (spaces[1].team == 1) image(cross, 131, 56);

    if (spaces[2].team == 0) image(nothing, 241, 56);
    else if (spaces[2].team == -1) image(zero, 241, 56);
    else if (spaces[2].team == 1) image(cross, 241, 56);

    if (spaces[3].team == 0) image(nothing, 21, 165);
    else if (spaces[3].team == -1) image(zero, 21, 165);
    else if (spaces[3].team == 1) image(cross, 21, 165);

    if (spaces[4].team == 0) image(nothing, 131, 165);
    else if (spaces[4].team == -1) image(zero, 131, 165);
    else if (spaces[4].team == 1) image(cross, 131, 165);

    if (spaces[5].team == 0) image(nothing, 241, 165);
    else if (spaces[5].team == -1) image(zero, 241, 165);
    else if (spaces[5].team == 1) image(cross, 241, 165);

    if (spaces[6].team == 0) image(nothing, 21, 275);
    else if (spaces[6].team == -1) image(zero, 21, 275);
    else if (spaces[6].team == 1) image(cross, 21, 275);

    if (spaces[7].team == 0) image(nothing, 131, 275);
    else if (spaces[7].team ==-1) image(zero, 131, 275);
    else if (spaces[7].team == 1) image(cross, 131, 275);

    if (spaces[8].team == 0) image(nothing, 241, 275);
    else if (spaces[8].team == -1) image(zero, 241, 275);
    else if (spaces[8].team == 1) image(cross, 241, 275);
  }
  public Player getPlayer1() {
    return player1;
  }
  public Player getPlayer2() {
    return player2;
  }
}

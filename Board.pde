class Board {
  Space[] spaces;
  Player player1;
  Player player2;
  int currentGo = 0;
  int winner = -1;
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
      if ((spaces[1].team == c && spaces[2].team == c) || (spaces[3].team == c && spaces[6].team == c) || (spaces[4].team == c && spaces[8].team == c)) winner = c;
      break;
    case 1:
      if ((spaces[4].team == c && spaces[7].team == c) || (spaces[0].team == c && spaces[2].team == c));
      break;
    case 2:
      if ((spaces[1].team == c && spaces[0].team == c) || (spaces[4].team == c && spaces[6].team == c) || (spaces[5].team == c && spaces[8].team == c)) winner = c;
      break;
    case 3:
      if ((spaces[0].team == c && spaces[6].team == c) || (spaces[4].team == c && spaces[5].team == c)) winner = c;
      break;
    case 4:
      if ((spaces[0].team == c && spaces[8].team == c) || (spaces[1].team == c && spaces[7].team == c) || (spaces[2].team == c && spaces[6].team == c) || (spaces[5].team == c && spaces[3].team == c)) winner = c;
      break;
    case 5:
      if ((spaces[2].team == c && spaces[8].team == c) || (spaces[3].team == c && spaces[4].team == c)) winner = c;
      break;
    case 6:
      if ((spaces[0].team == c && spaces[3].team == c) || (spaces[4].team == c && spaces[2].team == c) || (spaces[7].team == c && spaces[8].team == c)) winner = c;
      break;
    case 7:
      if ((spaces[4].team == c && spaces[1].team == c) || (spaces[6].team == c && spaces[8].team == c)) winner = c;
      break;
    case 8:
      if ((spaces[6].team == c && spaces[7].team == c) || (spaces[0].team == c && spaces[4].team == c) || (spaces[2].team == c && spaces[5].team == c)) winner = c;
      break;
    }
    return false;
  }

  void haveGo() {
    if(currentGo == 0) player1.steps++;
    else player2.steps++;
    float[] results;
    float max = 0;
    int maxIndex = 0;

    if (currentGo == 0) results = player1.think(spaces);
    else results = player2.think(spaces);

    for (int i = 0; i < results.length; i++) {
      if (results[i] > max) {
        max = results[i];
        maxIndex = i;
      }
    }
    if (currentGo == 0) results = player1.think(spaces);
    else results = player2.think(spaces);

    for (int i = 0; i < results.length; i++) {
      if (results[i] > max) {
        max = results[i];
        maxIndex = i;
      }
    }
    spaces[maxIndex].team = currentGo;
    checkIfWin(currentGo, maxIndex);
    if (currentGo == 0) currentGo = 1;
    else currentGo = 0;
  }
  void winnerFound() {
    if (currentGo == 0) 
    {
      player1.won = true;
      player2.won = false;
    } else {
      player1.won = false;
      player2.won = true;
    }
    player1.calculateFitness();
    player2.calculateFitness();
  }
  void showGo() {
     PImage zero = loadImage("0.png");
     PImage cross = loadImage("1.png");
     PImage nothing = loadImage("-1.png");
     
     if(spaces[0].team == -1) image(nothing, 15, 55);
     else if(spaces[0].team == 0) image(zero, 15, 55);
     else if(spaces[0].team == 1) image(cross, 15, 55);
     
     if(spaces[1].team == -1) image(nothing, 125, 55);
     else if(spaces[1].team == 0) image(zero, 125, 55);
     else if(spaces[1].team == 1) image(cross, 125, 55);
     
     if(spaces[2].team == -1) image(nothing, 235, 55);
     else if(spaces[2].team == 0) image(zero, 235, 55);
     else if(spaces[2].team == 1) image(cross, 235, 55);
     
     if(spaces[3].team == -1) image(nothing, 15, 165);
     else if(spaces[3].team == 0) image(zero, 15, 165);
     else if(spaces[3].team == 1) image(cross, 15, 165);
     
     if(spaces[4].team == -1) image(nothing, 125, 165);
     else if(spaces[4].team == 0) image(zero, 125, 165);
     else if(spaces[4].team == 1) image(cross, 125, 165);
     
     if(spaces[5].team == -1) image(nothing, 235, 165);
     else if(spaces[5].team == 0) image(zero, 235, 165);
     else if(spaces[5].team == 1) image(cross, 235, 165);
     
     if(spaces[6].team == -1) image(nothing, 15, 275);
     else if(spaces[6].team == 0) image(zero, 15, 275);
     else if(spaces[6].team == 1) image(cross, 15, 275);

     if(spaces[7].team == -1) image(nothing, 125, 275);
     else if(spaces[7].team == 0) image(zero, 125, 275);
     else if(spaces[7].team == 1) image(cross, 125, 275);
     
     if(spaces[8].team == -1) image(nothing, 235, 275);
     else if(spaces[8].team == 0) image(zero, 235, 275);
     else if(spaces[8].team == 1) image(cross, 235, 275);
  }
  public Player getPlayer1(){
   return player1;
  }
  public Player getPlayer2(){
   return player2;
  }
  
}

int movesPerSecond = 10; //FPS. Each move is calculated each frame.
int currentGo = 0;
int nextConnectionNo = 1000;
boolean showPopulation = true;
boolean hideAll = false;
Population population;

void setup() {
  size(400, 900);
  frameRate (movesPerSecond);
  population = new Population(300);
}
void draw() {
  if (!hideAll) {
    background(255);
  }
  population.performGo();
  if (showPopulation && !hideAll) {
    fill(0);
    rect(5, 40, 360, 15);
    rect(5, 40, 15, 360);
    rect(350, 40, 15, 360);
    rect(5, 385, 360, 15);

    rect(120, 40, 10, 360);
    rect(230, 40, 10, 360);

    rect(5, 155, 360, 10);
    rect(5, 265, 360, 10);
    population.showGo();
  }
  if (!hideAll) {
    textSize(10);
    textAlign(LEFT);
    text("Moves Per Second : " + movesPerSecond, 0, 10);
    text("Frame Rate : " + frameRate, 0, 20);
    text("Current Player : " + population.currentPlayer, 0, 30);
    text("Currently Playing : " + population.currentPlaying, 200, 10);
    text("Generation : " + population.generation, 200, 20);
    text("winner : " + population.board.winner, 200, 30);
    text("players Played : " + population.playersPlayed.size(), 200, 40);
  }
}
void keyPressed() {
  switch (key) {
  case 'k':
    movesPerSecond--;
    break;
  case 'l':
    movesPerSecond -= 10;
    break;
  case 'i':
    movesPerSecond++;
    break;
  case 'o':
    movesPerSecond += 10;
    break;
  case 'p':
    showPopulation = !showPopulation;
    break;
  case '0':
    movesPerSecond = 1;
    break;
  case '1':
    movesPerSecond = 100;
    break;
  case '2':
    movesPerSecond = 200;
    break;
  case '3':
    movesPerSecond = 300;
    break;
  case '4':
    movesPerSecond = 400;
    break;
  case '5':
    movesPerSecond = 500;
    break;
  case '6':
    movesPerSecond = 600;
    break;
  case '7':
    movesPerSecond = 700;
    break;
  case '8':
    movesPerSecond = 800;
    break;
  case '9':
    movesPerSecond = 10000;
    break;
  case 'y':
    hideAll = !hideAll;
    break;
  }
  if (movesPerSecond < 1) movesPerSecond = 1;
  frameRate (movesPerSecond);
}

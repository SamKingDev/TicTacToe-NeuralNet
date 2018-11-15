int movesPerSecond = 10; //FPS. Each move is calculated each frame.
int currentGo = 0;
int nextConnectionNo = 1000;
Population population;

void setup() {
  size(400, 900);
  frameRate (movesPerSecond);
  population = new Population(100);
}
void draw() {
  background(255);
  fill(0);
  rect(5, 40, 360, 15);
  rect(5, 40, 15, 360);
  rect(350, 40, 15, 360);
  rect(5, 385, 360, 15);

  rect(120, 40, 10, 360);
  rect(230, 40, 10, 360);

  rect(5, 155, 360, 10);
  rect(5, 265, 360, 10);
  population.performGo();

  population.showGo();
  textSize(30);
  text("Moves Per Second : " + movesPerSecond, 170, 15);
}
void keyPressed() {
  switch (key) {
  case 'k':
    movesPerSecond--;
    frameRate (movesPerSecond);
    break;
  case 'l':
    movesPerSecond -= 10;
    frameRate (movesPerSecond);
    break;
  case 'i':
    movesPerSecond++;
    frameRate (movesPerSecond);
    break;
  case 'o':
    movesPerSecond += 10;
    frameRate (movesPerSecond);
    break;
  }
}

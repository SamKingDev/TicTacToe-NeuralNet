int movesPerSecond = 10; //FPS. Each move is calculated each frame.
int currentGo = 0;
int nextConnectionNo = 1000;
boolean showPopulation = true;
Population population;

void setup() {
  size(400, 900);
  frameRate (movesPerSecond);
  population = new Population(750);
}
void draw() {
  line(0, 0, width, height);
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
  if (showPopulation) {
    population.showGo();
  }
  textSize(10);
  textAlign(LEFT);
  text("Moves Per Second : " + movesPerSecond, 0, 10);
  text("Frame Rate : " + frameRate, 0, 20);
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
  case 'p':
    showPopulation = !showPopulation;
    break;
  }
}

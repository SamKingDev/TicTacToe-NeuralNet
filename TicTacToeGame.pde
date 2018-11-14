int movesPerSecond = 500; //FPS. Each move is calculated each frame.
int currentGo = 0;
int nextConnectionNo = 1000;
Population population;

void setup() {
  size(360, 400);
  frameRate (movesPerSecond);
  population = new Population(100);
}
void draw() {
  background(255);
  fill(0);
  rect(0, 40, 360, 15);
  rect(0, 40, 15, 360);
  rect(345, 40, 15, 360);
  rect(0, 385, 360, 15);
  
  rect(115, 40, 10, 360);
  rect(225, 40, 10, 360);
  
  rect(0, 155, 360, 10);
  rect(0, 265, 360, 10);
  population.performGo();
  
  population.showGo();
}

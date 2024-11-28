PVector SCREEN_SIZE = new PVector(900, 600);

void setup() {
  size(900, 600);
  rectMode(CENTER);
  ellipseMode(CENTER);
  init();
}

Player player1, player2;
Ball ball;
void init() {
  ball = new Ball(0);
  player1 = new Player(true);
  player2 = new Player(false);
}

void draw() {
  background(255);
  ball.draw();
  player1.draw();
  player2.draw();
  update();
}

void update() {
  ball.update();
  player1.update();
  player2.update();
}

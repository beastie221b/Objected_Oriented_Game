PVector SCREEN_SIZE = new PVector(900, 600);
PVector NET_SIZE = new PVector(10, 300);
PVector NET_POSITION = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y - NET_SIZE.y);

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
  
  circle(SCREEN_SIZE.x / 2, NET_SIZE.y, NET_SIZE.x);
  rectMode(CORNER);
  rect(NET_POSITION.x - NET_SIZE.x / 2, NET_POSITION.y, NET_SIZE.x, NET_SIZE.y);
  update();
}

void update() {
  ball.update();
  player1.update();
  player2.update();
}

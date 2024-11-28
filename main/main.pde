void setup() {
  size(900, 600);
  init();
}


Ball ball;
void init() {
  ball = new Ball(0);
}

void draw() {
  background(255);
  ball.draw();
  update();
}

void update() {
  ball.update();
}

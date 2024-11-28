PVector SCREEN_SIZE = new PVector(900, 600);
int[] key_pressed = {0, 0};

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
  player1.move(key_pressed[0]);
  player2.move(key_pressed[1]);
  
  ball.update();
  player1.update();
  player2.update();
}

void keyPressed() {
  // -1 for moving left, +1 for moving right
  if (key == 'a' || key == 'A') {
    if (key_pressed[0] > -1) key_pressed[0] --;
  }
  
  if (key == 'd' || key == 'D') {
    if (key_pressed[0] < 1) key_pressed[0] ++;
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (key_pressed[1] > -1) key_pressed[1] --;
    }
    
    if (keyCode == RIGHT) {
      if (key_pressed[1] < 1) key_pressed[1] ++;
    }
  }
  
  println(key);
}

void keyReleased() {
  if (key == 'a' || key == 'A') {
    key_pressed[0] ++;
  }
  
  if (key == 'd' || key == 'D') {
    key_pressed[0] --;
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      key_pressed[1]++;
    }
    
    if (keyCode == RIGHT) {
      key_pressed[1]--;
    }
  }
}

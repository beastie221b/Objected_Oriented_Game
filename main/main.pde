PVector SCREEN_SIZE = new PVector(900, 600);
PVector NET_SIZE = new PVector(10, 300);
PVector NET_POSITION = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y - NET_SIZE.y);
boolean game_over = false;
boolean player1_won = false;

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
  game_over = false;
  player1_won = false;
}

void draw() {
  background(255);
  
  if (!game_over) {
    ball.draw();
    player1.draw();
    player2.draw();
    
    circle(SCREEN_SIZE.x / 2, NET_SIZE.y, NET_SIZE.x);
    rectMode(CORNER);
    rect(NET_POSITION.x - NET_SIZE.x / 2, NET_POSITION.y, NET_SIZE.x, NET_SIZE.y);
    textSize(20);
    text(player1.score, 50, 50);
    text(player2.score, SCREEN_SIZE.x - 50, 50);
    
    update();
  } else {
    rectMode(CORNER);
    fill(255);
    rect(0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
    
    if (player1_won) {
      textSize(30);
      fill(0);
      text("PLAYER 1 WON", SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 2);
      text("Press anykey to restart", SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 2 + 50);
    } else {
      textSize(30);
      fill(0);
      text("PLAYER 2 WON", SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 2);
      text("Press Anykey to restart", SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 2 + 50);
    }
    
    if (mousePressed || keyPressed) {
      init();
    }
  }
}

void update() {
  ball.update();
  player1.update();
  player2.update();
}

void win(boolean player1) {
  game_over = true;
  player1_won = player1;
}

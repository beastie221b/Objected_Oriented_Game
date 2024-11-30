PVector SCREEN_SIZE = new PVector(900, 600);
PVector NET_SIZE = new PVector(10, 250);
PVector NET_POSITION = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y - NET_SIZE.y);
int game_stage = 0; // 0 for start page, 1 for helper page, 2 for game page, 3 for game over page
boolean player1_won = false;
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
  game_stage = 0;
  player1_won = false;
}

void draw() {
  background(255);
  
  if (game_stage == 0) {
    rectMode(CORNER);
    fill(255);
    rect(0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
    textSize(30);
    fill(0);
    text("Start", SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 2);
    text("1P", SCREEN_SIZE.x / 2 - 50, SCREEN_SIZE.y / 2 + 50);
    text("2P", SCREEN_SIZE.x / 2 + 50, SCREEN_SIZE.y / 2 + 50);
    update();
  } else if (game_stage == 2) {
    ball.draw();
    player1.draw();
    player2.draw();
    
    circle(NET_POSITION.x, NET_POSITION.y, NET_SIZE.x);
    rectMode(CORNER);
    rect(NET_POSITION.x - NET_SIZE.x / 2, NET_POSITION.y, NET_SIZE.x, NET_SIZE.y);
    textSize(20);
    text(player1.score, 50, 50);
    text(player2.score, SCREEN_SIZE.x - 50, 50);
    
    update();
  } else if (game_stage == 3) {
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
  if (game_stage == 0) {
    println("here");
    if (mousePressed) {
      game_stage = 2;
    }
  } else if (game_stage == 2) {
    player1.move(key_pressed[0]);
    player2.move(key_pressed[1]);
    
    ball.update();
    player1.update();
    player2.update();
    
    if (player1.position.x <= player1.size.x / 2) player1.position.x = player1.size.x / 2;
    else if (player1.position.x >= NET_POSITION.x - NET_SIZE.x / 2 - player1.size.x / 2) player1.position.x = NET_POSITION.x - NET_SIZE.x / 2 - player1.size.x / 2;
    if (player2.position.x >= SCREEN_SIZE.x - player2.size.x / 2) player2.position.x = SCREEN_SIZE.x - player2.size.x / 2;
    else if (player2.position.x <= NET_POSITION.x + NET_SIZE.x / 2 + player2.size.x / 2) player2.position.x = NET_POSITION.x + NET_SIZE.x / 2 + player2.size.x / 2;
  }
}

void win(boolean player1) {
  game_stage = 3;
  player1_won = player1;
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

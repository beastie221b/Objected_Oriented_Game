PVector SCREEN_SIZE = new PVector(900, 600);
PVector NET_SIZE = new PVector(10, 250);
PVector NET_POSITION = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y - NET_SIZE.y);
PImage img;
int game_stage = 0; // 0 for start page, 1 for helper page, 2 for game page, 3 for game over page
boolean player1_won = false;
boolean one_player = false;
int[] key_pressed = {0, 0};
PVector[] button_loc = {new PVector(180, 375), new PVector(500, 375)};
PVector button_size = new PVector(200, 50);

void setup() {
  size(900, 600);
  rectMode(CENTER);
  ellipseMode(CENTER);
  stroke(#1fffc4);
  init();
}

Player player1, player2;
AI_Player computer;
Ball ball;
void init() {
  ball = new Ball(0);
  player1 = new Player(true);
  player2 = new Player(false);
  game_stage = 0;
  computer = new AI_Player();
  player1_won = false;
  one_player = true;
}

void draw() {
  background(255);
  
  if (game_stage == 0) {
    img = loadImage("Image/Start_Page.png");
    image(img, 0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
    update();
  } else if (game_stage == 2) {
    img.resize(900, 600);
    background(img);
    ball.draw();
    player1.draw();
    player2.draw();
    
    fill(#40f4d2);
    circle(NET_POSITION.x, NET_POSITION.y, NET_SIZE.x);
    rectMode(CORNER);
    rect(NET_POSITION.x - NET_SIZE.x / 2, NET_POSITION.y, NET_SIZE.x, NET_SIZE.y);
    fill(255);
    textSize(50);
    text(str(player1.score) + "                         VS                          " + str(player2.score), 150, 50);
    textSize(30);
    text("WASD                                                                                  ARROWS", 130, 80);
    
    update();
  } else if (game_stage == 3) {
    rectMode(CORNER);
    fill(255);
    rect(0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
    if (player1_won) {
      img = loadImage("Image/Player1_Won_Page.png");
      image(img, 0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
    } else {
      if (one_player) {
        img = loadImage("Image/Game_Over_Page.png");
        image(img, 0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
      } else {
        img = loadImage("Image/Player2_Won_Page.png");
        image(img, 0, 0, SCREEN_SIZE.x, SCREEN_SIZE.y);
      }
    }
    
    if (mousePressed || keyPressed) {
      game_stage = 0;
      init();
      delay(100);
    }
  }
}

void update() {
  if (game_stage == 0 && mousePressed) {
    if (mouseX > button_loc[0].x && mouseX < button_loc[0].x + button_size.x && mouseY > button_loc[0].y && mouseY < button_loc[0].y + button_size.y) {
      game_stage = 2;
      one_player = true;
    } else if(mouseX > button_loc[1].x && mouseX < button_loc[1].x + button_size.x && mouseY > button_loc[1].y - button_size.y && mouseY < button_loc[1].y + button_size.y) {
      game_stage = 2;
      one_player = false;
    }
    img = loadImage("Image/Game_Stage_Background.png");
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
    if (one_player) {
      computer.update();
    }
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
  
  if (!one_player) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        if (key_pressed[1] > -1) key_pressed[1] --;
      }
      
      if (keyCode == RIGHT) {
        if (key_pressed[1] < 1) key_pressed[1] ++;
      }
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
  
  if (!one_player) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        key_pressed[1]++;
      }
      
      if (keyCode == RIGHT) {
        key_pressed[1]--;
      }
    }
  }
}

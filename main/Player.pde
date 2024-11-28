float MAX_VELOCITY = 5;
int WIN_SCORE = 1;

class Player {
  PVector position, velocity, acceleration, size;
  boolean cur_player1;
  int score;
  
  Player(boolean player1) {
    score = 0;
    cur_player1 = player1;
    if (player1) {
      position = new PVector(SCREEN_SIZE.x / 4, 500);
    } else {
      position = new PVector(SCREEN_SIZE.x * 3 / 4, 500);
    }
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = new PVector(100, 50);
  }
  
  void draw() {
    fill(0);
    arc(position.x, position.y, size.x, size.y, PI, 2 * PI, CHORD);
  }
  
  void update() {
    velocity.add(acceleration);
    if (velocity.x > MAX_VELOCITY) {
      velocity.x = MAX_VELOCITY;
    }
    
    position.add(velocity);
  }
  
  void score() {
    score ++;
    if (score >= WIN_SCORE) {
      win(cur_player1);
    }
  }
}

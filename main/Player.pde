float MAX_VELOCITY = 10;

class Player {
  PVector position, velocity, acceleration, size;
  boolean player1;
  int move_rate;
  
  Player(boolean is_player1) {
    if (is_player1) {
      position = new PVector(SCREEN_SIZE.x / 4, 500);
    } else {
      position = new PVector(SCREEN_SIZE.x * 3 / 4, 500);
    }
    velocity = new PVector(0, 0);
    acceleration = new PVector(1, 0);
    size = new PVector(100, 50);
    move_rate = 0;
  }
  
  void draw() {
    fill(0);
    arc(position.x, position.y, size.x, size.y, PI, 2 * PI, CHORD);
  }
  
  void update() {
    if (abs(velocity.x + move_rate * acceleration.x) < MAX_VELOCITY) {
      velocity.x += move_rate * acceleration.x;
    } 
    if (move_rate == 0 && velocity.x != 0) {
      velocity.x -= (velocity.x - 0) / abs(velocity.x) * acceleration.x; 
    }
    
    position.add(velocity);
  }
  
  void move(int rate) {
    move_rate = rate;
  }
}

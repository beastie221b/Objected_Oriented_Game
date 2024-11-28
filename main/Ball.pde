float size = 20;
int net_height = 200;

class Ball {
  PVector position, velocity, acceleration;
  
  Ball(int side) {
    // value of side: 0 - start in the middle, 1 - start on the left, 2 - start on the right
    if(side == 0) {
      position = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 3);
      velocity = new PVector(random(-1, 1) * random(7, 10), 0);
    } else if (side == 1) {
      position = new PVector(SCREEN_SIZE.x / 4, SCREEN_SIZE.y / 3);
      velocity = new PVector(0, 0);
    } else {
      position = new PVector(SCREEN_SIZE.x * 3 / 4, SCREEN_SIZE.y / 3);
      velocity = new PVector(0, 0);
    }
    acceleration = new PVector(0, 0.08);
  }
  
  void draw() {
    fill(0);
    circle(position.x, position.y, size);
  }
  
  void check_collision() {
    // Hit side of screen
    if (position.x - size / 2 <= 0 || position.x + size / 2 >= SCREEN_SIZE.x) {
      velocity.x *= -1;
    }
    
    // Hit net on the side
    if (position.y > NET_SIZE.y &&
      ((velocity.x > 0 && position.x + size / 2 >= NET_POSITION.x - NET_SIZE.x / 2 && position.x + size / 2 <= NET_POSITION.x + NET_SIZE.x / 2) ||
      (velocity.x < 0 && position.x - size / 2 <= NET_POSITION.x + NET_SIZE.x / 2 && position.x - size / 2 >= NET_POSITION.x - NET_SIZE.x / 2))) {
        velocity.x *= -1;
    }
    
    // Hit net on the tip
  }
  
  void check_win() {
    if (position.y < SCREEN_SIZE.y) {
      return;
    }
    
    if (position.x < NET_POSITION.x) {
      // Player 2 wins one point
      player2.score();
      ball = new Ball(2);
    } else {
      // Player 1 wins one point
      player1.score();
      ball = new Ball(1);
    }
  }
  
  void update() {
    check_win();
    check_collision();
    
    velocity.add(acceleration);
    position.add(velocity);
  }
}

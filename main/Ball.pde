float BALL_SIZE = 20;
float MAX_BALL_VELOCITY = 8;
float WALL_BOUNCE_RATIO = 0.5;
float NET_BOUNCE_RATIO = 1.2;

class Ball {
  PVector position, velocity, acceleration;
  
  Ball() {
    position = new PVector(0, 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
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
  
  void copy(Ball other_ball) {
    position = other_ball.position.copy();
    velocity = other_ball.velocity.copy();
    acceleration = other_ball.acceleration.copy();
  }
  
  void draw() {
    fill(#40f4d2);
    circle(position.x, position.y, BALL_SIZE);
  }
  
  void cal_velocity_after_collision(float angle, float bounce_ratio) {
    velocity.x = cos(angle) * velocity.mag();
    velocity.y = -sin(angle) * velocity.mag();
    velocity.mult(bounce_ratio);
  }
  
  void check_collision() {
    // Hit side of screen
    if (position.x - BALL_SIZE / 2 <= 0) {
      position.x = BALL_SIZE / 2;
      velocity.x *= -1 * WALL_BOUNCE_RATIO;
    } else if(position.x + BALL_SIZE / 2 >= SCREEN_SIZE.x) {
      position.x = SCREEN_SIZE.x - BALL_SIZE / 2;
      velocity.x *= -1 * WALL_BOUNCE_RATIO;
    }
    
    // Hit net on the side
    if (position.y > NET_POSITION.y &&
      ((velocity.x > 0 && position.x + BALL_SIZE / 2 >= NET_POSITION.x - NET_SIZE.x / 2 && position.x + BALL_SIZE / 2 <= NET_POSITION.x + NET_SIZE.x / 2) ||
      (velocity.x < 0 && position.x - BALL_SIZE / 2 <= NET_POSITION.x + NET_SIZE.x / 2 && position.x - BALL_SIZE / 2 >= NET_POSITION.x - NET_SIZE.x / 2))) {
        velocity.x *= -1 * NET_BOUNCE_RATIO;
    }
    
    // Hit net on the tip
    if (PVector.dist(position, NET_POSITION) < BALL_SIZE / 2 + NET_SIZE.x / 2 && position.y < NET_POSITION.y) {
      PVector temp_position = new PVector();
      temp_position = position.copy();
      float angle = PVector.angleBetween(new PVector(1, 0), temp_position.sub(NET_POSITION));
      cal_velocity_after_collision(angle, NET_BOUNCE_RATIO);
    }
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
    velocity.add(acceleration);
    if(abs(velocity.x) > MAX_BALL_VELOCITY) {
      velocity.x = (velocity.x - 0) / abs(velocity.x) * MAX_BALL_VELOCITY;
    }
    
    if(abs(velocity.y) > MAX_BALL_VELOCITY) {
      velocity.y = (velocity.y - 0) / abs(velocity.y) * MAX_BALL_VELOCITY;
    }
    
    check_collision();
    position.add(velocity);
  }
}

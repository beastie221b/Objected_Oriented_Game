float size = 20;
int net_height = 200;

class Ball {
  PVector position, velocity, acceleration;
  
  Ball(int side) {
    // value of side: 0 - start in the middle, 1 - start on the left, 2 - start on the right
    if(side == 0) {
      position = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 3);
      velocity = new PVector(random(-1, 1) * random(20, 30), 0);
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
  
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
  }
}

PVector SCREEN_SIZE = new PVector(900, 600);

class Ball {
  PVector position, velocity, acceleration;
  
  Ball(boolean game_start, boolean player1_side) {
    if(game_start) {
      position = new PVector(SCREEN_SIZE.x / 2, SCREEN_SIZE.y / 3);
      velocity = new PVector(random(-1, 1) * random(20, 30), 0);
    } else if (player1_side) {
      position = new PVector(SCREEN_SIZE.x / 4, SCREEN_SIZE.y / 3);
      velocity = new PVector(0, 0);
    } else {
      position = new PVector(SCREEN_SIZE.x * 3 / 4, SCREEN_SIZE.y / 3);
      velocity = new PVector(0, 0);
    }
    acceleration = new PVector(0, 10);
  }
}

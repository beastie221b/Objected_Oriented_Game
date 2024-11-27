class Player {
  PVector position, velocity, acceleration;
  
  Player(PVector pos) {
    position = new PVector(pos.x, pos.y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(1, 0);
  }
}

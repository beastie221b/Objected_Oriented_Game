float MAX_VELOCITY = 10;
float BOUNCE_RATIO = 1.3;
int WIN_SCORE = 7;

class Player {
  PVector position, velocity, acceleration, size;
  boolean cur_player1;
  int score;
  int move_rate;
  
  Player(boolean player1) {
    score = 0;
    cur_player1 = player1;
    float x;
    if (player1) {
      x = SCREEN_SIZE.x / 4;
    } else {
      x = SCREEN_SIZE.x * 3 / 4;
    }
    position = new PVector(x, 550);
    velocity = new PVector(0, 0);
    acceleration = new PVector(1.5, 0);
    size = new PVector(70, 70);
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
    
    bounce_ball();
    position.add(velocity);
  }
  
  void bounce_ball() {
    if (PVector.dist(position, ball.position) < BALL_SIZE / 2 + size.x / 2 && ball.position.y < position.y) {
      PVector temp_position = new PVector();
      temp_position = ball.position.copy();
      float angle = PVector.angleBetween(new PVector(1, 0), temp_position.sub(position));
      ball.cal_velocity_after_collision(angle, BOUNCE_RATIO);
    }
  }
  
  void score() {
    score ++;
    if (score >= WIN_SCORE) {
      win(cur_player1);
    }
  }
  void move(int rate) {
    move_rate = rate;
  }
}

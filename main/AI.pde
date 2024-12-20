class AI_Player{
  boolean forecasted; // Next locatioin forcasted
  float forecast_land_x; // Exact location of where the ball will drop
  
  AI_Player() {
    forecasted = false;
    forecast_land_x = 0;
  }
  
  void forecast() {
    // forecast where the ball will land
    Ball forecast = new Ball();
    forecast.copy(ball);
    while (forecast.position.y < player2.position.y - player2.size.y / 2) {
      forecast.update();
    }
    forecast_land_x = forecast.position.x;
    forecasted = true;
  }
  
  void update() {
    // forecast when ball is on my side and reaches highest points
    if ((ball.position.x > NET_POSITION.x && ball.velocity.y < 0 && ball.velocity.y + ball.acceleration.y > 0) || 
      (ball.position.x <= NET_POSITION.x && ball.position.x + ball.velocity.x > NET_POSITION.x)) {
      forecasted = false;
    } else if (ball.position.x <= NET_POSITION.x) {
      // Move the object to the middle of the court
      forecast_land_x = (SCREEN_SIZE.x - NET_POSITION.x) / 2 + NET_POSITION.x;
    }
    
    if (forecasted == false) {
      forecast();
    }
    
    // Move slightly to the left if the ball lands in the left side of the court, and a bit to the right if the ball lands in the right side of the court
    float position_ratio = map(forecast_land_x, NET_POSITION.x, SCREEN_SIZE.x, -player2.size.x / 3, player2.size.x / 3);
    if (player2.position.x - position_ratio - 15 > forecast_land_x) {
      key_pressed[1] = -1;
    } else if(player2.position.x - position_ratio + 15 < forecast_land_x) {
      key_pressed[1] = 1;
    } else {
      key_pressed[1] = 0;
    }
  }
}

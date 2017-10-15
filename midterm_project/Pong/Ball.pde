// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.
class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 4;
  int SIZE = 16;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // *REMOVED* The colour of the ball not needed
  //color ballColor = color(255);
  
  // *ADDED* an image to display instead of the ball
  PImage image;
   
  // *ADDED* New variables for tracking score and detecting if the ball is off screen
  int ballPosition;
  int leftScore = 0;
  int rightScore = 0;
  int leftHealth = 7;
  int rightHealth = 7;
  
  
  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;  
  }

  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    // *CHANGED* add a random number between -5 and 5 on the Y-axis to mimick a fly movement
    y += vy + random(-5,5);

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }
  
  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity
  
  void reset() {
    x = width/2;
    y = height/2;
   // *ADDED* when the ball is reset it restores its default velocity 
    vx = SPEED;
    vy = SPEED;
  }

  
  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")

  
  // *ADDED* check if the ball is on screen if not, on which side it left the screen.
  // Update score accordingly. If the ball is off the left side, the function returns value
  // of 1 and adds 1 to the right player, if the ball is off the right side, value returned is
  // 2 and the left players score gets +1. If neither is the case, it returns the default value of 0.
  int offScreen() {
      if(x + SIZE/2 < 0) {
        ballPosition = 1;
        rightScore = rightScore + 1;
      }
      else if(x - SIZE/2 > width) {
        ballPosition = 2;
        leftScore = leftScore + 1;
      }
      else {
        ballPosition = 0;
      }
     return ballPosition;
  }


  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    
    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;
    }
  }
  // *ADDED* collide(AntiPaddle antiPaddle)
  //
  // Checks whether this ball is colliding with the anti-paddle passed as an argument
  // If it is, it makes the ball bounce away from the anti-paddle by reversing its
  // y velocity 
    void collide(AntiPaddle antiPaddle) {
    // Calculate possible overlaps with the anti-paddle side by side
    boolean insideLeft = (x + SIZE/2 > antiPaddle.x - antiPaddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < antiPaddle.x + antiPaddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > antiPaddle.y - antiPaddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < antiPaddle.y + antiPaddle.HEIGHT/2);
    
    // Check if the ball overlaps with the anti-paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the top
      if (vy < 0) {
        // Reset its position to align with the right side of the anti-paddle
          // *ADDED* a condition that doesn't allow health go below 0. Once it reaches 0 it stays there
        y = antiPaddle.y + antiPaddle.HEIGHT/2 + SIZE/2;
          if(leftHealth <= 0) {
            leftHealth = 0;
          }
          else {
            leftHealth = leftHealth - 1;
          }
        } 
        else if (vy > 0) {
        // Reset its position to align with the left side of the anti-paddle
        y = antiPaddle.y - antiPaddle.HEIGHT/2 - SIZE/2;
          if(rightHealth <= 0) {
            rightHealth = 0;
          }
          else {
            rightHealth = rightHealth - 1;
          }
      }
      // And make it bounce
      vy = -vy;
      vx = -vx;
    }
  }
  
    // *ADDED* Check if the ball overlaps with the obstacle  
    void collide(Obstacle obstacle) {
    // *CHANGED* Calculate possible overlaps with the obstacle side by side
    boolean insideLeft = (x + SIZE/2 > obstacle.x - obstacle.obstacleWidth/2);
    boolean insideRight = (x - SIZE/2 < obstacle.x + obstacle.obstacleWidth/2);
    boolean insideTop = (y + SIZE/2 > obstacle.y - obstacle.obstacleHeight/2);
    boolean insideBottom = (y - SIZE/2 < obstacle.y + obstacle.obstacleHeight/2);
    
    // *ADDED* Check if the ball overlaps with the obstacle
    // and make it change speed randomly and direction.
    if (insideLeft && insideRight && insideTop && insideBottom) {
      vx = -vx - floor(random(-10,10));
      vy = -vy;
    }
  }

  // *ADDED* This function will reset the scores when the new game starts
  void resetScores() {
    leftHealth = 7;
    rightHealth = 7;
    leftScore = 0;
    rightScore = 0;
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
  // *REMOVED* ball is not a rect anymore  
    //noStroke();
    //fill(ballColor);
    //rectMode(CENTER);

    // Draw the ball
    //rect(x, y, SIZE, SIZE);
    
  // *ADDED* The ball is displayed as an image of a fly.
  // check which direction the "ball" is moving, flipping the fly accordingly by
  // substituting the image
        if(vx > 0) {
      image = loadImage("fly_right.png");
    }
    else if (vx < 0) {
      image = loadImage("fly_left.png");
    }  
    imageMode(CENTER);
    image(image,x,y);
  }
}
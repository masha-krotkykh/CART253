// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;
// *ADDED* variable for "anti-paddles" - top and bottom paddles that should avoid collisions
AntiPaddle topAntiPaddle;
AntiPaddle bottomAntiPaddle;

Obstacle obstacle;

// *ADDED* an image for the background
PImage backgroundImage;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 30;
// *ADDED* The distance from the edge of the window an anti-paddle should be
//int ANTI_INSET = 30;

// The background colour during play (black)
color backgroundColor = color(255);


// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 640);

  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, "chameleon_blue_left.png", '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, "chameleon_red_right.png", '0', 'p');
  
  // *ADDED* top and bottom "anti-paddles" that are controlled with same keys as corresponding paddles (right-bottom, left-top)
  topAntiPaddle = new AntiPaddle(width/2, PADDLE_INSET, "cake_blue_top.png", '1', 'q');
  bottomAntiPaddle = new AntiPaddle(width/2, height - PADDLE_INSET, "cake_red_bottom.png", '0', 'p');

  // *ADDED* an obstacle moving up and down the middle of the screen
  obstacle = new Obstacle(width/2, height/3);

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
  
  // *ADDED* load background image
  backgroundImage = loadImage("background.jpg");
}
// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  println(ball.rightLives);
  // Fill the background each frame so we have animation
  background(backgroundImage);
  
  // *ADDED* display score
  fill(0,0,255,50);
  textSize(50);
  textAlign(CENTER);
  text(ball.leftScore, leftPaddle.x + leftPaddle.WIDTH + PADDLE_INSET, leftPaddle.y);
  fill(255,0,0,50);
  text(ball.rightScore, rightPaddle.x - rightPaddle.WIDTH - PADDLE_INSET, rightPaddle.y);
  
  
  int livesSize = 20;
  int leftLivesX = topAntiPaddle.x + topAntiPaddle.WIDTH / 2 - livesSize;
  rectMode(CENTER);
  fill(0,0,255);
  noStroke();
  for (int i = ball.leftLives; i > 0; i--) {
    rect(leftLivesX, 80, livesSize, livesSize / 2);
    leftLivesX = leftLivesX - 10;
  }
  
  int rightLivesX = bottomAntiPaddle.x - bottomAntiPaddle.WIDTH / 2 + livesSize;
  fill(255,0,0);
  for (int i = ball.rightLives; i > 0; i--) {
    rect(rightLivesX, height - 80, livesSize, livesSize / 2);
    rightLivesX = rightLivesX + 10;
  }
  
  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  ball.update();
  
  // *ADDED* update for anti-paddles
  topAntiPaddle.update();
  bottomAntiPaddle.update();
  
  // *ADDED* update for obstacle
  obstacle.update();

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);
  
  // *ADDED* detect collision with anti-paddles
  ball.collide(topAntiPaddle);
  ball.collide(bottomAntiPaddle);
  
  // *ADDED* call offScreen() function to return the ballPosition value to be able to reset the ball
  ball.offScreen();
  
  // *ADDED* check for collisions withth obstacle 
  ball.collide(obstacle);

  // Check if the ball has gone off the screen on either side
  if (ball.ballPosition == 2 || ball.ballPosition == 1) {
    // If it has, reset the ball
    ball.reset();
    
  }

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
  
  //*ADDED* display for anti-paddles
  topAntiPaddle.display();
  bottomAntiPaddle.display();
  
  // *ADDED* display for obstacle
  obstacle.display();
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
  //*ADDED* call both anti-paddles' keyPressed method
  topAntiPaddle.keyPressed();
  bottomAntiPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
  // *ADDED* Call both anti-paddles' keyReleased methods
  topAntiPaddle.keyReleased();
  bottomAntiPaddle.keyReleased();
}
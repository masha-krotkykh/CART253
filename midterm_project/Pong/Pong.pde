
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
// *ADDED* variable for obstacle that will cause the ball change it's speed randomly and direction upon collision
Obstacle obstacle;

// *ADDED* an image for the background
PImage backgroundImage;
PFont myFont;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 30;
// *ADDED* The distance from the edge of the window an anti-paddle should be
int ANTI_INSET = 20;

// The background colour during play (black)
//color backgroundColor = color(255);

int gameScreen = 0;

// *ADDED* variables to calculate the overall player's score at the end of the game
int leftTotalScore;
int rightTotalScore;


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
  // *CHANGED* check if the paddle is controlled by mouse
  // if FALSE contrl the paddle with Up and Down arrows (Paddle class)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, "chameleon_blue_left.png", false);
  // if true, position the paddle at mouseY (Paddle class)
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, "chameleon_red_right.png", true);
  
  // *ADDED* top and bottom "anti-paddles" that are controlled with same keys as corresponding paddles (right-bottom, left-top)
  topAntiPaddle = new AntiPaddle(width/2, ANTI_INSET, "cake_blue_top.png", false);
  bottomAntiPaddle = new AntiPaddle(width/2, height - ANTI_INSET, "cake_red_bottom.png", true);

  // *ADDED* an obstacle moving up and down the middle of the screen
  obstacle = new Obstacle(width/2, height/3);

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
  

}
// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // *ADDED* display the current screen according to the game stage
  // startScreen displays before the game begins and until the mouse is clicked
  if(gameScreen == 0) {
    startScreen(); 
  }

  // endScreen displays when the game ends until the mouse is clicked
  else if(gameScreen == 2) {
    endScreen();
  }
  
  // gameScreen is the stage where the game executes
  else {
    gameScreen();
  }
}

// *ADDED* functions to display an appropriate screen
// startScreen before the game begins
void startScreen() {
  backgroundImage = loadImage("start_screen.jpg");
  background(backgroundImage);
}

// endScreen when the game ends. Calculate and display final scores.
// Scores are calculated as follows: game score + saved cakes * 2
// Depending on who won end screen displays their portrait
void endScreen() {
  leftTotalScore = ball.leftScore + ball.leftHealth * 2;
  rightTotalScore = ball.rightScore + ball.rightHealth * 2;
  fill(255);
  textAlign(CENTER);
  
  if(leftTotalScore > rightTotalScore) {
    backgroundImage = loadImage("winner_left.jpg");
  }
  else if(leftTotalScore < rightTotalScore) {
    backgroundImage = loadImage("winner_right.jpg");
  }
  // *ADDED* an end screen for a draw scenario
  else if(leftTotalScore == rightTotalScore){
    background(0);
    text("EVERYONE IS A LOSER", width/2, height/2);
  }
  
  // *ADDED* display health level and score on separate lines
  int textXOffset = 70;
  int textYOffset = 62;
  background(backgroundImage);
  text("WINNER!", width/2, textYOffset * 3);
  text(ball.leftScore, textXOffset, textYOffset); 
  text((ball.leftHealth * 2), textXOffset, textYOffset * 2);
  text(ball.rightScore, width - textXOffset, textYOffset); 
  text((ball.rightHealth * 2), width - textXOffset, textYOffset * 2);
}

// *CHANGED* all the game code is now inside gameScreen() function so itr only gets called when the mouse is clicked from
// the startScreen or the endScreen
void gameScreen() {
  
  // *ADDED* load background image
  backgroundImage = loadImage("background.jpg");
  // Fill the background each frame so we have animation
  background(backgroundImage);
  // *ADDED* display score
  fill(0,0,255,50);
  textSize(50);
  myFont = loadFont("Blackflower-48.vlw");
  textFont(myFont);
  textAlign(CENTER);
  text(ball.leftScore, leftPaddle.x + leftPaddle.WIDTH + PADDLE_INSET, leftPaddle.y);
  fill(255,0,0,50);
  text(ball.rightScore, rightPaddle.x - rightPaddle.WIDTH - PADDLE_INSET, rightPaddle.y);
  
  
  int healthSize = 20;
  int leftHealthX = topAntiPaddle.x + topAntiPaddle.WIDTH / 2 - healthSize;
  rectMode(CENTER);
  fill(0,0,255);
  noStroke();
  for (int i = ball.leftHealth; i > 0; i--) {
    rect(leftHealthX, 80, healthSize, healthSize / 2);
    leftHealthX = leftHealthX - 10;
  }
  
  int rightHealthX = bottomAntiPaddle.x - bottomAntiPaddle.WIDTH / 2 + healthSize;
  fill(255,0,0);
  for (int i = ball.rightHealth; i > 0; i--) {
    rect(rightHealthX, height - 80, healthSize, healthSize / 2);
    rightHealthX = rightHealthX + 10;
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
  
  
    if (ball.leftScore >= 10 || ball.rightScore >= 10)
  {
    gameScreen = 2;
  }
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

// *ADDED* when mouse is pressed the new game starts.
void mousePressed() {
  if(gameScreen == 0 || gameScreen == 2)  {
    gameScreen = 1;
    ball.resetScores();
  }
}
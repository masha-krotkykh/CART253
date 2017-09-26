// 
color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
int r = 255;
int g = 255;
int b = 255;
color ballColor = color(r,g,b);

void setup() {
  size(640, 480);
  
  setupPaddle();
  setupBall();
}

//Sets up padle at the bottom center of the window
void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

//Sets up the starting position of the ball in the center of the window
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

//Redraws the background to clean the window from previous instances of ball, paddle and static
//Redraws new instance of the ball, paddle and static by calling their functions
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

//Function to draw static noise. The positon of static is generated randomly within the size 
//of the window of a random size with sides between 1 and 3(staticSizeMin and staticSizeMax).
//This happens while the condition of i instances being smaller than 1000 (numStatic), ading 
//one additional instance every time a loop completes.
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}

//Calls new instance of paddle at the new position which is starting position + velocity
//(paddleVX) which is 0 by default. The movement is constrained within the width of the window.
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

//Calls the new instance of the ball at the new position which is its starting poition + velocity
//(ballVX) on X-axis and (ballVY) on Y-axis. By default both are equal 5 (ballSpeed). Calls functions handleBallHitPaddle(),
//handleBallHitWall() and handleBallOffBottom().
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

//Draws paddle at the position defined earlier (bottom center of the window).
void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

//Draws white "ball" in the center of the window of the size defined earlier (16x16).
void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

//Function that deals with the scenario where the ball hits the paddle. If condition of ballOverlapsePaddle is true,
//the ball changes its direction on Y-axis and its starting Y-position will be right above the paddle. 
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
//*CHANGED* Each time the ball hits the paddle it moves 1 increment faster.    
    ballVY = -ballVY - 1;
  }
}

//Returns a true or false value for ballOverlapsePaddle checking if the condition of the ball hitting the paddle is met. The condition is false by default
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

//Function that deals with the sceario where the ball misses the paddle and falls off the window.
//If the condition is met the new ball will appear at its starting position - cener of the window.
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}

//Returns a true or false value for ballOffBottom checking if the bottom of the ball reached the bottom of the window.
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

//Function that deals with the scenario where the ball hits the wall. If the ball side reaches the "wall" (left or right side of the window),
//it changes its direction on X-axis. If it reaches the top of the window, it changes its direction on Y-axis.
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}

//Events. If the arrow key is pressed the paddle will change its position with the velocity of 10 (paddleSpeed). It will "move" to the left
//if the left arrow key is pressed and to the right, if the right arrow key is pressed.
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

//Stops the paddle from moving when the key is released.
void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}
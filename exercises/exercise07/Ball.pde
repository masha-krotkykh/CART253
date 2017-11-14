// Ball class to describe a ball object
// a ball that moves vertically up and down and creates sound when bounces off top or bottom of the window

class Ball {
  //Declaring the main parameters. Like position variables
  float x;
  float y;
  //Y-velocity because the balls will only move up and down
  float vy;
  //Size and colour variables
  float size;
  color fillColor;
  // a variable to be able to increase a ball's velocity on click
  float speedUp = 0.5;
  String tone;
  char stopKey;

  // Create a Ball with the provided values
  Ball (float tempX, float tempY, int tempVY, float tempSize, color tempFillColor, String tempTone, char tempStopKey) {
    x = tempX;
    y = tempY;
    vy = tempVY;
    size = tempSize;
    fillColor = tempFillColor;
    tone = tempTone;   
    stopKey = tempStopKey;
  }
  
  // Update Ball by velocity
  void update() {
    y += vy;
    
    handleBounce();
  }
 
  // Checks if ball hits the top or the bottom of the window and returns true or false
  boolean bounced() {
    if (y - size/2 < 0 || y + size/2 > height) {
      return true;
    }
    else {
      return false;
    }
  }
  
  // If bounced() is true ball bounces (reverse Y-velocity)
  void handleBounce() {
    if (bounced()) {
      vy = -vy;
    }
  }
  
    
   // Function to speed up a ball if is clicked in 
    void played() {
    if (dist(mouseX,mouseY,x,y) < size/2 && mousePressed) {
      if (vy >= 0) { 
         vy = vy + speedUp;
      }
      else if (vy < 0) {
         vy = vy - speedUp;
      } 
    }
    
  // Function to stop a ball when the stop key is pressed
  }
    void stopped() {
    if (keyCode == stopKey) {
      vy = 0;

    }
  }
  
  
  // And display an imaginary ball
  void display() {
    noStroke();
    fill(fillColor);
    ellipse(x,y,size,size);
  }
}
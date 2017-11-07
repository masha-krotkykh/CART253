// Ball class to describe a ball object

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
  int speedUp = 1;

  // Create a Ball with the provided values
  Ball (float tempX, float tempY, int tempVY, float tempSize, color tempFillColor) {
    x = tempX;
    y = tempY;
    vy = tempVY;
    size = tempSize;
    fillColor = tempFillColor;
  }
  
  // Update Ball by velocity
  void update() {
    y += vy;
    
    handleBounce();
  }
  
  // Lets a ball bounce (reverse Y-velocity) when it hits the bottom of the window
  void handleBounce() {
    if (y - size/2 < 0 || y + size/2 > height) {
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
  }
  
  // And display an imaginary ball
  void display() {
    noStroke();
    fill(fillColor);
    ellipse(x,y,size,size);
  }
}
// Bouncer
//
// A class that defines a circle that can bounce around on the screen
// at a specific velocity.

class Bouncer {

  // Variables for position
  float x;
  float y;

  // Variables for velocity
  float vx;
  float vy;

  // The size of the Bouncer
  float size;

  // The current fill colour of the Bouncer
  color fillColor;

  // The default fill colour of the Bouncer
  color defaultColor;


  // Bouncer(tempX,tempY,tempVX,tempVY,tempSize,tempDefaultColor)
  //
  // Creates a Bouncer with the provided values by remembering them.

  Bouncer(float tempX, float tempY, float tempVX, float tempVY, float tempSize, color tempDefaultColor) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    fillColor = defaultColor;
  }

  // update()
  //
  // Adds the Bouncer's current velocity to its position
  // and checks for bouncing off the walls.
  void update() {
    x += vx;
    y += vy;

    handleBounce();
  }

  // handleBounce()
  //
  // Checks if the bouncer is overlapping a side of the window
  // and if so reverses its velocity appropriately

  void handleBounce() {
    // Check the left and right
    if (x - size/2 < 0 || x + size/2 > width) {
      // Bounce on the x-axis
      vx = -vx;
    }

    // Check the top and bottom
    if (y - size/2 < 0 || y + size/2 > height) {
      // Bounce on the y-axis
      vy = -vy;
    }

    // Make sure the Bouncer isn't off the edge
    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }

  // display()
  //
  // Draw an ellipse in the Bouncer's location, with its size
  // and with its fill
  void display() {
    // *ADDED* some lines to turn bouncers into bugs
    stroke(fillColor);
    line(x-size/2, y-size/3, x+size/2, y-size/3);
    line(x-size/1.5, y, x+size/1.5, y);
    line(x-size/2, y+size/3, x+size/2, y+size/3);
    line(x,y-size/2,x-size/3, y-size);
    line(x,y-size/2,x+size/3, y-size);
    noStroke();
    fill(fillColor);
    ellipse(x, y, size/1.2, size);
  }
  
  // *ADDED* Detect if the brightest spot overlaps with a bouncer     
  void hit() {
    boolean insideLeft = (x + size/2 > brightestPixel.x - aimSize/2);
    boolean insideRight = (x - size/2 < brightestPixel.x + aimSize/2);
    boolean insideTop = (y + size/2 > brightestPixel.y - aimSize/2);
    boolean insideBottom = (y - size/2 < brightestPixel.y + aimSize/2);
    
    // And if so and a key is pressed, the bouncer stops and changes its fill to half-transparent red
    if (insideLeft && insideRight && insideTop && insideBottom && keyPressed) {
      vx = 0;
      vy = 0;
      fillColor = color(255,0,0,90);
    }
  }  
}
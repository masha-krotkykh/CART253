// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.

class Griddie {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;
  
  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255,0,0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {
    
    // QUESTION: What is this if-statement for?
    // ANSWER: To check if the energy level has reached 0. The length of the array doesn't change,
    // so the griddie still exists, but its energy level is 0 and cannot be restored, so it "disappears"
    if (energy == 0) {
      return;
    }
    
    // QUESTION: How does the Griddie movement updating work?
    // ANSWER: If we may say that 1 griddie occupies 1 "cell" 20x20px, then on x-axis it either "jumps" backwards or forwards 1 "cell",
    // or stays in place. Same for y-axis - it "jumps" 1 "cell" up or down, or stays on the same height. 
    // E.g. if the current x- position is 60, then the new position will be 60+20*m, where m(xMoveType) can be -1, 0, or 1.
    // if m = -1, griddie jumps back one cell, and the new x = 40 
    // if m = 0, griddie doesn't change its x-position, x = 60
    // if m = 1, griddie jumps 1 cell forward, x = 80.
    // same on y-axis
    int xMoveType = floor(random(-1,2));
    int yMoveType = floor(random(-1,2));
    x += size * xMoveType;
    y += size * yMoveType;
    
    // QUESTION: What are these if statements doing?
    // ANSWER: Cheks if the griddie goes off the screen and gives its new position on the oposite side of the window.
    // i.e. if it goes off the right side of the screen, the new x- position will be on the left side of the screen,
    // if it goes off the bottom of the screen, its new y-position will be at the top of the window.
    if (x < 0) {
      x += width;
    }
    else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    }
    else if (y >= height) {
      y -= height;
    }

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;
    
    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy,0,maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level
  
  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    // ANSWER: If the energy level is at 0 it doesn't change in the event of collision and doesn't change the energy of the 
    // other griddie in the collision instead it returns 0.
    if (energy == 0 || other.energy == 0) {
      return;
    }
    
    // QUESTION: What does this if-statement check?
    // ANSWER: It checks if two griddies have the same x- and y-coordinates i.e. if they overlap
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy,0,maxEnergy);
    }
  }
  

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    // ANSWER: It makes the fill opacity dependant on the energy level. The lower the energy, the lower the opacity.
    // fill = color red, energy (0-255)
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}
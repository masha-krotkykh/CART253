// Zombie
//
// A class defining the behaviour of a single Zombie
// which can move randomly in the window (within the grid),
// loses half the energy from overlapping with a Griddie, but creates two other Zombies and takes away 
// 100 from the Griddie's energy.

class Zombie {
  // Limits for energy level and gains/losses
  int maxEnergy = 100;
  int collideEnergy = -50;
  
  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(0,255,0);

  // Zombie(tempX, tempY, tempSize)
  //
  // Set up the Zombie with the specified location and size
  // Initialise energy to the maximum
  Zombie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Zombie and update its energy levels
  void update() {
    if (energy == 0) {
      return;
    }

    int xMoveType = floor(random(-2,3));
    int yMoveType = floor(random(-2,3));
    x += size * xMoveType;
    y += size * yMoveType;
    
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
  } 
    void collide(Griddie griddie) {
    if (energy == 0 || griddie.energy == 0) {
      return;
    }
  
   // Checks if Zombie overlaps with Griddie
    if (x == griddie.x && y == griddie.y) {
   // In this case Griddie dies (its energy drops to 0)   
      griddie.energy = 0;
      griddie.energy = constrain(griddie.energy,0,griddie.maxEnergy);
   // Zombie's own energy drops by collideEnergy which is 50 or a half (but not below 0)
      energy += collideEnergy;
      energy = constrain(energy,0,maxEnergy);
    // On every collision with a Griddy the number of zombies grows by 9
    // which leads to a ZOMBIE APOCALYPSE!!
       for (int i = 0; i < 9; i++) {
         zombies = (Zombie[]) append(zombies, new Zombie(floor(random(0,width)), floor(random(0, height)), zombieSize));
       }
    }
  }
 


  // display()
  //
  // Draw the Zombie on the screen as a rectangle
  void display() {
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}
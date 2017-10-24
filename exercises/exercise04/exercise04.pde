// Griddies
// by Pippin Barr
// MODIFIED BY: 
// Masha Krotkykh
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
int zombieSize = 10;
// An array storing all the griddies
Griddie[] griddies = new Griddie[100];
Zombie[] zombies = new Zombie[10];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(20);

  // QUESTION: What does this for loop do?
  // ANSWER: It generates new griddies from the array until their number reaches the total number of the array (100). 
  // Each individual griddie has it's random x- and y- coordinates within a given space in increments of 20px on
  // both x- and y- (so that they don't partially overlap?)
  for (int i = 0; i < griddies.length; i++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }
  
  // *CHANGED* adding zombie elements and defining their position and size.
  for (int z = 0; z < zombies.length; z++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    zombies[z] = new Zombie(x * gridSize, y* gridSize, zombieSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.
// *CHANGED* Update all the zombies, check for collisions with griddies, display them.
void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      // ANSWER: To check if there are two or more different griddies (with different indexes) in the same location
      if (j != i) {
        // QUESTION: What does this line check?
        // ANSWER: It checks for collisions between griddies. If there are two griddies with the same coordinates and they are !not the same
        // griddie than there was a collision
        griddies[i].collide(griddies[j]);
      }
    }
    
    
    // Display the griddies
    griddies[i].display();
  }
  
  // *CHANGED* Loop through all the zombies one by one 
  for (int z = 0; z < zombies.length; z++) {
  
    // *CHANGED* pdate the zombies
    zombies[z].update();
    
    // *CHANGED* Loop through all the griddies and checks if there was a collision between a zombie and a griddie
    for (int i = 0; i < griddies.length; i++) {
      zombies[z].collide(griddies[i]);
    }
    
    zombies[z].display();
  }
}
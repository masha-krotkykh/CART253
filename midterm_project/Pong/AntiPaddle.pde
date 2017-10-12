// AntiPaddle
//
// A class that defines an "anti-paddle" that can be moved left and right on the screen
// using keys passed through to the constructor.

class AntiPaddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;
  int HEIGHT = 16;
  int WIDTH = 70;

  // The position and velocity of the anti-paddle (note that vy isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;
  
  // The fill color of the paddle
  color paddleColor = color(255);

  // The characters used to make the paddle move left and right, defined in constructor
  char leftKey;
  char rightKey;


  /////////////// Constructor ///////////////

  // AntiPaddle(int _x, int _y, char _leftKey, char _rightKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  AntiPaddle(int _x, int _y, char _leftKey, char _rightKey) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    leftKey = _leftKey;
    rightKey = _rightKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    y += vy;

    // Constrain the paddle's y position to be in the window
    x = constrain(x,0 + WIDTH/2,width - WIDTH/2);
  }

  // display()
  //
  // Display the paddle at its location
  
  void display() {
    // Set display properties
    noStroke();
    fill(paddleColor);
    rectMode(CENTER);
    
    // Draw the paddle as a rectangle
    rect(x, y, WIDTH, HEIGHT);
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program
  
  void keyPressed() {
    // Check if the key is our left key
    if (key == leftKey) {
      // If so we want a negative y velocity
      vx = -SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == rightKey) {
      // If so we want a positive y velocity
      vx = SPEED;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up left and the paddle is moving right
    if (key == leftKey && vx < 0) {
      // If so it should stop
      vx = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == rightKey && vx > 0) {
      // If so it should stop
      vx = 0;
    }
  }
}
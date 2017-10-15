// Paddle
//
// A class that defines a paddle that can be moved up and down on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 10;
  int HEIGHT = 150;
  int WIDTH = 40;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;
  
  // *REMOVED* no need for paddle color - will contain image
  // The fill color of the paddle
  //color paddleColor = color(255);

  // The characters used to make the paddle move up and down, defined in constructor
  char upKey;
  char downKey;
  
  // *ADDED* PImage to display image instead the paddle
  PImage image;
  boolean usesMouse;


  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  Paddle(int _x, int _y, String _image, boolean _usesMouse) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    image = loadImage(_image);
    usesMouse = _usesMouse;

  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    y += vy;

// *ADDED* if is controlled by mouse, move paddle to the position of the mouse pointer on Y-axis    
    if (usesMouse) {
      y = mouseY;
    }
    
    // Constrain the paddle's y position to be in the window
    y = constrain(y,0 + HEIGHT/2,height - HEIGHT/2);
  }

  // display()
  //
  // Display the paddle at its location
  
  void display() {
    // Set display properties
    imageMode(CENTER);
    image(image,x,y);
    
    // *REMOVED* no need for rectangle anymore
    // Draw the paddle as a rectangle
    //rect(x, y, WIDTH, HEIGHT);
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program
  // *CHANGED* If is not controlled by mouse, controlled by Up and Down arrows
  void keyPressed() {
    // Check if the key is our up key
    if (key == CODED) {
      // If so we want a negative y velocity
      if (keyCode == UP) {
      vy = -SPEED;
      } // Otherwise check if the key is our down key 
      else if (keyCode == DOWN) {
      // If so we want a positive y velocity
      vy = SPEED;
      }
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up key and the paddle is moving up
    if (keyCode == UP && vy < 0) {
      // If so it should stop
      vy = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (keyCode == DOWN && vy > 0) {
      // If so it should stop
      vy = 0;
    }
  }
}
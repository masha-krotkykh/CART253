// AntiPaddle
//
// A class that defines an "anti-paddle" that can be moved left and right on the screen
// using keys passed through to the constructor.

class AntiPaddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 10;
  int HEIGHT = 30;
  int WIDTH = 100;

  // The position and velocity of the anti-paddle (note that vy isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;

  // The characters used to make the paddle move left and right, defined in constructor
  char leftKey;
  char rightKey;
  
  // *ADDED* PImage to display image instead the anti-paddle
  PImage image;
  boolean usesMouse;

  /////////////// Constructor ///////////////

  // AntiPaddle(int _x, int _y, char _leftKey, char _rightKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  AntiPaddle(int _x, int _y, String _image, boolean _usesMouse) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    
    // *ADDED* PImage to display image instead the anti-paddle
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
    
    // *ADDED* if is controlled by mouse, move paddle on X-axis to the position of -mouseY    
    if(usesMouse) {
      x = width - mouseY;
    }
    
      // Constrain the paddle's y position to be in the window
      x = constrain(x, 0 + WIDTH/2, width - WIDTH/2);
    
  }

  // display()
  //
  // Display the anti-paddle at its location
  
  void display() {
    // Set display properties
    imageMode(CENTER);
    image(image,x,y);

  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program
  // *CHANGED* If is not controlled by mouse, controlled by Up and Down arrows
  void keyPressed() {
    // Check if the key is our up key
    if (key == CODED) {
      // If so we want a positive x velocity
      if (keyCode == UP) {
      vx = SPEED;
      } // Otherwise check if the key is our down key 
      else if (keyCode == DOWN) {
      // If so we want a negative x velocity
      vx = -SPEED;
      }
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up left and the paddle is moving right
    if (keyCode == DOWN && vx < 0) {
      // If so it should stop
      vx = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (keyCode == UP && vx > 0) {
      // If so it should stop
      vx = 0;
    }
  }
}
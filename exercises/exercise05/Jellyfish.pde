// Class for jellyfish that swims randomly across the screen with noise
// upon collision with Octie decreases Octie's score and resests it's y-coordinates to 0 and jumps down

class Jellyfish {

  float tx = random(0,100);
  float ty = random(0,100);
  float speed = 3;
  float x;
  float y;
  PImage image; 
  int WIDTH = 40;
  int HEIGHT = 60;
  
  
  Jellyfish(float tempX, float tempY) {
    x = tempX;
    y = tempY;  
  }
  
  // Moves with noise() function 
  void update() {
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;
    
    // small time increments for smoother movements
    tx += 0.01;
    ty += 0.05;
    
    // "wraps" around the window when goes off the edge
    // on x-axis
    if (x < 0) {
      x = x + width;
    }
    else if (x > width) {
      x = x - width;
    }
    // or on y-axis
    if (y < 0) {
      y = y + height;
    } 
    else if (y > height) {
      y = y - height;
    }  
    
  }
  void display() {
    image = loadImage("jellyfish.png");
    imageMode(CENTER);
    image(image,x,y);
  }
  
  // *Block of code taken from the midterm*
  // to check for collisions between a yellow fish and Octie
  void collide(Octie octie) {
    boolean insideLeft = (x + WIDTH/2 > octie.x - octie.WIDTH/2);
    boolean insideRight = (x - WIDTH/2 < octie.x + octie.WIDTH/2);
    boolean insideTop = (y + HEIGHT/2 > octie.y - octie.HEIGHT/2);
    boolean insideBottom = (y - HEIGHT/2 < octie.y + octie.HEIGHT/2);
    
    // Upon collision with Octie decreases Octie's score and resests it's x-coordinates to random and y to 0
    if (insideLeft && insideRight && insideTop && insideBottom) {
      x = floor(random(0,width));
      y = 0;
      
      // Being stung by a jellyfish starts the timer (and it doesn't stop until a blue fish is caught).
      timerRunning = true;
    }
    
        
    // if y is bigger than the height or smaller than 0, "wraps" around the window and shows up at the top or down at the bottom
    if (y > height) {
      y = y - height;
    }
    else if (y < 0) {
      y = y + height;
    }
  }
}
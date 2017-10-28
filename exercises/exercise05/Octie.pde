 // Class for a pet octopus

class Octie {
  
  float tx = random(0,100);
  float ty = random(0,100);
  float speed = 5;
  float x;
  float y;
  PImage image; 
  int jump = 30;
  int WIDTH = 40;
  int HEIGHT = 40;
  
  
  Octie(float tempX, float tempY) {
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
    ty += 0.01;
    
    
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
    image = loadImage("octopus.png");
    imageMode(CENTER);
    image(image,x,y);
  }
  
  // Movement can be adjusted by 30 pixels by pressing arrow keys
  void keyPressed() {
    if (key == CODED) {
      if (keyCode == RIGHT) {
        x = x + jump;
      }
      else if (keyCode == LEFT) {
        x = x - jump;
      }
      else if (keyCode == DOWN) {
        y = y + jump;
      }
      else if (keyCode == UP) {
        y = y - jump;
      }
    }
  }
}
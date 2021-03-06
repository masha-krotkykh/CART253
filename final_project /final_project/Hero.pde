// Class hor "hero" a fishing hook
// Declaring basic variables (position, size, velocity and speed)

class Hero {
  int x;
  int y;
  float vx;
  float vy;
  PImage heroImg;
  int WIDTH = 24;
  int HEIGHT = 87;
  int speed;
  // boolean to check if there is already something on the hook
  boolean onHook = false;

  // Constructing a template for hero
  Hero(PImage tempHeroImg, int tempX, int tempY) {
    x = tempX;
    y = tempY;
    heroImg = tempHeroImg;
  }
 
  // Moves by velocity
  void update() {
    if (stats.fishLeft <= 0 || stats.countDown <= 0) {
      speed = 0;
    }
    else {
      speed = 2; 
    }
    x += vx;
    y += vy;
  }
  
  // Displaying the fishing hook 
  void display() {
    imageMode(CENTER);
    image(heroImg,x,y);
    // and fishing line
    stroke(0);
    line (x,0,x,y - HEIGHT / 2);
    // The hook is constrained within the window
    x = constrain(x, 0 + WIDTH/2, width - WIDTH/2);
    y = constrain(y, -HEIGHT/2 + stats.statsHeight, height - HEIGHT/2);
  }
  
  // The hook is controlled with arrow keys
  void keyPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        vy = -speed;
      }
      else if (keyCode == DOWN) {
        vy = speed;
      }
      else if (keyCode == RIGHT) {
        vx = speed;
      }
      else if (keyCode == LEFT) {
        vx = -speed;
      } 
    } 
  }
}


class Bubble {
  float x;
  float y;
  float vx;
  float vy;
  int size;
  int speed = floor (random(3,8));

  // Constructing a template for bubbles
  Bubble(float tempX, float tempY, int tempSize, float tempVY, float tempVX) {
    x = tempX;
    y = tempY;
    size = tempSize;
    vy = tempVY;
    vx = tempVX;
  }
 
  // Moves by velocity
  void update() {
    x += vx;
    y += vy;
  }
  
  // Displaying bubbles
  void display() {
    for (int n = 0; n < nastyFishes.length; n++) {
      if (nastyFishes[n].collide(hero) == true) {
        ellipseMode(CENTER);
        stroke(255);
        fill(255,255,255,50);
        ellipse(x,y,size,size);
      }  
    }
  }
}
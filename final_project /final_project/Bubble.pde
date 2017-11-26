// Class for bubbles that will appear as penalty for catching a nasty fish

class Bubble {
  float x;
  float y;
  float vx;
  float vy;
  int size;

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
    
    if (y < 0) {
      y = y + height;
    }
  }
  
  // Displaying bubbles
  void display() {
        ellipseMode(CENTER);
        stroke(255);
        fill(255,255,255,50);
        ellipse(x,y,size,size);
  }
}
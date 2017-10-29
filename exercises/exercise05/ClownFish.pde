// Class for clown fish that swims from left to right (or right to left) across the screen
// upon collision with Octie increases Octie's score and resests it's x-coordinates to 0 and jumps down

class ClownFish {

  float x;
  float y;
  float vx;
  int speed = 8;
  PImage image;
  int fishWidth = 50;
  int fishHeight = 25;
  int shiftY = 70;
  
  ClownFish(float tempX, float tempY) {
   x = tempX;
   y = tempY;
   vx = speed;
   
  }
  
  // Changes velocity randomly within small limits
  void update() {
    x += vx * random(0.3,1);
    // Changes direction when reaches the edge of the window
    if (x - fishWidth/2 >= width || x + fishWidth <= 0) {
      vx = -vx;
    }
    
  }
  void display() {
    image = loadImage("clown_fish.png");
    imageMode(CENTER);
    
    // Flip the image on x-axis when the velocity is negative
    if (vx < 0) {  
      pushMatrix();
      translate(x,y);
      scale(-1,1);
      image(image, -image.width,0);
      popMatrix();
    }
    else {
      image(image,x,y);
    }
  }
  
  // *Block of code taken from the midterm*
  // to check for collisions between a yellow fish and Octie
  void collide(Octie octie) {
    boolean insideLeft = (x + fishWidth/2 > octie.x - octie.WIDTH/2);
    boolean insideRight = (x - fishWidth/2 < octie.x + octie.WIDTH/2);
    boolean insideTop = (y + fishHeight/2 > octie.y - octie.HEIGHT/2);
    boolean insideBottom = (y - fishHeight/2 < octie.y + octie.HEIGHT/2);
    
    // Upon collision with Octie increases Octie's score and resests it's x-coordinates to 0 and jumps down 70px
    if (insideLeft && insideRight && insideTop && insideBottom) {
      x = 0 - fishWidth/2 ;
      y = y + shiftY;
      score = score + 20;
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
// Class for random fish that swims from left to right (or right to left) across the screen
// upon collision with Octie increases Octie's score and resests it's x-coordinates to 0 and randomly changes y-position

class RandomFish {

  float x;
  float y;
  float vx;
  int speed = floor(random(3,8));
  int fishWidth = 60;
  int fishHeight = 30;
  int shiftY = 30 * floor(random(-4,5));
  PImage fishPic;
  int collision = 0;
  
  RandomFish(PImage tempFishPic, float tempX, float tempY, float tempVX) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   fishPic = tempFishPic;

  }
  
  void update() {
    imageMode(CENTER);
    // Changes velocity randomly within small limits
    x += vx * random(0.1,1);
    // Changes direction when reaches the edge of the window
    if (x - fishWidth >= width || x + fishWidth <= 0) {
      vx = -vx;
      y = y + shiftY;
    }
    
  }
  void display() {

    
    // Flip the image on x-axis when the velocity is negative
    if (vx < 0) {  
      pushMatrix();
      translate(x,y);
      scale(-1,1);
      image(fishPic, -fishPic.width,0);
      popMatrix();
    }
    else {
      image(fishPic,x,y);
    }
  }
  
  // *Block of code taken from the midterm*
  // to check for collisions between a yellow fish and Octie
  void collide(Octie octie) {
    boolean insideLeft = (x + fishWidth/2 > octie.x - octie.WIDTH/2);
    boolean insideRight = (x - fishWidth/2 < octie.x + octie.WIDTH/2);
    boolean insideTop = (y + fishHeight/2 > octie.y - octie.HEIGHT/2);
    boolean insideBottom = (y - fishHeight/2 < octie.y + octie.HEIGHT/2);
    
    // Upon collision with Octie increases Octie's score and resests it's x-coordinates to 0 and jumps randomly on y-axis
    if (insideLeft && insideRight && insideTop && insideBottom) {

      x = 0 - fishWidth/2 ;
      y = y + shiftY;
      collision = collision + 1;
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
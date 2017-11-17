// Class for fishes that are to be caught
// Declaring basic parameters: position, velocity, speed, size...

class PrizeFish {
  float x;
  float y;
  float vx;
  float vy;
  int speed = floor (random(3,8));
  PImage prizeFishPic;
  float fishWidth = 300;
  int fishHeight = 50;
  
  // Constructing a template for fish instances with given parameters
  PrizeFish(PImage tempPrizeFishPic, float tempX, float tempY, float tempVX, float tempVY) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    prizeFishPic = tempPrizeFishPic;
  }
  

  void update() {
    // Changes X-velocity randomly within small limits to give more organic movement
    // Moves forward by velocity
    x += vx * random(0.1,1);
    y += vy;
    
    // Wraps around the window horizontally
    if (x - fishWidth/2 >= width) {
      x = x - width - fishWidth;
    }
    else if (x + fishWidth <= 0) {
      x = x + width + fishWidth/2;
    }
    
    // "Bounces off" vertically
    else if (y - fishHeight/2 >= height || y + fishHeight/2 <= 0) {
      vy = -vy;
    }  
  }
  
  // Displaying fishes
  void display() {
    imageMode(CENTER);
    
    // If a fish swims from right to left, its image gets flipped horizontally
    if (vx < 0) {  
      pushMatrix();
      translate(x,y);
      scale(-1,1);
      image(prizeFishPic, 0, 0);
      popMatrix();
    }
    else {
      image(prizeFishPic,x,y);
    }    
  }
   
   
   // Checking if a fish collides with the hook and
    void hooked(Hero hero) {    
      boolean insideLeft = (x + prizeFishPic.width/2 > hero.x - hero.WIDTH/2);
      boolean insideRight = (x < hero.x + hero.WIDTH/2);
      boolean insideTop = (y + fishHeight/2 > hero.y - hero.HEIGHT/2);
      boolean insideBottom = (y - fishHeight/2 < hero.y + hero.HEIGHT/2);
      
      // if it does, it gets hooked, i.e. its position becomes the same as the position of the hook
      if (insideLeft && insideRight && insideTop && insideBottom) {
        x = hero.x;
        y = hero.y; 
        
        // and the image gets turned upwards
        imageMode(CENTER);
        pushMatrix();     
        translate(x,y);
        rotate(radians(270));
        image(prizeFishPic, -prizeFishPic.width/1.5, 0);
        popMatrix();
      }
      
      // If a fish is hooked and dragged out (if its Y-positio equals or less than 0) the number of fishes caught increases by 1
      // and the array of fishes gets shorter untill all the fish is caught
      if (insideLeft && insideRight && insideTop && insideBottom && y <= 0 ) {
        caught = caught + 1;
        y = y + height;
        prizeFishes = (PrizeFish[])shorten(prizeFishes);
      }
    }
    
    // Returns the number of caught fish for future score
    int getCaught() {
      return caught;
    }
}
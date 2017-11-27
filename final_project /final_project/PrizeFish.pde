// Class for fishes that are to be caught
// Declaring basic parameters: position, velocity, speed, size...

class PrizeFish {
  float x;
  float y;
  float vx;
  float vy;
  PImage prizeFishPic;
  float fishWidth = 300;
  int fishHeight = 50;
  boolean collide = false;
  
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
    if (x - fishWidth >= width) {
      x = x - width - fishWidth;
    }
    else if (x + fishWidth <= 0) {
      x = x + width + fishWidth;
    }
    
    // "Bounces off" vertically
    else if (y - fishHeight/2 >= height || y + fishHeight/2 <= 0) {
      vy = -vy;
    }  
  }
      
    //Checking if a fish collides with the hook and 
    boolean collide(Hero hero) {    
      boolean insideLeft = (x + fishWidth/2 > hero.x - hero.WIDTH/2);
      boolean insideRight = (x < hero.x + hero.WIDTH/2);
      boolean insideTop = (y + fishHeight/2 > hero.y - hero.HEIGHT/2);
      boolean insideBottom = (y - fishHeight/2 < hero.y + hero.HEIGHT/2);
      
      // and returning the value of the boolean
      if (insideLeft && insideRight && insideTop && insideBottom) {
        collide = true;
      }
      else {
        collide = false;
      }
      return collide;
    }
  
    // if a fish collides with hero, it gets hooked, i.e. its position becomes the same as the position of the hook
    void hooked() {
      if (collide == true) {
        if (stats.countDown <= 0) {
          return;
        }
        else {
          x = hero.x;
          y = hero.y;
        } 
      }
      
      // When the fish is dragged to the surface it disappears from the array list
      if (collide == true && y <= stats.statsHeight / 2) {
        prizeFishes.remove(this);
        caught = caught + 1;
      }
    }

  
  // Displaying fishes
  // if a fish is hooked it turns upwards when dragged to the surface
  void display() {
      if (collide == true) {
        imageMode(CENTER);
        pushMatrix();     
        translate(x,y);
        rotate(radians(270));
        image(prizeFishPic, -prizeFishPic.width/1.5, 0);
        popMatrix();
      }
      // If a fish swims from right to left, its image gets flipped horizontally    
      else if (collide == false && vx < 0) {  
        pushMatrix();
        translate(x,y);
        scale(-1,1);
        image(prizeFishPic, 0, 0);
        popMatrix();
      }
      // Otherwise the display default image 
      else {
        image(prizeFishPic,x,y);
      } 
  }
}   
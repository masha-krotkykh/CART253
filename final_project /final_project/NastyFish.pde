// Class for fishes that are to be avoided
// Declaring basic parameters: position, velocity, speed, size...

class NastyFish {
  float x;
  float y;
  float vx;
  float vy;
  int speed = floor (random(1,8));
  PImage nastyFishPic;
  float fishWidth = 100;
  int fishHeight = 50;
  float tx = random(10,100);
  float ty = random(10,100);
  
  // Constructing a template for fish instances with given parameters
  NastyFish(PImage tempNastyFishPic, float tempX, float tempY) {
    x = tempX;
    y = tempY;
    nastyFishPic = tempNastyFishPic;
  }
  

  void update() {
    // Moves forward pseudorandomly by velocity with noise() function;
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;
    
    // small time increments for smoother movements
    tx += 0.01;
    ty += 0.05;
    
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
  
  // Displaying fishes
  void display() {
    imageMode(CENTER);
  }
   
   
   // Checking if a fish collides with the hook and
    void hooked(Hero hero) {    
      boolean insideLeft = (x + fishWidth / 2 > hero.x - hero.WIDTH/2);
      boolean insideRight = (x < hero.x + hero.WIDTH/2);
      boolean insideTop = (y + fishHeight / 2 > hero.y - hero.HEIGHT/2);
      boolean insideBottom = (y - fishHeight / 2 < hero.y + hero.HEIGHT/2);
      
      // if it does, it gets hooked, i.e. its position becomes the same as the position of the hook
      if (insideLeft && insideRight && insideTop && insideBottom) {
        x = hero.x;
        y = hero.y; 
        
        // and the image gets turned upwards
        imageMode(CENTER);
        pushMatrix();     
        translate(x,y);
        rotate(radians(270));
        image(nastyFishPic, -nastyFishPic.width/1.5, 0);
        popMatrix();
      }
      // If a fish swims from right to left, its image gets flipped horizontally    
      else if (vx < 0) {  
        pushMatrix();
        translate(x,y);
        scale(-1,1);
        image(nastyFishPic, 0, 0);
        popMatrix();
      }
      else {
        image(nastyFishPic,x,y);
      }    

      
      // If a fish is hooked and dragged out (if its Y-positio equals or less than 0) the number of fishes caught increases by 1
      // and the array of fishes gets shorter untill all the fish is caught
      if (insideLeft && insideRight && insideTop && insideBottom && y <= stats.statsHeight / 2) {
        bitten = bitten + 1;
        y = y + height - stats.statsHeight/2;
      }
    }
        // Returns the number of caught fish for future score
    int gotBitten() {
      return bitten;
    }
}
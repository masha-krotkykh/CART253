// Class for fishes that are to be avoided
// Declaring basic parameters: position, velocity, speed, size...

class NastyFish {
  int x;
  int y;
  float vx;
  float vy;
  int speed = floor (random(1,8));
  int fishWidth = 100;
  int fishHeight = 50;
  float tx = random(10,100);
  float ty = random(10,100);
  boolean collide = false;
  
  // Constructing a template for fish instances with given parameters
  NastyFish(PImage tempNastyFishPic, int tempX, int tempY) {
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
    
    // and vertically
    else if (y - fishHeight/2 >= height) {
      y = y - height;
    }  
    else if (y + fishHeight/2 <= 0) {
      y = y + height;
    }   
  }
  
  // Displaying fishes
  void display() {
    imageMode(CENTER);
    image(nastyFishPic,x,y + fishHeight); 
  }
   
   
   // Checking if a fish collides with the hook and
    boolean collide (Hero hero) {    
      boolean insideLeft = (x + fishWidth / 2 > hero.x - hero.WIDTH/2);
      boolean insideRight = (x < hero.x + hero.WIDTH/2);
      boolean insideTop = (y + fishHeight / 2 > hero.y - hero.HEIGHT/2);
      boolean insideBottom = (y - fishHeight / 2 < hero.y + hero.HEIGHT/2);
            
     // and returning the value of the boolean
      if (insideLeft && insideRight && insideTop && insideBottom) {
        collide = true;
      }
      else {
        collide = false;
      }
      return collide;
    }
           
    void hooked() { 
      // if it does, it gets hooked, i.e. its position becomes the same as the position of the hook
      if (collide == true) {
        x = hero.x;
        y = hero.y; 
        penaltySound.play();
      }
       
      
      if (collide == true && y <= stats.statsHeight / 2) {
        y = y + height - stats.statsHeight/2;
        penaltySound.pause();
        penaltySound.rewind();
      }
      
    }  
}
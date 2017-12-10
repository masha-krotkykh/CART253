// Class for sea horses that help fish escape from the hook
// Declaring basic parameters: position, velocity, speed, size...

class SeaHorse {
  int x;
  int y;
  float vx;
  float vy;
  float speed = random(0,8);
  int horseWidth = 40;
  int horseHeight = 100;
  float tx = random(10,100);
  float ty = random(10,100);
  float easing = 0.04;
  
  // Constructing a template for sea horse instances with given parameters
  SeaHorse(PImage tempSeaHorsePic, int tempX, int tempY) {
    x = tempX;
    y = tempY;
    seaHorsePic = tempSeaHorsePic;
  }
  

  void update() {
 // Gets attracted to the hook when a fish is hooked       
   if(hero.onHook) {
      float targetX = hero.x;
      float dx = targetX - x;
      x += dx * easing;
  
      float targetY = hero.y;
      float dy = targetY - y;
      y += dy * easing;
    }

    // Moves forward pseudorandomly by velocity with noise() function;
    float vx = speed * (noise(tx) * 2 - 1);
    float vy = speed * (noise(ty) * 2 - 1);
    x += vx;
    y += vy;
    
    // small time increments for smoother movements
    tx += 0.08;
    ty += 0.05;
 
    // Wraps around the window horizontally
    if (x - horseWidth/2 >= width) {
      x = x - width;
    }
    else if (x + horseWidth/2 <= 0) {
      x = x + width;
    }
    
    // and vertically
    else if (y - horseHeight/2 >= height) {
      y = y - height;
    }  
    else if (y + horseHeight/2 <= 0) {
      y = y + height;
    } 
  }
  
  // Displaying sea horses
  void display() {
    imageMode(CENTER);
    image(seaHorsePic,x,y);
  }  
       // Checking if a sea horse collides with (attacks) the hook
    boolean collide (Hero hero) {    
      boolean insideLeft = (x + horseWidth / 2 > hero.x - hero.WIDTH / 2);
      boolean insideRight = (x - horseWidth / 2 < hero.x + hero.WIDTH / 2);
      boolean insideTop = (y + horseHeight / 2 > hero.y - hero.HEIGHT / 2);
      boolean insideBottom = (y - horseHeight / 2 < hero.y + hero.HEIGHT / 2);
            
   // and returning the value of the boolean
      if (insideLeft && insideRight && insideTop && insideBottom) {
        horseAttack = true;
      }
      else {
        horseAttack = false;
      }
      return horseAttack;
    }
}
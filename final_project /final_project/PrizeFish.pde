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
  float level;
  
  boolean timerRunning = false;
  int startTime = 0;
  int timeElapsed;
  int fishScared = 10;

    
  // Constructing a template for fish instances with given parameters
  PrizeFish(PImage tempPrizeFishPic, float tempX, float tempY, float tempVX, float tempVY) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    prizeFishPic = tempPrizeFishPic;
  }
  

  void update() {

    // Check if it's too noisy
    level = mic.mix.level();
    // and if it is, the timer gets triggered
    if (level >= 0.05) {
      timerRunning = true;
    }
    
    // When the countdown reaches 0, it stops and gets reset
    if (fishScared <= 0) {
      timerRunning = false;
      fishScared = 10;
      startTime = millis();
    }
    
   // Timer 
   if (timerRunning) {
      timeElapsed = (millis() - startTime) / 1000;
      fishScared = 10 - timeElapsed;
      // And fish starts swimming faster for 10 seconds
      x += vx * 5 + 1;
    }
    
    
    else {
    // Changes X-velocity randomly within small limits to give more organic movement
    // Moves forward by velocity
      x += vx * random(0.2,1);
      y += vy;
    }
    
    // Fish wraps around the window horizontally
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
      boolean insideLeft = (x + fishWidth / 2 > hero.x - hero.WIDTH / 2);
      boolean insideRight = (x - fishWidth / 2 < hero.x + hero.WIDTH / 2);
      boolean insideTop = (y + fishHeight / 2 > hero.y - hero.HEIGHT / 2);
      boolean insideBottom = (y - fishHeight / 2 < hero.y + hero.HEIGHT / 2);
            
      // and returning the value of the boolean
      if (insideLeft && insideRight && insideTop && insideBottom && !hero.onHook && stats.countDown > 0) {
        collide = true;
        hero.onHook = true;
      }
      else {
        collide = false;
        hero.onHook = false;
      }
      return collide;
    }
  
    // if a fish collides with hero, it gets hooked, i.e. its position becomes the same as the position of the hook
    // unless the time is up
    void hooked() {
      if (collide == true) {
        if (stats.countDown <= 0) {
          return;
        }
        
        // If the hook gets attacked by the sea horse fish gets unhooked
        else if (horseAttack) {
          collide = false;
          x = 0;
          y = y + 50;
          hero.onHook = false;
          vx = -vx;
          vy = -vy;
        }
        else {
          x = hero.x;
          y = hero.y;
        } 
      }
      
      // When the fish is dragged to the surface it disappears from the array list
      if (collide == true && y <= stats.statsHeight / 2) {
        prizeFishes.remove(this);
        
        // sets the value of something being on the hook to false
        hero.onHook = false;
        // Number of fishes caught increases by 1
        caught = caught + 1;
        stats.score = stats.score + 10 * stats.levelCounter;
        
        // Splash plays and rewinds to be ready to be played again
        caughtSound.play();
        caughtSound.rewind();
      }
    }

  
  // Displaying fishes
  // if a fish is hooked it turns upwards when dragged to the surface
  void display() {
      if (collide == true && !horseAttack) {
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
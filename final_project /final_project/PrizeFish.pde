
class PrizeFish {
  float x;
  float y;
  float vx;
  float vy;
  int speed = floor (random(3,8));
  PImage prizeFishPic;
  int fishWidth;
  int fishHeight;
  int collision = 0;
  boolean hooked = false;
  
  PrizeFish(PImage tempPrizeFishPic, float tempX, float tempY, float tempVX, float tempVY) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    prizeFishPic = tempPrizeFishPic;
  }
  
  void update() {
    imageMode(CENTER);
    // Changes velocity randomly within small limits
    x += vx * random(0.1,1);
    y += vy;
    // Wraps around the window
    if (x - fishWidth/2 >= width) {
      x = x - width;
    }
    else if (x + fishWidth/2 <= 0) {
      x = x + width;
    }
    else if (y - fishHeight/2 >= height || y + fishHeight/2 <= 0) {
      vy = -vy;
    }  
  }
  
  void display() {
    if (vx < 0) {  
      pushMatrix();
      translate(x,y);
      scale(-1,1);
      image(prizeFishPic, -prizeFishPic.width,0);
      popMatrix();
    }
    else {
      image(prizeFishPic,x,y);
    }    
  }

  
    boolean hooked() {      
      if ((x + fishWidth/2 > hero.x - hero.WIDTH/2) && (x - fishWidth/2 < hero.x + hero.WIDTH/2) && (y + fishHeight/2 > hero.y - hero.HEIGHT/2) && (y - fishHeight/2 < hero.y + hero.HEIGHT/2)) {
        return true;
      }
      else {
        return false;
      }
    } 
    
    void drag() {
      if (hooked == true && vy <= 0) {
      
      }
    }
}
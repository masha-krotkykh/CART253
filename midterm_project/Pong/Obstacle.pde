// *ADDED* a new class for an obstacle that moves up and down the center of the screen
//-----PROPERTIES-----
class Obstacle {

  int x;
  int y;
  int size = 10;
  int vy;
  int speed = 3;
  PImage image;
  
  Obstacle(int tempX, int tempY) {
    x = tempX;
    y = tempY;
    vy = speed;
  }
 
  // Changes directions when reaches the edge of the window
  void update() {
    x = width/2;
    y += vy;
    if (y + size/2 > height || y - size/2 < 0) {
      vy = -vy;
    }
  }
  
  // Dispaly an image of a spider facing down when moving down
  void display() {
        if(vy > 0) {
      image = loadImage("spider_down.png");
    }
  // ..and up, when going up  
    else if (vy < 0) {
      image = loadImage("spider_up.png");
    }  
    imageMode(CENTER);
    image(image,x,y);
  }
  
}
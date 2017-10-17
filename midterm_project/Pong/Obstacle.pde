// *ADDED* a new class for an obstacle that moves up and down the center of the screen
// and changes the velocity and direction of the ball upon collision
//-----PROPERTIES-----
class Obstacle {

  int x;
  int y;
  int obstacleHeight = 100;
  int obstacleWidth = 10;
  int vy;
  int speed = 3;
  
 // Declaring a variable for an image to be used instead of the obstacle
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
    if (y + obstacleHeight/2 > height || y - obstacleHeight/2 < 0) {
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
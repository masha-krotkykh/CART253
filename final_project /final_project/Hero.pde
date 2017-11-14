
class Hero {
  float x;
  float y;
  float vx;
  float vy;
  PImage heroImg;
  int WIDTH;
  int HEIGHT;
  int speed = 1;
  
  Hero( float tempX, float tempY) {
    x = tempX;
    y = tempY;
    //heroImg = tempHeroImg;
  }
  
  void update() {
    x += vx;
    y += vy;

  }
  
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(x,y,10,50);
    stroke(255);
    line (x,0,x,y);
    x = constrain(x,0,width);
    y = constrain(y,0,height);
  }
  
  void controlls() {
    if (keyPressed) {
      if (keyCode == UP) {
        vy = -speed;
      }
      else if (keyCode == DOWN) {
        vy = speed;
      }
      else if (keyCode == RIGHT) {
        vx = speed;
      }
      else if (keyCode == LEFT) {
        vx = -speed;
      } 
    } 
  }
}
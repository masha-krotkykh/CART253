//*CHANGED* Added a new class for RandomMover. A square with the size of 5, constrained within the window, that changes its direction and velocity.
class RandomMover {
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 
  RandomMover(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempFillColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   fillColor = tempFillColor;
 }
 
 void update() {

   x += vx + random (-10, 10);
   y += vy + random (-15, 15);
 
   handleBounce();
 }
 
 void handleBounce() {
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
   }
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 void draw() {
   stroke(0);
   noFill();
   rectMode(CENTER);
   rect(x,y,size,size);
 }
}
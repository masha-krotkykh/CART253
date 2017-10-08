//Bouncer object to be called by the main file.

//Bouncer class name.
class Bouncer {
// Data. Instance variables for object properties  
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 int growth;

 //Constructor with arguments. 
 //Arguments will be used in the main file to define the initial behaviour of each instance of the bouncer object
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 //Functionality of the bouncer. 
 //It should move (be updated) by velocity. i.e. its updated position is its previous position + velocity (both X- and Y-axis)
 void update() {
   x += vx;
   y += vy;
 
   //Calling functions
   handleBounce();
   handleMouse();
 }
 
 //handleBounce function describes bouncer behaviour when colliding with walls.
 //The bouncer X-velocity changes to the oposite (it goes the oposite way on X-axis)
 //when its edge hits right or left margin of the window. Same happens on the Y-axis when the bouncer hits 
 //top or bottom of the window. X and Y position of the bouncer are constrained within the window for cleaner look
 void handleBounce() {
 //*CHANGED* Added a variable to use for size increase / decrease
   growth = 4;
   
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
//*CHANGED* When the bouncer hits left or right size of the window it changes its size in increments of 4
//when the size reaches 4, it starts growing until it reaches 10.
      if (size <= 4 || size >= 10) {
         size = size - growth;
       }  
       else {
         size = size + growth;
       }
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
//*CHANGED* When the bouncer hits top or bottom of the window, its new instance appears 
//in random placewithin the window     
     x = floor (random(width));
     y = floor (random(height));
   }
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }

 
 //handleMouse function. When the mouse pointer overlapse the bouncer, the bouncer colour
 //changes to the hover colour. 
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   else {
     fillColor = defaultColor;
   }
 }
 
 // draw function defines the appearanceof every instance of the bouncer 
 void draw() {
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }

 //*CHANGED* Added a new method to check if the mouse butto is pressed. If it is pressed, velocity on X-axis changes to the opposite
 void mouseClicked() {
   handleClick();
 }
 
 void handleClick() {
   if (dist(mouseX,mouseY,x,y) < size/2 && mousePressed) {
   vx = -vx;
   }
 }
}
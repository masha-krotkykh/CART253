final int CIRCLE_SPEED = 7;
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;
// Declaring and initializing final variables that cannot be changed within the program. 
// CIRCLE_SPEED to 7 (a whole number)
// NO_CLICK_FILL_COLOR colour set to pink(-ish)?
// CLICK_FILL_COLOR set to blue
// BACKGROUND_COLOR set to a slightly lighter pink
// STROKE_COLOR colour set to the same colour as the background
// CIRCLE_SIZE is set to 50px

int circleX;
int circleY;
int circleVX;
int circleVY;
// Declaring variables (presumably for the circle position).

float currentCircleSize = CIRCLE_SIZE - 20;
float growth = 0.1;
// *CHANGED* Added currentCircleSize variable and growth variable to be able to resize the circle
int currentColor = NO_CLICK_FILL_COLOR;
int colorChange = 1;
//*CHANGED* Added currentColor and colorChange variables to be make it possible for the circle to change its colour 
int speedChange = 2;
//*CHANGED* Added a variable to be able to change the speed

boolean restart = false;
int buttonX1;
int buttonY1;
int buttonX2;
int buttonY2;
//*CHANGED* New variables for the restart button

void setup() {
  size(380, 800);
// Setting window size to 640 x 480px
  circleX = width/2;
  circleY = height/2;
// Assigning values to variables CircleX and circleY to be the center of the window.
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
// Setting circleVX and circleVY to 7 (CIRCLE_SPEED)
  stroke(STROKE_COLOR);
// Seting stroke colour to the value of STROKE_COLOR (pink)
  fill(currentColor);
// Setting circle fill color to the value of NO_CLICK_FILL_COLOR (darker pink)
  background(BACKGROUND_COLOR);
// Seting stroke colour to the value of BACKGROUND_COLOR (pink)

buttonX1 = (width/2 - 25);
buttonY1 = (height - 50);
buttonX2 = (width/2 + 25);
buttonY2 = (height - 15);
}
//*CHANGED* Coordinates for the restart button

void draw() {
  if (dist(mouseX, mouseY, circleX, circleY) < currentCircleSize/2) {
    fill(CLICK_FILL_COLOR);
  }
// *CHANGED* CIRCLE_SIZE to currentCircleSize  
// If distance between the mouse pointer and the future circle center is less than 1/2 of the circle size 
// (i.e. if the pointer is inside the future circle) sets fill to the value of CLICK_FILL_COLOR (blue)
    else {
      if (mousePressed) {
        fill(currentColor);
      }
//*CHANGED* On pressing mouse button every new circle will be currentColor
      else {
      fill(NO_CLICK_FILL_COLOR);
      }  
// If the mouse pointer is outside the future circle, sets fill to the value of NO_CLICK_FILL_COLOR (darker pink)
  }
    
    ellipse(circleX, circleY, currentCircleSize, currentCircleSize);
// *CHANGED* CIRCLE_SIZE to currentCircleSize

  circleX += circleVX;
  circleY += circleVY;
  
  currentColor = currentColor + colorChange;
//*CHANGED* currentColor will change every new instance
 

// Draws the first circle at the starting position with the coordinates of circleX and circleY (middle of the screen) 
// and every next circle with the increment of circleVX on X-axis and circleVY on Y-axis (both are set to CIRCLE_SPEED which is 7)
// So every new circle will be drawn 7 pixels to the right and 7 pixels down.
  
  if ((circleX + currentCircleSize/2 > width) || (circleX - currentCircleSize/2 < 0)) {
    circleVX = -circleVX;
  }
// When the circle's right outermost point reaches the right margin of the window OR its left outermost point reaches the left margin of the window,
// the circle reverses its direction on th X-axis
// *CHANGED* CIRCLE_SIZE to currentCircleSize
  if (circleY + currentCircleSize/2 > height || circleY - currentCircleSize/2 < 0) {
    circleVY = -circleVY;
  }

// Same in vertical direction, when the circle reaches the top or the bottom of the window
// *CHANGED* CIRCLE_SIZE to currentCircleSize
    currentCircleSize = currentCircleSize + growth;
    if (currentCircleSize >= 100 || currentCircleSize <= 20) {
      growth = -growth;
    }
// *CHANGED* Every new circle is 0.1 bigger (growth variable) until the size reaches 100 then every new circle is 0.1 smaller until it reaches 20
  if (mouseX > buttonX1 && mouseY > buttonY1 && mouseX < buttonX2 && mouseY < buttonY2 && mousePressed) {
    restart = true;
  }
  else {
    restart = false;
  }
  if (restart) {
    background(BACKGROUND_COLOR);
  }
//*CHANGED* condition all previous instances of the circle will disappear only if the reset button pressed  
  fill(0);
  rectMode(CORNERS);
  rect(buttonX1,buttonY1,buttonX2,buttonY2);
  line(buttonX2,buttonY1,buttonX1,buttonY2);
  line(buttonX1,buttonY1,buttonX2,buttonY2);
//*CHANGED* the reset button

}

// void mousePressed() {
//  background(BACKGROUND_COLOR);
//}

void keyReleased() {
    circleVX = circleVX - speedChange;
    circleVY = circleVY + speedChange; 
    if (circleVX>25 || circleVX<-25 || circleVY>25 || circleVY<-25){
      speedChange=-speedChange;
    }
//*CHANGED* on key release speed (and trajectory) change 
}

// On pressing mouse button fill the background erasing previous istances of the circle

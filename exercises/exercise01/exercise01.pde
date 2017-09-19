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
// Declaring variables (presumably for the circle position and velocity)


void setup() {
  size(640, 480);
// Setting window size to 640 x 480px
  circleX = width/2;
  circleY = height/2;
// Setting the starting position of the circle to the middle of the window by assigning values to variables CircleX and circleY.
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
// Setting the circle velocity to 7 (CIRCLE_SPEED)
  stroke(STROKE_COLOR);
// Seting stroke colour to the value of STROKE_COLOR (pink)
  fill(NO_CLICK_FILL_COLOR);
// Setting circle fill color to the value of NO_CLICK_FILL_COLOR (darker pink)
  background(BACKGROUND_COLOR);
// Seting stroke colour to the value of BACKGROUND_COLOR (pink)
}

void draw() {
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
    fill(CLICK_FILL_COLOR);
  }
// If distance between the mouse pointer and the future circle center is less than 1/2 of the circle size 
// (i.e. if the pointer is inside the future circle) sets fill to the value of CLICK_FILL_COLOR (blue)
  else {
    fill(NO_CLICK_FILL_COLOR);
// If the mouse pointer is outside the future circle, sets fill to the value of NO_CLICK_FILL_COLOR (darker pink)
  }
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  circleX += circleVX;
  circleY += circleVY;
// Draws the first circle at the starting position with the coordinates of circleX and circleY (middle of the screen) 
// and every next circle with the increment of circleVX on X-axis and circleVY on Y-axis (both are set to CIRCLE_SPEED which is 7)
// So every new circle will be drawn 7 pixels to the right and 7 pixels down.
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
// When the circle's right outermost point reaches the right margin of the window OR its left outermost point reaches the left margin of the window,
// the circle reverses its direction on th X-axis
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
// Same in vertical direction, when the circle reaches the top or the bottom of the window
}

void mousePressed() {
  background(BACKGROUND_COLOR);
}

// On pressing mouse button fill the background erasing previous istances of the circle
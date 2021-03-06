//Main file that calls for bouncer object (twice) and a randomMover object
color backgroundColor = color(200,150,150);
//Declaring bouncer objects
Bouncer bouncer;
Bouncer bouncer2;
RandomMover randomMover;

//Setting up the background and initializing 2 instances of the bouncer with the help 
//of constructor with arguments to specify starting conditions for each instance
//(X- and Y-position, X- and Y-velocity, size, default colour and colour on hover). 
void setup() {
  size(640,480);
  background(backgroundColor);
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(150,0,0,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(0,0,150,50),color(0,0,255,50));
//*CHANGED* added a randomMover object that appears in random spot, moves in a random direction with random velocity.  
  randomMover = new RandomMover(floor (random(width)),floor (random(height)),floor(random(-5,5)),floor(random(-5,5)),5,0);
}

//Calling bouncer methods on the object to update and draw both instances of the bouncer
void draw() {
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
//*CHANGED* Calling a new method to check if the bouncer was clicked by the mouse
  bouncer.mouseClicked();
  bouncer2.mouseClicked();
  randomMover.update();
  randomMover.draw();
}
// Simple fishing game, where the good fish is to be caught with a hook, and the bad fish is to be avoided

// We'll be using one object from the Hero class
Hero hero;

// and an array of objects from the PrizeFish class
PrizeFish[] prizeFishes = new PrizeFish[10];
//PenaltyFish[] penaltyFishes = new PenaltyFish[3];

// An array of images for different fishes
PImage[] prizeFishPics = new PImage[6]; 
// and for the hero
PImage heroImg;

// Variable to store the information about the number of fishes caught for future score
int caught;

void setup() {
  size(1200, 800);
  
  // Load fish images
  prizeFishPics[0] = loadImage("img/fish01.png");
  prizeFishPics[1] = loadImage("img/fish02.png");
  prizeFishPics[2] = loadImage("img/fish03.png");
  prizeFishPics[3] = loadImage("img/fish04.png");
  prizeFishPics[4] = loadImage("img/fish05.png");
  prizeFishPics[5] = loadImage("img/fish06.png");
  
  // and hero image
  heroImg = loadImage("img/hook.png");

  // Create 10 (array length) instances of prizeFish objects
  for (int i = 0; i < prizeFishes.length; i++) {
    prizeFishes[i] = new PrizeFish(prizeFishPics[floor(random(0,5))], random(0 , width), random(0, height), floor(random(-9,9)), random(-1,1));
  }
  
  // Create an instance of hero
  hero = new Hero(heroImg, width/2, 0);
}

void draw() {
  background(211,247,244);
  
  // Looping throught the array of prizeFishes, update and display them.
  // Check if any was hooked 
  for (int i = 0; i < prizeFishes.length; i++) {
    prizeFishes[i].update();
    prizeFishes[i].display();
    prizeFishes[i].hooked(hero);
  }
  
  // Update and display hero
  hero.update();
  hero.display();
  // Call keyPressed() function to be able to control its movement
  hero.keyPressed();

}
// Simple fishing game, where the good fish is to be caught with a hook, and the bad fish is to be avoided

// We'll be using one object from the Hero class
Hero hero;
Stats stats;

// and an array of objects from the PrizeFish class
PrizeFish[] prizeFishes = new PrizeFish[10];
NastyFish[] nastyFishes = new NastyFish[2];

// An array of images for different nice fishes
PImage[] prizeFishPics = new PImage[6]; 
// an image for evil fishes
PImage nastyFishPic;
// and for the hero
PImage heroImg;

int inset = 10;

// Variable to store the information about the number of fishes caught
int caught;

// Variable to store the information about the bites from a nasty fish
int bitten;

void setup() {
  size(1200, 800);
  
  // Load good fish images
  prizeFishPics[0] = loadImage("img/fish01.png");
  prizeFishPics[1] = loadImage("img/fish02.png");
  prizeFishPics[2] = loadImage("img/fish03.png");
  prizeFishPics[3] = loadImage("img/fish04.png");
  prizeFishPics[4] = loadImage("img/fish05.png");
  prizeFishPics[5] = loadImage("img/fish06.png");
  
  // evil fish image
  nastyFishPic = loadImage("img/nasty_fish.png");
  
  // and hero image
  heroImg = loadImage("img/hook.png");

  // Create 10 (array length) instances of prizeFish objects
  for (int i = 0; i < prizeFishes.length; i++) {
    prizeFishes[i] = new PrizeFish(prizeFishPics[floor(random(0,6))], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1));
  }
  
  // Create 2 instances of nastyFish objects
  for (int i = 0; i < nastyFishes.length; i++) {
    nastyFishes[i] = new NastyFish(nastyFishPic, random(0, width), random(inset, height - inset));
  }
  
  // Create an instance of hero
  hero = new Hero(heroImg, width/2, 0);
  stats = new Stats();
}

void draw() {
  background(211,247,244);
  
  // Update and display hero
  hero.update();
  hero.display();
  // Call keyPressed() function to be able to control its movement
  hero.keyPressed();
  
  // Looping throught the array of prizeFishes, update and display them.
  // Check if any was hooked 
  for (int i = 0; i < prizeFishes.length; i++) {
    prizeFishes[i].update();
    prizeFishes[i].display();
    prizeFishes[i].hooked(hero);
  }
  
  for (int i = 0; i < nastyFishes.length; i++) {
    nastyFishes[i].update();
    nastyFishes[i].display();
    nastyFishes[i].hooked(hero);
  }
  
  // Update and display stats
  stats.update();
  stats.display();

}
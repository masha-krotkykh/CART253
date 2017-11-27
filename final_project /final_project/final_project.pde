
// Simple fishing game, where the good fish is to be caught with a hook, and the bad fish is to be avoided
// The game is against the time and all 10 good fishes need to be caught within 1 minute

// import Minim library for sound
import ddf.minim.*;
Minim minim;
// Declare some audio 
AudioPlayer[] tones;
AudioPlayer backgroundSound;
AudioPlayer hookedSound;
AudioPlayer caughtSound;
AudioPlayer penaltySound;

// We'll be using one object from the Hero class
Hero hero;
// And an instance of stats
Stats stats;

// and an array of objects from the PrizeFish class
ArrayList prizeFishes = new ArrayList();
NastyFish[] nastyFishes = new NastyFish[3];
Bubble[] bubbles = new Bubble[1000];

// An array of images for different nice fishes
PImage[] prizeFishPics = new PImage[10]; 
// an image for evil fishes
PImage nastyFishPic;
// and for the hero
PImage heroImg;
// and for the background
PImage backgroundImage;
// Inset value so that fish doesn't get lost outside the window
int inset = 10;

// Variable to store the information about the number of fishes caught
int caught;

//// Variable to store the information about the bites from a nasty fish
//int bitten;


void setup() {
  size(1200, 800);
  
  minim = new Minim(this);
  //Load all sound files
  backgroundSound = minim.loadFile("sound/theme.wav");
  caughtSound = minim.loadFile("sound/caught.wav");
  penaltySound = minim.loadFile("sound/penalty.wav");

  
  // Load good fish images
  prizeFishPics[0] = loadImage("img/fish01.png");
  prizeFishPics[1] = loadImage("img/fish02.png");
  prizeFishPics[2] = loadImage("img/fish03.png");
  prizeFishPics[3] = loadImage("img/fish04.png");
  prizeFishPics[4] = loadImage("img/fish05.png");
  prizeFishPics[5] = loadImage("img/fish06.png");
  prizeFishPics[6] = loadImage("img/fish07.png");
  prizeFishPics[7] = loadImage("img/fish08.png");
  prizeFishPics[8] = loadImage("img/fish09.png");
  prizeFishPics[9] = loadImage("img/fish10.png");
  
  // evil fish image
  nastyFishPic = loadImage("img/nasty_fish.png");
  
  // and hero image
  heroImg = loadImage("img/hook.png");
  
  // and background
  backgroundImage = loadImage("img/bg.jpg");

  // Create 10  instances of prizeFish objects
  prizeFishes.add(new PrizeFish(prizeFishPics[0], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[1], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[2], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[3], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[4], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[5], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[6], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[7], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[8], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[9], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));

  // Create 2 instances of nastyFish objects
  for (int n = 0; n < nastyFishes.length; n++) {
    nastyFishes[n] = new NastyFish(nastyFishPic, floor(random(0, width)), floor(random(inset, height - inset)));
  }
  
  // Create bubbles
  for (int b = 0; b < bubbles.length; b++) {
    bubbles[b] = new Bubble(random(0,width), height, int(random(2,80)), random(-15,2),random(-3,3));
  }
  
  
  // Create an instance of hero
  hero = new Hero(heroImg, width/2, 0);
  stats = new Stats();
}

void draw() {
  background(backgroundImage);
  
  // Play background sound
  backgroundSound.play();
  
  // Update and display hero
  hero.update();
  hero.display();
  // Call keyPressed() function to be able to control its movement
  hero.keyPressed();
  
  // Looping throught the array of prizeFishes, update and display them.
  // Check if any was hooked 
  for (int i = 0; i < prizeFishes.size(); i++) {
    PrizeFish prizeFish = (PrizeFish)prizeFishes.get(i);
    prizeFish.update();
    prizeFish.collide(hero);
    prizeFish.display();
    prizeFish.hooked();
  }

  for (int n = 0; n < nastyFishes.length; n++) {
    nastyFishes[n].update();
    nastyFishes[n].display();
    nastyFishes[n].collide(hero);
    nastyFishes[n].hooked();
  }
  
  // Check if nasty fish collides with hero and, if so, bring on the bubbles    
  for (int b = 0; b < bubbles.length; b++) {
    for (int n = 0; n < nastyFishes.length; n++) {
      if (nastyFishes[n].collide(hero) == true) { 
        
        // Has to play sound when a nasty fish is hooked....
        bubbles[b].update();
        bubbles[b].display();
      }  
    }
  }

  
  // Update and display stats
  stats.update();
  stats.checkQuantity();
  stats.display();
}
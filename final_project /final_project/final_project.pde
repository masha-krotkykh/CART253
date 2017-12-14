// Simple fishing game, where the good fish is to be caught with a hook, and the bad fish is to be avoided

// ARTIST'S STATEMENT
// In this project I was trying to explore as many topics covered during the course as possible (where it was appropriate). 
// Although the game is fairly simple, I am quite pleased with the result since I've managed to make things work exactly the way I wanted them to. 
// Using array lists helped me a great deal to make the right fish disappear from the game at the right time. 
// I also revisited the append() function for the arrays to add new instances of sea horses to the game with each new level. 
// Although I must admit that I still don't completely understand the logic of a for loop, I have learned to implement it sensibly and functionally so it works the way it has to.
// Also I was able to implement rotation both for flipping images of fishes when their velocity is negative (instead of replacing the images each time like I did in my midterm), 
// and for the background using theta rotation.
// I explored microphone input to be able to "scare" the fish, so now when the noise level is too high, my fishes start swimming much faster for a certain period of time. 
// Artistically I was excited about exploring the clash of victorian aesthetics with gaming environment which, in my, opinion, worked nicely. 
// Usually when games are stylized to look like they are set in Victorian epoch, they still look pretty modern. 
// In this case illustrations were used, modified and collaged to give the game look of a vintage product label. 
// It is nice to know that new technology doesn't necessarily deny any artistic standards that are sometimes believed to be extinct but, on the contrary, helps to preserve, adapt, and enhance them in a completely new way.
// I chose this subject because I generally find fishing very relaxing. 
// In this case though I tried to make it as stressful as possible: the game is against the clock and there are several obstacles 
// (like nasty fishes the slow the hero's movement and the sea horses that try to "save" hooked fishes) and difficulty level increases on each stage (fish moves faster, number of sea horses increases and their speed as well).
// There are three possible options to end the game: total victory - with all fishes caught, "sorta victory" - when the score is 100 or above and defeat - when the score is below 100.
// Every level fish brings the player more points (10 in level 1, 20 in level 2, and 30 in level 3) but it is also more difficult to play each next level, so it's up to the player to choose the strategy. 
// For me personally the most interesting part of the project was actually seeing the progress since the beginning of the course. Being able to piece together most topics covered in class and implementing them 
// to write from scratch a functioning thing is an awesome feeling.

// import Minim library for sound
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioInput mic;

// Declare some audio 
AudioPlayer[] tones;
AudioPlayer caughtSound;
AudioPlayer penaltySound;
AudioPlayer backgroundSound;

// We'll be using one object from the Hero class
Hero hero;
// And an instance of stats
Stats stats;

// and an array list of objects from the PrizeFish class
ArrayList prizeFishes = new ArrayList();

// arrays for objects from NastyFish, Bubbles and SeaHorse classes
NastyFish[] nastyFishes = new NastyFish[3];
Bubble[] bubbles = new Bubble[1000];
SeaHorse[] seaHorses = new SeaHorse[1];

// An array of images for different nice fishes
PImage[] prizeFishPics = new PImage[12]; 
// an image for evil fishes
PImage nastyFishPic;
// for sea horse
PImage seaHorsePic;
// and for the hero
PImage heroImg;
// and for the backgrounds
PImage sunburst;
PImage backgroundImage;
PImage startImage;
PImage endImage;
PImage loseImage;
PImage winImage;
PImage superwinImage;
  
// Inset value so that fish doesn't get lost outside the window
int inset = 10;

// Variable to store the information about the number of fishes caught
int caught;
boolean horseAttack = false;

// Variable to define the stage of the game 
int gameState = 0;

boolean newLevel = false;

boolean timerRunning = false;

void setup() {
  size(1200, 800);
  // Get minim
  minim = new Minim(this);
  
  // Get the mic
  mic = minim.getLineIn();
  
  //Load all sound files
  caughtSound = minim.loadFile("sound/caught.wav");
  penaltySound = minim.loadFile("sound/penalty.wav");
  backgroundSound = minim.loadFile("sound/theme.wav");
  // Play background sound
  backgroundSound.loop();


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
  prizeFishPics[10] = loadImage("img/fish11.png");
  prizeFishPics[11] = loadImage("img/fish12.png");
  
  // evil fish image
  nastyFishPic = loadImage("img/nasty_fish.png");
  
  // sea horse image
  seaHorsePic = loadImage("img/seahorse.png");
  
  // hero image
  heroImg = loadImage("img/hook.png");
  
  // and all background images
  sunburst = loadImage("img/sunburst.jpg");
  backgroundImage = loadImage("img/bg.jpg");
  startImage = loadImage("img/start.jpg");
  endImage = loadImage("img/end.png");
  loseImage = loadImage("img/lose.png");
  winImage = loadImage("img/win.png");
  superwinImage = loadImage("img/superwin.png");


  // Create 12  instances of prizeFish objects
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
  prizeFishes.add(new PrizeFish(prizeFishPics[10], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));
  prizeFishes.add(new PrizeFish(prizeFishPics[11], random(0, width), random(inset, height - inset), floor(random(-9,9)), random(-1,1)));

  // Create 3 instances of nastyFish objects
  for (int n = 0; n < nastyFishes.length; n++) {
    nastyFishes[n] = new NastyFish(nastyFishPic, floor(random(0, width)), floor(random(inset, height - inset)));
  }
  
  // Create some sea horses
  // One for now. New ones will be created with each new level via Stats class 
  for (int h = 0; h < 1; h++) {
    seaHorses[h] = new SeaHorse(seaHorsePic, floor(random(0, width)), floor(random(0, height)), 2, 0.025);
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
  // Display the current screen according to the game stage
  // startScreen displays before the game begins and until the mouse is clicked
  if(gameState == 0) {
    stats.startScreen();
    timerRunning = false;
  }

  // endScreen displays when the game ends until the mouse is clicked
  else if(gameState == 2) {
    stats.endScreen();
  }
  
  else if(gameState == 4) {
    stats.winScreen();
  }
  
  else if(gameState == 5) {
    stats.superWinScreen();
  }
  
  else if(gameState == 3) {
    stats.loseScreen();
  }
  
  // gameScreen is the stage where the game executes
  else {
    gameScreen();
  }
}

// All game code is now inside gameScreen() function so it only gets called when the mouse is clicked from
// the startScreen or the endScreen
void gameScreen() {
  // Display background image  
  background(backgroundImage);
    
  timerRunning = true;
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
    if (!hero.onHook) prizeFish.collide(hero);
    prizeFish.hooked();
    prizeFish.display();
    
  }

  for (int n = 0; n < nastyFishes.length; n++) {
    nastyFishes[n].update();
    nastyFishes[n].display();
    nastyFishes[n].collide(hero);
    nastyFishes[n].hooked();
  }
  
  for (int h = 0; h < seaHorses.length; h++) {
    seaHorses[h].update();
    seaHorses[h].collide(hero);  
    seaHorses[h].display();
  }
  
  // Check if nasty fish collides with hero and, if so, bring on the bubbles    
  for (int b = 0; b < bubbles.length; b++) {
    for (int n = 0; n < nastyFishes.length; n++) {
      if (nastyFishes[n].collide(hero) == true) {        
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

  // Resets timer before new level starts and add one more sea horse that moves quicker to make things harder
  void reset() {  
    stats.countDown = 60;
    stats.startTime = millis();
    stats.levelCounter = stats.levelCounter + 1;
    
        for (int h = 0; h < 1; h++) {
      seaHorses = (SeaHorse[]) append(seaHorses, new SeaHorse(seaHorsePic, floor(random(0, width)), floor(random(0, height)), random(0,8), 0.015 * stats.levelCounter));
    }
  }

// When any key is pressed the new game starts.
void keyPressed() {
  if((keyCode != UP && keyCode != DOWN && keyCode != RIGHT && keyCode != LEFT) && (gameState == 0 || gameState == 2))  {
    if(gameState == 2) {
      reset();
    }
    gameState = 1;
    stats.startTime = millis();
  }
}

Hero hero;

PrizeFish[] prizeFishes = new PrizeFish[10];
//PenaltyFish[] penaltyFishes = new PenaltyFish[3];

PImage[] prizeFishPics = new PImage[2]; 

void setup() {
  size(1200, 800);
  
  prizeFishPics[0] = loadImage("clown_fish.png");
  prizeFishPics[1] = loadImage("yellow_fish.png");

  
  for (int i = 0; i < prizeFishes.length; i++) {
    prizeFishes[i] = new PrizeFish(prizeFishPics[floor(random(0,2))], random(0 , width), random(0, height), floor(random(-9,9)), random(-1,1));
  }
  
  hero = new Hero(width/2, 0);
}

void draw() {
  background(0);
  for (int i = 0; i < prizeFishes.length; i++) {
    prizeFishes[i].update();
    prizeFishes[i].display();
  }
  
  hero.update();
  hero.display();
  hero.controlls();
}
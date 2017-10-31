// Fishbowl with a pet octopus and different fishes for him to enjoy.
// 1 pet octopus, some yellow, blue, and clown fishes,
// starting score is 0
int score = 0;

Octie octie;


// Create ArrayLists for each class
ArrayList blueFishes = new ArrayList();
ArrayList randomFishes = new ArrayList();
ArrayList jellyfishes = new ArrayList();

// Add an array for fish images
PImage[] fishPics = new PImage[2]; 

// Add a timer that counts down from 100 to 0
boolean timerRunning = false;
int startTime = 0;
int timeElapsed;
int countDown = 100;

void setup() {
  size(500,500);
  
  fishPics[0] = loadImage("clown_fish.png");
  fishPics[1] = loadImage("yellow_fish.png");
  // Add objects to the ArrayLists (4 yellow fishes, 4 clown fishes)
  randomFishes.add(new RandomFish(fishPics[0], 0, 50, 3));
  randomFishes.add(new RandomFish(fishPics[0], width/2, 250, 5));
  randomFishes.add(new RandomFish(fishPics[0], width, 400, 1));
  randomFishes.add(new RandomFish(fishPics[0], 0, 100, 5));
  randomFishes.add(new RandomFish(fishPics[1], 0, 150, 2));
  randomFishes.add(new RandomFish(fishPics[1], width/2, height - 30, 7));
  randomFishes.add(new RandomFish(fishPics[1], 0, 200, 3));
  randomFishes.add(new RandomFish(fishPics[1], 0, 500, 9));
  // Add 2 blue fishes
  blueFishes.add(new BlueFish(width, 70, 7));
  blueFishes.add(new BlueFish(0, 120, 2.5));
  // Add 2 jellyfishes
  jellyfishes.add(new Jellyfish(width/3, 20));
  jellyfishes.add(new Jellyfish(width/3 * 2, height/2));
  // Add a character
  octie = new Octie(width/2, height/2); 
}


void draw() {
  background(123,204,209);
  
  // When the timer is running (after being stung by a jellyfish) 
  // it counts down to 0 and the score drops (until a blue fish is caught).
  if (timerRunning) {
    timeElapsed = (millis() - startTime) / 1000;
    countDown = 100 - timeElapsed;
    score --;
  }
  // Display timer and scores
  text("Time left: " + countDown, width/4 * 3, 50);
  text("Your score: " + floor(score/10), 50, 50);
  
  // Update and display Octie
  octie.update();  
  octie.display();
  
  // Looping through random fishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int r = 0; r < randomFishes.size(); r++) {
    RandomFish randomFish = (RandomFish)randomFishes.get(r);
    randomFish.update();
    randomFish.display();
    randomFish.collide(octie);
    // The score goes up upon every collision with a random fish by a random number 10-100
    score += randomFish.collision * floor(random(10,100));
    randomFish.collision = 0;
  }
  
  // Looping through blue fishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int b = 0; b < blueFishes.size(); b++) {
    BlueFish blueFish = (BlueFish)blueFishes.get(b);
    blueFish.update();
    blueFish.display();
    blueFish.collide(octie);
    // The score goes up upon every collision with a blue fish by 500
    score += blueFish.collision * 100;
    blueFish.collision = 0;
  }
  
  // Looping through jellyfishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int j = 0; j < jellyfishes.size(); j++) {
    Jellyfish jellyfish = (Jellyfish)jellyfishes.get(j);
    jellyfish.update();
    jellyfish.display();
    jellyfish.collide(octie);
  }
  
  //score = (randomFish.collide * floor(random(1,5))) + (blueFish.collide * 100);
  
  // If the timer reaches 0 the game ends and the player looses
  if (countDown <= 0) {
    background(0); 
    timerRunning = false;
    textAlign(CENTER);
    text("You loose", width/2, height/2);
  }
  
  // If the timer reaches 0 the game ends and the player wins  
  if (score >=  5000) {
    background(0); 
    timerRunning = false;
    textAlign(CENTER);
    text("You win!", width/2, height/2);
  }
}


void keyPressed() {
  octie.keyPressed();
}
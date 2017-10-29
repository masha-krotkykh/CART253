// Fishbowl with a pet octopus and different fishes for him to enjoy.
// 1 pet octopus, some yellow, blue, and clown fishes,
// starting score is 0
int score = 0;

Octie octie;

// Create ArrayLists for each class
ArrayList yellowFishes = new ArrayList();
ArrayList clownFishes = new ArrayList();
ArrayList blueFishes = new ArrayList();
ArrayList jellyfishes = new ArrayList();

// Add a timer that counts down from 20 to 0
boolean timerRunning = false;
int startTime = 0;
int timeElapsed;
int countDown = 20;

void setup() {
  size(500,500);
  
  // Add objects to the ArrayLists (3 yellow fishes, 4 clown fishes, 2 blue fishes)
  yellowFishes.add(new YellowFish(0,50,3));
  yellowFishes.add(new YellowFish(width, 200,1));
  yellowFishes.add(new YellowFish(0, 300,5));
  clownFishes.add(new ClownFish(width, 20));
  clownFishes.add(new ClownFish(0, 120));
  clownFishes.add(new ClownFish(0, 200));
  clownFishes.add(new ClownFish(width, 400));
  blueFishes.add(new BlueFish(width, 70, 2.5));
  blueFishes.add(new BlueFish(0, 120, 1.5));
  jellyfishes.add(new Jellyfish(width/3, 20));
  jellyfishes.add(new Jellyfish(width/3 * 2, height/2));
  octie = new Octie(width/2, height/2); 
}


void draw() {
  background(123,204,209);
  
  // When the timer is running (after being stung by a jellyfish) 
  // it counts down to 0 and the score drops (until a blue fish is caught).
  if (timerRunning) {
    timeElapsed = (millis() - startTime) / 1000;
    countDown = 20 - timeElapsed;
    score --;
  }
  // Display timer and scores
  text("Time left: " + countDown, width/4 * 3, 50);
  text("Your score: " + score, 50, 50);
  
  // Update and display Octie
  octie.update();  
  octie.display();
  
  // Looping through yellow fishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int i = 0; i < yellowFishes.size(); i++) {
    YellowFish yellowFish = (YellowFish)yellowFishes.get(i);
    yellowFish.update();
    yellowFish.display();
    yellowFish.collide(octie);
  }

  // Looping through clown fishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int c = 0; c < clownFishes.size(); c++) {
    ClownFish clownFish = (ClownFish)clownFishes.get(c);
    clownFish.update();
    clownFish.display();
    clownFish.collide(octie);
  }
  
  // Looping through blue fishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int b = 0; b < blueFishes.size(); b++) {
    BlueFish blueFish = (BlueFish)blueFishes.get(b);
    blueFish.update();
    blueFish.display();
    blueFish.collide(octie);
  }
  
  // Looping through jellyfishes array list and updating and displaying them, 
  // checking for collisions with Octie
  for (int j = 0; j < jellyfishes.size(); j++) {
    Jellyfish jellyfish = (Jellyfish)jellyfishes.get(j);
    jellyfish.update();
    jellyfish.display();
    jellyfish.collide(octie);
  }
  
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
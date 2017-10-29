// Fishbowl with a pet octopus and different fishes for him to enjoy.
// 1 pet octopus, some yellow, blue, and clown fishes,
// starting score is 0
int score = 0;

Octie octie;

// Create ArrayLists for each class
ArrayList yellowFishes = new ArrayList();
ArrayList clownFishes = new ArrayList();
ArrayList blueFishes = new ArrayList();

void setup() {
  size(500,500);
  
  // Add objects to the ArrayLists (3 yellow fishes, 4 clown fishes, 2 blue fishes)
  yellowFishes.add(new YellowFish(0,50));
  yellowFishes.add(new YellowFish(width, 200));
  yellowFishes.add(new YellowFish(0, 300));
  clownFishes.add(new ClownFish(width, 20));
  clownFishes.add(new ClownFish(0, 120));
  clownFishes.add(new ClownFish(0, 200));
  clownFishes.add(new ClownFish(width, 400));
  blueFishes.add(new BlueFish(width, 70));
  blueFishes.add(new BlueFish(0, 120));
  octie = new Octie(width/2, height/2); 
}


void draw() {
  background(123,204,209);
  
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

  println(clownFishes.size());
}

void keyPressed() {
  octie.keyPressed();
}
// Fishbowl with a pet octopus and different fishes for him to enjoy.
// 1 pet octopus, 2 yellow fishes,
// starting score is 0
Octie octie;
YellowFish yellowFish;
YellowFish yellowFish2;
int score = 0;

// Putting two fishes on the either side of the bowl and Octie in the center
void setup() {
  size(500,500);
  yellowFish = new YellowFish(0,50);
  yellowFish2 = new YellowFish(width, 200);
  octie = new Octie(width/2, height/2); 
}

void draw() {
  background(123,204,209);
  octie.update();  
  yellowFish.update();
  yellowFish2.update();
  octie.display();
  yellowFish.display();
  yellowFish2.display();
  
 // Calculating the score 
  int yellowScore = yellowFish.score * 2;
  //int blueScore = blueFish.score * 5;
  //int clownScore = clownFish.score;
  //int jellyScore = jellyFish.score * -10;
  score = yellowScore; //+ blueScore + clownScore + jellyScore;
}

// Calling keyPressed function to check if tthe key has been pressed
void keyPressed() {
  octie.keyPressed();
}
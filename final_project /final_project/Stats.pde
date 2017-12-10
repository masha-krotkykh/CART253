// Class for displaying score and timer

class Stats {
  int x = 0;
  int y = 0;
  int statsWidth = width;
  int statsHeight = 70;
  int timeLeft;
  int fishToCatch = 10;
  int fishLeft;
  String units;
  boolean timerRunning = true;


 
  // Check if there is more than 1 fish left to catch to display units properly in singular or plural
  String checkQuantity() {
    if (fishLeft == 1) {
       units = " fish";
    }
    else {
      units = " fishes";
    }
    return units;
  }
  
  
  // Add a timer that counts down from 60 to 0

  int startTime = 0;
  int timeElapsed;
  int countDown = 60;
  
 // Displaying how many fishes need to be caught 
  void update() {
    fishLeft = fishToCatch - caught;
      
    if (timerRunning) {
      timeElapsed = (millis() - startTime) / 1000;
      countDown = 60 - timeElapsed;
    }
    
    if(countDown <= 0 || caught >= 10) {
      gameState = 2;
      timerRunning = false;
    }
  }
  
  // Display the stats
  void display() {
    rectMode(CORNER);
    noStroke();
        fill(255,255,255,150);
        rect(x, y, statsWidth, statsHeight);
        fill(25,25,25);
        textSize(25);
        textAlign(LEFT);
        text("You need " + fishLeft + " more" + units, 30, statsHeight / 1.5 );
        text("Time left: " + countDown, width/6 * 5, statsHeight / 1.5);
  }
  
  
  // startScreen before the game begins
  void startScreen() {
    background(startImage);
  }

  // EndScreen when the game ends. 
  void endScreen() {
    background(0);
    textAlign(CENTER);
    text("EVERYONE'S A LOSER", width/2, height/2);
  }

  // Resets scores and timer before new game starts
  void reset() {  
    countDown = 60;
    startTime = millis();
    caught = 0;
  }
}
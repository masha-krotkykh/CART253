// Class for displaying score and timer

class Stats {
  int x = 0;
  int y = 0;
  int statsWidth = width;
  int statsHeight = 70;
  int timeLeft;
  int fishToCatch = 12;
  String units;
  boolean timerRunning = true;
  int levelCounter = 1;
  int fishLeft = fishToCatch - caught;
  int nextLevel;
  // Gets updated fromPrizeFish class every time a fish is caught depending on the level
  int score;

  
  // Check if there is more than 1 fish caught to display units properly in singular or plural
  String checkQuantity() {
    if (caught == 1) {
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
  
  void update() {
      
    if (timerRunning) {
      timeElapsed = (millis() - startTime) / 1000;
      countDown = 60 - timeElapsed;
    }
    
    if(countDown <= 0) {
      gameState = 2;
      timerRunning = false;
    }
    
    if((levelCounter == 3 && countDown <= 0) || fishLeft <= 0) {
      if(score < 100) {
        gameState = 3;
      }
      else if(fishLeft <= 0) {
        gameState = 5;
      }
      else {
        gameState = 4;
      }
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
    text("You've caught " + caught + units, 30, statsHeight / 1.5 );
    text("Time left: " + countDown, width/6 * 5, statsHeight / 1.5);
    textAlign(CENTER);
     text("Your score is " + score, width/2, statsHeight / 1.5 );
          println(levelCounter);
  }
 
  
  // startScreen before the game begins
  void startScreen() {
    background(startImage);
  }

  // EndScreen when the level ends. 
  void endScreen() {
    background(endImage);
    nextLevel = levelCounter + 1;
    textAlign(CENTER);
    text("Current score is " + score, width/3, height/1.7); 
    text("Start Level " + nextLevel, width/3, height/1.5);
  }
  void winScreen() {
    text("Yay, you've won!", width/2, height/2);  
  }
  
  void superWinScreen() {
    text("Yay, you've won a lot!", width/2, height/2);  
  }
  
  void loseScreen() {
    background(loseImage);  
  }

  // Resets timer before new level starts and add one more sea horse to make things harder
  void reset() {  
    countDown = 60;
    startTime = millis();
    levelCounter = levelCounter + 1;
        for (int h = 0; h < 1; h++) {
      seaHorses = (SeaHorse[]) append(seaHorses, new SeaHorse(seaHorsePic, floor(random(0, width)), floor(random(0, height))));
    }
  }
}
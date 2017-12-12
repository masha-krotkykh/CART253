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
  float theta = 0;

  
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
  
  
  // Add a timer that counts down from 30 to 0
  int startTime = 0;
  int timeElapsed;
  int countDown = 30;
  
  void update() {
   // Timer   
    if (timerRunning) {
      timeElapsed = (millis() - startTime) / 1000;
      countDown = 30 - timeElapsed;
    }  
    
    // When timer gets to 0 level ends and the end screen appears. 
    // Timer stops
    if(countDown <= 0) {
      gameState = 2;
      timerRunning = false;
    }
    
    // After levl 3 ends check if the player lose or win
    // If the score is below 100 player lost and the game state is 3 (lose state)
    if(levelCounter == 3 && countDown <= 0) {
      if(score < 100) {
        gameState = 3;
      }
      
      // If all the fish is caught, player won and the game state is 5 (super win)
      else if(score >= 100 && fishToCatch <= caught) {
        gameState = 5;
      }
      
      // If the player scored at least 100 points, he sort of won and the game state is 4 (win state)
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
  }
 
  
  // startScreen before the game begins
  void startScreen() {
    background(startImage);
  }

  // EndScreen when the level ends. 
  void endScreen() {
    // Make a spinning starburst in the background
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(theta);
    imageMode(CENTER);
    image(sunburst,0,0);
    theta += 0.01;
    popMatrix();
    // and add an image
    image(endImage, width / 2, height / 2);
    // and text with current score and level 
    nextLevel = levelCounter + 1;
    textAlign(CENTER);
    text("Current score is " + score, width / 3, height /1.7); 
    text("Start Level " + nextLevel, width / 3, height /1.5);
  }
  
  // Screen for when player wins but not too much (is over 100 points but didn't catch all the fish)
  void winScreen() {
    // Make a spinning starburst in the background
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(theta);
    imageMode(CENTER);
    image(sunburst, 0, 0);
    theta += 0.01;
    popMatrix();
    // Add an image 
    image(winImage, width / 2, height / 2);
    // and text with total game score
    textAlign(CENTER);
    text("Your total score is " + score, width / 1.2, height / 4); 
  }
  
  // Screen for when player wins everything
  void superWinScreen() {
    // Make a spinning starburst in the background
    pushMatrix();
    translate(width / 2, height  /2);
    rotate(theta);
    imageMode(CENTER);
    image(sunburst, 0, 0);
    theta += 0.01;
    popMatrix();
    // Add an image
    image(superwinImage, width / 2, height / 2);  
  }
  
  // Screen for when player scores less than 100 points total after 3 levels
  void loseScreen() {
    // Make a spinning starburst in the background
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(theta);
    imageMode(CENTER);
    image(sunburst, 0, 0);
    theta += 0.01;
    popMatrix();
    // Add an image
    image(loseImage, width / 2, height / 2);
  }
}
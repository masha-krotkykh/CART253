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
  }
  
  // Display the stats
  void display() {
    rectMode(CORNER);
    noStroke();

    // When the time runs out the player loses
    if (countDown <= 0) {
      timerRunning = false;
      textAlign(CENTER);
      fill(255,0,0);
      text("YOU LOOSE", width/2, height/2); 
     }
     
     // Whan all the fish is caught the player wins
     else if (fishLeft <= 0) {
       timerRunning = false;
       textAlign(CENTER);
       fill(255,0,0);
       text("YOU WON", width/2, height/2); 
     }
     else {
        fill(255,255,255,150);
        rect(x, y, statsWidth, statsHeight);
        fill(25,25,25);
        textSize(25);
        text("You need " + fishLeft + " more" + units, 30, statsHeight / 1.5 );
        text("Time left: " + countDown, width/6 * 5, statsHeight / 1.5);
     }  
  }
}
class Stats {
  int x = 0;
  int y = 0;
  int statsWidth = width;
  int statsHeight = 70;
  int timeLeft;
  int fishToCatch = 10;
  int fishLeft;
  
  void update() {
    fishLeft = fishToCatch - caught;
  }
  
  void display() {
    rectMode(CORNER);
    noStroke();
    fill(255,255,255,150);
    rect(x, y, statsWidth, statsHeight);
    
    fill(25,25,25);
    textSize(25);
    textAlign(LEFT);
    text("You need " + fishLeft + " more fishes", 20, statsHeight / 1.5 );
  }
}
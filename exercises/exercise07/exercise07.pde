// A simple program with 7 balls that will make sound while bouncing of the bottom or top of the window

// import a sound library
import ddf.minim.*;

Minim minim;

// Declare an array of tones
AudioPlayer[] tones;

//An array of 7 ball objects
Ball[] balls = new Ball[7];

//Set up all the balls with most of their parameters depending on their index in the array
void setup() {
  size(800,770);
  
  minim = new Minim(this);
 
  //Load all sound files
  tones = new AudioPlayer[7];
  tones[0] = minim.loadFile("00.wav");
  tones[1] = minim.loadFile("01.wav");
  tones[2] = minim.loadFile("02.wav");
  tones[3] = minim.loadFile("03.wav");
  tones[4] = minim.loadFile("04.wav");
  tones[5] = minim.loadFile("05.wav");
  tones[6] = minim.loadFile("06.wav");
  
 //Construct ball objects and attribute an individual sound to each of them 
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(((i+1) * width/8), 40, 0, 80, color(255 - i*20,0,0 + i * 20), "0" + 1 + ".wav");
  }
}

// Loop throught the array to update(), display() the balls and call the played() and stop() function 
// in case if a ball is being clicked in
void draw() {
  background(0);
  for (int i = 0; i < balls.length; i++) {
    balls[i].update();
    balls[i].display();
    balls[i].played();
    // if bounced() in Ball class returns true, than the correspondant tone plays and rewinds to start
    if(balls[i].bounced()) {
      tones[i].play();
      tones[i].rewind();
    }
    balls[i].stopped();
  }  
}


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
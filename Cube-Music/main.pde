import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;

// Variables that define the "zones" of the spectrum
// For example, for bass, we only take the first 4% of the total spectrum
float specLow = 0.03; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.20;   // 20%

// So there remains 64% of the possible spectrum which will not be used.
// These values are generally too high for the human ear anyway.

// Score values for each area
float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

// Previous values, to soften the reduction
float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;

// Softening value
float scoreDecreaseRate = 25;

// Cubes that appear in space
int nbCubes;
Cube[] cubes;

//Lines that appear on the sides
int nbWalls = 500;
Wall[] walls;

show_info music_info;

// // album
// Cover cover;
PImage bg; //<>// //<>// //<>// //<>//

void setup()
{
  //size(800, 800, P3D); //<>// //<>// //<>//
  fullScreen(P3D);

  minim = new Minim(this);

  song = minim.loadFile("gravity.mp3");
  // FFT to analysis sound
  fft = new FFT(song.bufferSize(), song.sampleRate());

  //One cube per frequency band
  nbCubes = (int)(fft.specSize()*specHi);
  cubes = new Cube[nbCubes];

  // println(song.bufferSize(), fft.specSize());
  //As many walls as you want
  walls = new Wall[nbWalls];


  for (int i = 0; i < nbCubes; i++) {
    cubes[i] = new Cube();
  }

  //Create wall objects
  //Left walls
  for (int i = 0; i < nbWalls; i+=4) {
    walls[i] = new Wall(0, height/2, 10, height);
  }

  //Straight walls
  for (int i = 1; i < nbWalls; i+=4) {
    walls[i] = new Wall(width, height/2, 10, height);
  }

  //low walls
  for (int i = 2; i < nbWalls; i+=4) {
    walls[i] = new Wall(width/2, height, width, 10);
  }

  //High walls
  for (int i = 3; i < nbWalls; i+=4) {
    walls[i] = new Wall(width/2, 0, width, 10);
  }

  //Black background
  bg = loadImage("pexels-evie-shaffer-4004374.jpg");
  background(bg);
  //
  music_info = new show_info("Where Is the Love - Josh Vietti");

  // cover = new Cover("whereisthelove.png");
  //<>// //<>// //<>// //<>//

  //Start the song
  song.play(0);
}

void draw()
{
  //Advance the song. We draw() for each "frame" of the song... //<>// //<>// //<>// //<>// //<>//
  fft.forward(song.mix);

  //Calculate "scores" (power) for three sound categories
  //First save the old values
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;

  //Réinitialiser les valeurs
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;

  //Calculate the new "scores"
  for (int i = 0; i < fft.specSize()*specLow; i++)
  {
    scoreLow += fft.getBand(i);
  }

  for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
  {
    scoreMid += fft.getBand(i);
  }

  for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
  {
    scoreHi += fft.getBand(i);
  }

  //Slow down the descent.
  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }

  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }

  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }

  //Volume for all frequencies at this time, with higher sounds more prominent.
  //This makes the animation go faster for higher pitched sounds, which are more noticeable
  float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;

  //Subtle background color
  // background(scoreLow/100, scoreMid/100, scoreHi/100);
  
  background(bg);
  // // background iamge
  // cover.display();
  // song name
  // music_info.update(1);
  // music_info.display();

  // Cube for each frequency band
  for (int i = 0; i < nbCubes; i++)
  {
    // Value of the frequency band
    float bandValue = fft.getBand(i);

    //The color is represented as follows: red for bass, green for midrange and blue for high.
    //The opacity is determined by the volume of the band and the overall volume.
    cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  }

  //Walls lines, here you have to keep the value of the previous and the next strip to connect them together
  float previousBandValue = fft.getBand(0);

  //Distance between each line point, negative because on dimension z
  float dist = -25;

  //Multiply the height by this constant
  float heightMult = 0.5;

  //For each band
  for (int i = 1; i < fft.specSize(); i++)
  {
    //Value of the frequency band, we multiply the further bands so that they are more visible.
    float bandValue = fft.getBand(i)*(1 + (i/50));

    //Selection of the color according to the strengths of the different types of sounds
    stroke(100+scoreLow, 100+scoreMid, 100+scoreHi, 255-i);
    // strokeWeight(1 + (scoreGlobal/100));
    strokeWeight(1);
    //bottom left line
    line(0, height-(previousBandValue*heightMult), dist*(i-1), 0, height-(bandValue*heightMult), dist*i);
    line((previousBandValue*heightMult), height, dist*(i-1), (bandValue*heightMult), height, dist*i);
    line(0, height-(previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), height, dist*i);

    // upper left row
    line(0, (previousBandValue*heightMult), dist*(i-1), 0, (bandValue*heightMult), dist*i);
    line((previousBandValue*heightMult), 0, dist*(i-1), (bandValue*heightMult), 0, dist*i);
    line(0, (previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), 0, dist*i);

    //bottom right line
    line(width, height-(previousBandValue*heightMult), dist*(i-1), width, height-(bandValue*heightMult), dist*i);
    line(width-(previousBandValue*heightMult), height, dist*(i-1), width-(bandValue*heightMult), height, dist*i);
    line(width, height-(previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), height, dist*i);

    // upper right line
    line(width, (previousBandValue*heightMult), dist*(i-1), width, (bandValue*heightMult), dist*i);
    line(width-(previousBandValue*heightMult), 0, dist*(i-1), width-(bandValue*heightMult), 0, dist*i);
    line(width, (previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), 0, dist*i);

    //Sauvegarder la valeur pour le prochain tour de boucle
    previousBandValue = bandValue;
  }

  //Walls rectangles
  for (int i = 0; i < nbWalls; i++)
  {
    //We assign each wall a band, and send it its strength.
    float intensity = fft.getBand(i%((int)(fft.specSize()*specHi)));
    walls[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
  }
}

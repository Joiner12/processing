import ddf.minim.*;
import ddf.minim.analysis.*;

// class:Minim
// class:AudioPlayer
Minim minim;
AudioPlayer song;

Block block_1;
OuterBlock out_1;
Bars bars_1;

void setup()
{
  minim = new Minim(this);
  song = minim.loadFile("Anhao.mp3");
  out_1 = new OuterBlock();
  bars_1 = new Bars();
  size(100, 1000);
  song.play();
  //frameRate(10);
}

void draw()
{
  background(255);
  float level_l = song.left.level();
  float level_r = song.right.level();
  bars_1.run(level_l+level_r, "default");
  //bars_1.breath();
  // outer
  out_1.display();
}

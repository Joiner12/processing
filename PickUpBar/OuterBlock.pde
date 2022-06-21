class OuterBlock
{
  PVector pos;
  float w;
  float h;
  OuterBlock()
  {
    pos = new PVector(width/2, height/2+4);
    w = width-4;
    h = height-20;
  }


  void display()
  {
    pushMatrix();
    strokeWeight(2);
    stroke(#C3D885);
    noFill();
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h, 4);
    popMatrix();
  }
}

class Block
{
  PVector pos;
  float w;
  float h;
  boolean visi_flag;
  color c_edge;
  color c_face;

  Block(PVector pos_)
  {
    pos = pos_;
    w = width-4;
    h=40;
    c_edge = color(#77CECD);
    c_face = color(#77CECD);
    visi_flag = true;
  }

  void update(color new_edge_c_, color new_face_c_, boolean visi_)
  {
    c_edge=new_edge_c_;
    c_face=new_face_c_;
    visi_flag = visi_;
  }

  void display()
  {
    if (visi_flag)
    {
      pushMatrix();
      if (c_edge==c_face)
      {
        noStroke();
      } else
      {
        stroke(c_edge);
      }
      fill(c_face);
      rectMode(CENTER);
      rect(pos.x, pos.y, w, h, 4);
      popMatrix();
    }
  }
}

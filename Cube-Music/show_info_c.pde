class show_info
{
  PVector position;
  String info;
  PVector speed;
  color in_color;
  color out_color;
  float text_size;

  show_info(String info_)
  {
    info = info_;
    text_size = 80;
    in_color = color(203, 240, 236);
    out_color = color(203, 240, 236);
  }

  void update(float scale_)
  {
    text_size *= scale_;
    position = new PVector(width/2, height - text_size/2);
  }
  void display()
  {
    pushMatrix();
    //background(in_color);
    textAlign(CENTER);
    fill(255);
    textSize(text_size);
    text(info, position.x, position.y);
    popMatrix();
  }
}

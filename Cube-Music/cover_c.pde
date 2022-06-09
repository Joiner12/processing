class Cover
{
  // image file must be in the folder of "data"
  PImage img_1;

  Cover(String cover_name_)
  {
    img_1 = loadImage(cover_name_);
  }

  void update()
  {
    //
  };

  void display()
  {
    tint(255, 200);
    image(img_1, 0, 0);
  }
}

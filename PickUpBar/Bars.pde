import java.util.Iterator;

class Bars
{
  ArrayList<Block> block_s;
  String color_mode;
  Bars()
  {
    block_s=new ArrayList<Block>();
    int y_pos=0;
    int block_span=2;
    color_mode = "default";
    for (int k=0; k<19; k++)
    {
      y_pos = height - 20- (block_span+k*51);
      block_s.add(new Block(new PVector(width/2, y_pos)));
    }
  }

  void run(float level_, String color_mode_)
  {
    Iterator<Block> it = block_s.iterator();
    int block_counter = 0;
    int block_num = int(map(level_, 0, 1, 1, 19));
    while (it.hasNext() & block_counter < block_num)
    {
      Block b = it.next();
      block_counter++;
      push();
      colorMode(HSB, 1);
      if (color_mode_.equals("signle_color"))
      {
        b.update(color(0.5, 0.5, 1), color(0.5, 0.5, 1), true);
      } else if (color_mode_.equals("shine_color"))
      {
        //float color_saturation = map(block_counter, 1, 19, 0, 1);
        b.update(color(level_, level_, level_+0.5), color(level_, level_*0.8, level_+0.5), true);
      } else
      {
        float color_saturation = map(block_counter, 1, 19, 0.5, 1);
        b.update(color(0.5, 0.5, color_saturation), color(0.5, 0.5, color_saturation), true);
        //b.update(color(level_, level_, 1), color(level_, level_*0.8, 1), true);
      }
      b.display();
      pop();
    }
  }

  void breath()
  {
    Iterator<Block> it = block_s.iterator();
    boolean visi_all = (second()%2==1);
    while (it.hasNext())
    {
      Block b = it.next();
      b.update(color(#77CECD), color(#77CECD), visi_all);
      //b.update(color(#77CECD), color(#77CECD), true);
      b.display();
    }
  }
}

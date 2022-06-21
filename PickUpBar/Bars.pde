import java.util.Iterator;

class Bars
{
  ArrayList<Block> block_s;
  Bars()
  {
    block_s=new ArrayList<Block>();
    int y_pos=0;
    int block_span=2;
    for (int k=1; k<20; k++)
    {
      y_pos = block_span+k*51;
      block_s.add(new Block(new PVector(width/2, y_pos)));
    }
  }

  void run()
  {
    Iterator<Block> it = block_s.iterator();
    while (it.hasNext())
    {
      Block b = it.next();
      b.update(color(#77CECD), color(#77CECD), random(1)<0.2);
      b.display();
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
      b.display();
    }
  }
}

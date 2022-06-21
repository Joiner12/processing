
Block block_1;
OuterBlock out_1;
Bars bars_1;

void setup()
{
  out_1 = new OuterBlock();
  bars_1 = new Bars();
  size(200, 1000);
}

void draw()
{
  background(255);

  bars_1.breath();
  // outer
  out_1.display();
}

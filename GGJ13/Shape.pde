class Shape
{
  color c;
  float tscale=1,scale=1;
  float scaleStep = 1.1; //amount to increase tscale by each zoom level
  
  Shape()
  {
  }
  
  void zoom()
  {
    scale(scale);
    scale += (tscale-scale)/5;
  }
  
  void draw()
  {
    //does nothing
  }
  
  void scaleUp()
  {
    tscale *= scaleStep;
  }
}

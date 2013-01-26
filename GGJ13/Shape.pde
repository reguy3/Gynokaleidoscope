class Shape
{
  color c;
  float tscale=1,scale=1;
  
  Shape()
  {
  }
  
  void zoom()
  {
    scale(scale);
    scale += (tscale-scale)/5;
  }
}

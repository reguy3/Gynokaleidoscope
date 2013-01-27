class Shape
{
  int TYPE, petals;
  color c;
  int alpha;
  float tscale=1,scale=1;
  float scaleStep = 1.6; //amount to increase tscale by each zoom level
  
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
  
  void alphaCalc()
  {
    if(25*scale < 75)
      alpha = 255;
    else if(25*scale > 0 && 25*scale<255)
      alpha = 255-25*(int)scale;
    else
      alpha=0;
    System.out.println("Scale: " + scale + " 25Scale: " + scale*25 + " Alpha = " + alpha);
  }
}

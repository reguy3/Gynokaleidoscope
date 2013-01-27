class Shape
{
  int TYPE;
  color c, oc;
  int alpha;
  float tscale=1, scale=0, petals;
  float scaleStep = 1.6; //amount to increase tscale by each zoom level

  Shape(color ci, int type)
  {
    c = ci;
    oc = ci;
    TYPE = type;
  }

  void zoom()
  {
    scale(scale);
    if (scale != tscale)
    {
      scale += (tscale-scale)/5;
      if (abs(scale-tscale) < .1)
        scale = tscale;
      c = darken(oc, scale);
    }
  }

  void draw()
  {
    //does nothing
  }

  void scaleUp()
  {
    tscale *= scaleStep;
    if (oc == 0) oc = c;
  }
}


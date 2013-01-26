

/**
 * k = petals
 * r = radius
 * g = rotation
 */
ArrayList roses = new ArrayList();
class Rose
{
  int petals;
  color f;
  float rot, radius;
  float tscale = 1,scale = 1;
  Rose(int k, int r, float g, color c)
  {
    petals = k%2==0 ? k/2 : k;
    radius = r;
    rot = g;
    f = color(255,0,0);
  }

  void draw()
  {
    radius += oscillation()*2;
    pushMatrix();
    pushStyle();
    fill(f);
    stroke(f);
    float t = 0;
    translate(HW, HH);
    rotate(rot);
    scale(scale);
    scale += (tscale-scale)/5;
    beginShape();
    while (t <= TWO_PI)
    {
      float x = radius*(cos(petals*t)*sin(t));
      float y = radius*(cos(petals*t)*cos(t));
      curveVertex(x, y);
      t += STEP;
    }
    for (byte i=0;i<3;i++)
    {
      float x = radius*(cos(petals*t)*sin(t));
      float y = radius*(cos(petals*t)*cos(t));
      curveVertex(x, y);
      t += STEP;
    }
    endShape(CLOSE);
    popStyle();
    popMatrix();
  }
}

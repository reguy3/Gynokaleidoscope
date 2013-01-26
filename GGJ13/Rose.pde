

/**
 * k = petals
 * r = radius
 * g = rotation
 */
ArrayList roses = new ArrayList();
class Rose extends Shape
{
  int petals;
  float rot, radius;
  Rose(int k, int r, float g, color ci)
  {
    petals = k%2==0 ? k/2 : k;
    radius = r;
    rot = g;
    c = ci;
  }

  void draw()
  {
    radius += oscillation()*2;
    push();
    fill(c);
    stroke(c);
    float t = 0;
    translate(HW, HH);
    rotate(rot);
    zoom();
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
    pop();
  }
}

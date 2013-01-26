/**
 * k = petals
 * r = radius
 * g = rotation
 */
//ArrayList roses = new ArrayList();
class Rose extends Shape
{
  int petals;
  float rot, radius;
  float osc_offset = (float)Math.random()*2*PI;
  Rose(int k, int r, float g, color ci)
  {
    petals = k%2==0 ? k/2 : k;
    radius = r;
    rot = g;
    c = ci;
  }
  Rose(ColorDot src)
  {
    petals = 2;
    radius = floor(dist(mouseX, mouseY, HW, HH)/2);
    rot = atan2(mouseY-HH, mouseX-HW);
    c = src.c;
  }

  void draw()
  {
    float currRadius = radius + oscillation(osc_offset)*10;
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
      float x = currRadius*(cos(petals*t)*sin(t));
      float y = currRadius*(cos(petals*t)*cos(t));
      curveVertex(x, y);
      t += STEP;
    }
    for (byte i=0;i<3;i++)
    {
      float x = currRadius*(cos(petals*t)*sin(t));
      float y = currRadius*(cos(petals*t)*cos(t));
      curveVertex(x, y);
      t += STEP;
    }
    endShape(CLOSE);
    pop();
  }
}

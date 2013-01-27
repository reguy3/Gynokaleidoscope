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
    petals = ceil(((RoseDot) src).frame/((RoseDot) src).peelRate);
    petals = petals%2 == 0 ? petals/2 : petals;
    radius = floor(dist(mouseX, mouseY, HW, HH));
    rot = atan2(mouseY-src.prev.y, mouseX-src.prev.x) - HALF_PI;
    c = src.c;
  }

  void draw()
  {
    float currRadius = radius + oscillation(osc_offset)*10;
    push();
    alphaCalc();
    fill(c, alpha);
    stroke(c, alpha);
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
  void pleaseDraw(int petals, int radius, float rot, float cx, float cy, color c, int w)
  { 
    petals = petals%2 == 0 ? petals/2 : petals;
    push();
    alphaCalc();
    fill(c, alpha);
    stroke(c, alpha);
    strokeWeight(w);
    float t = 0;
    translate(cx, cy);
    rotate(rot);
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


/**
 * k = petals
 * r = radius
 * g = rotation
 */
//ArrayList roses = new ArrayList();
class Hypercycloid extends Shape
{
  int petals;
  float rot, radius;
  float osc_offset = (float)Math.random()*2*PI;
  Hypercycloid(int k, int r, float g, color ci)
  {
    petals = k%2==0 ? k/2 : k;
    radius = r;
    rot = g;
    c = ci;
  }
  Hypercycloid(ColorDot src)
  {
    petals = floor(((HyperDot) src).frame/((HyperDot) src).peelRate);
    radius = floor(dist(mouseX, mouseY, HW, HH)/2);
    rot = atan2(mouseY-HH, mouseX-HW);
    c = src.c;
  }
  Hypercycloid(color ci)
  {
    c = ci;
  }

  void draw()
  {
    float currRadius = radius/2 + oscillation(osc_offset)*10;
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
      float x = currRadius*petals*cos(t)+currRadius*cos(petals*t);
      float y = currRadius*petals*sin(t)-currRadius*sin(petals*t);
      curveVertex(x, y);
      t += STEP;
    }
    for (byte i=0;i<3;i++)
    {
      float x = currRadius*petals*cos(t)+currRadius*cos(petals*t);
      float y = currRadius*petals*sin(t)-currRadius*sin(petals*t);
      curveVertex(x, y);
      t += STEP;
    }
    endShape(CLOSE);
    pop();
  }
  
  void pleaseDraw(int petals, float radius, float rot, float cx, float cy, color c, int w)
  {
    radius /= 8;
    petals --;
    push();
    alphaCalc();
    fill(c, alpha);
    stroke(c, alpha);
    strokeWeight(w);
    float t = 0;
    translate(cx, cy);
    rotate(rot);
    zoom();
    beginShape();
    while (t <= TWO_PI)
    {
      float x = radius*petals*cos(t)+radius*cos(petals*t);
      float y = radius*petals*sin(t)-radius*sin(petals*t);
      vertex(x, y);
      t += STEP;
    }
    for (byte i=0;i<3;i++)
    {
      float x = radius*petals*cos(t)+radius*cos(petals*t);
      float y = radius*petals*sin(t)-radius*sin(petals*t);
      vertex(x, y);
      t += STEP;
    }
    endShape(CLOSE);
    pop();
  }
}


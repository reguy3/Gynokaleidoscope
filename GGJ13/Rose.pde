/**
 * k = petals
 * r = radius
 * g = rotation
 */
//ArrayList roses = new ArrayList();
class Rose extends Shape
{
  float rot, radius;
  float osc_offset = (float)Math.random()*2*PI;
  float loops = TWO_PI;
  Rose(RoseDot src)
  {
    super(src.c, ROSE);
    petals = ceil(src.frame/src.peelRate);
    switch((int)petals)
    {
    case 4:
    case 8:
      petals /= 2;
      break;
    case 6:
      petals = 6/4f;
      loops *= 2;
      break;
    case 10:
      petals = 5/2f;
      loops *= 2;
      break;
    }
    //println(petals);
    radius = floor(dist(mouseX, mouseY, HW, HH));
    rot = atan2(mouseY-HH, mouseX-HW) - HALF_PI;
    c = src.c;
  }
  Rose(color c)
  {
    super(c, ROSE);
  }

  void draw()
  {
    if(scale > 10) return;
    float currRadius = radius + oscillation(osc_offset)*10;
    push();
    float t = 0;
    translate(HW, HH);
    rotate(rot);
    zoom();
    alphaCalc();
    fill(c, alpha);
    stroke(c, alpha);
    strokeWeight(0);
    beginShape();
    while (t <= loops)
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
    fill(c);
    stroke(c);
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


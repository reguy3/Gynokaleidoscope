/**
 * k = petals
 * r = radius
 * g = rotation
 */
//ArrayList roses = new ArrayList();
class Hypercycloid extends Shape
{
  float rot, radius;
  float osc_offset = (float)Math.random()*2*PI;
  Hypercycloid(ColorDot src)
  {
    super(src.c, HYPER);
    
    petals = floor(((HyperDot) src).frame/((HyperDot) src).peelRate);
    radius = floor(dist(mouseX, mouseY, HW, HH)/2);
    rot = atan2(mouseY-HH, mouseX-HW);
  }
  Hypercycloid(color ci)
  {
    super(ci, HYPER);
  }

  void draw()
  {
    alphaCalc();
    float currRadius = radius/2 + oscillation(osc_offset)*10;
    push();
    if(alpha==0) {
//      System.out.println("Hypercycloid with alpha " + alpha + " is NOT being printed.");   
      pop();
      return;
    }
//    System.out.println("HypercySpirolpha " + alpha + " is being printed.");
    float t = 0;
    translate(HW, HH);
    rotate(rot);
    zoom();
    fill(c, alpha);
    stroke(c, alpha);
    strokeWeight(0);
    beginShape();
    while (t <= TWO_PI)
    {
      float x = currRadius*petals*cos(t)+currRadius*cos(petals*t);
      float y = currRadius*petals*sin(t)-currRadius*sin(petals*t);
      vertex(x, y);
      t += STEP;
    }
    for (byte i=0;i<3;i++)
    {
      float x = currRadius*petals*cos(t)+currRadius*cos(petals*t);
      float y = currRadius*petals*sin(t)-currRadius*sin(petals*t);
      vertex(x, y);
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
    strokeWeight(w);
    float t = 0;
    translate(cx, cy);
    rotate(rot);
    zoom();
    fill(c);
    stroke(c);
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


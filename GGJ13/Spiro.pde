/**
 * br = big radius
 * lr = little radius
 * p = arm length
 */
class Spiro extends Shape
{
  float br, lr, p;
  Spiro(float b, float l, float a, color ci)
  {
    br = b;
    lr = l;
    p = a;
    c = ci;
  }
  
  Spiro(ColorDot src)
  {
    lr = ceil(dist(src.prev.x,src.prev.y,mouseX,mouseY));
    lr -= lr % 5;
    br = max(lr/5, floor(((sin(STEP*((SpiroDot)src).frame)/3)+.3)*lr));
    br -= br % 5;
    p = 60;//lr - br;
    println(br+","+lr+","+p);
    c = src.c;
  }

  void draw()
  {
    p += oscillation();    
    float k = lr/br;
    float a = p/lr;
    float t = 0;
    
    push();
    translate(HW, HH);
    zoom();
    noFill();
    stroke(c);
    strokeWeight(3);
    beginShape();
    float b2, b1 = 1/(1-(br/lr));
    int i;
    for (i=1;i<30;i++)
      if ((i*b1)%1 < .001)
        break;
    b1 *= i;

    while (t <= TWO_PI*b1)
    {
      float x = br*((1-k)*cos(t)+a*k*cos(((1-k)/k)*t));//r*(cos(k*t)*sin(t));
      float y = br*((1-k)*sin(t)+a*k*sin(((1-k)/k)*t));//r*(-cos(k*t)*cos(t));
      vertex(x, y);
      t += STEP;
    }
    endShape();
    pop();
  }
  
  void pleaseDraw(float cx, float cy, float rot, float br, float lr, float p, color c, int w)
  {
    float k = lr/br;
    float a = p/lr;
    float t = 0;
    
    push();
    translate(cx, cy);
    rotate(rot);
    noFill();
    stroke(c);
    strokeWeight(w);
    beginShape();
    float b2, b1 = 1/(1-(br/lr));
    int i;
    for (i=1;i<30;i++)
      if ((i*b1)%1 < .001)
        break;
    b1 *= i;

    while (t <= TWO_PI*b1)
    {
      float x = br*((1-k)*cos(t)+a*k*cos(((1-k)/k)*t));//r*(cos(k*t)*sin(t));
      float y = br*((1-k)*sin(t)+a*k*sin(((1-k)/k)*t));//r*(-cos(k*t)*cos(t));
      curveVertex(x, y);
      t += STEP;
    }
    endShape(CLOSE);
    pop();
  }
}

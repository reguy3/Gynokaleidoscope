

/**
 * br = big radius
 * lr = little radius
 * p = arm length
 */
class Spiro extends Shape
{
  float br, lr, p;
  Spiro(float b, float l, float a)
  {
    br = b;
    lr = l;
    p = a;
  }

  void draw()
  {
    p += oscillation();
    
    float k = lr/br;
    float a = p/lr;
    float t = 0;
    pushMatrix();
    translate(HW, HH);
    zoom();
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
    endShape(CLOSE);
    popMatrix();
  }
}

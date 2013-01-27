/**
 * br = big radius
 * lr = little radius
 * p = arm length
 */
class Spiro extends Shape
{
  float br, lr, p;
  float osc_offset = (float)Math.random()*2*PI;
  float[] ratios = {
    1.125, // 31
    2.2,
    2.25,
    4,     // 3
    1.5,   // 4
    3,     // 5
    1.25,  // 6
    8,     // 7
    2.5,   // 8
    1.4,   // 9
    1.75,  // 10
    1.6,   // 11
    1.1,   // 12
    1.8,   // 13
    2.75,
    3.5,
    4.5,
    6
  };
  Spiro(float b, float l, float a, color ci)
  {
    TYPE = 2;
    
    br = b;
    lr = l;
    p = a;
    c = ci;
  }
  
  Spiro(SpiroDot src)
  {
    float aratio = pow(sin(STEP*src.frame)+1, 4)/2;
    //println(aratio);
    float fratio = aratio;
    float d = 10;
    for(int i=0;i<ratios.length;i++)
    {
      float id = abs(ratios[i]-aratio);
      if(id < d) {
        d = id;
        fratio = ratios[i];
      } 
    }
    //println(fratio);
    lr = ceil(dist(src.prev.x,src.prev.y,mouseX,mouseY));
    lr -= lr % 5;
    br = lr / fratio;
    p = 60;
    println(br+","+lr+","+p);
    c = src.c;
  }

  void draw()
  {
    float centX = HW;
    float centY = HH;
//    for(int iter=0; iter<=3; iter++) { 
//      switch (iter) {
//            case 0:  centX = HW/2;
//                     centY = HH/2;
//                     break;
//            case 1:  centX = 3*HW/2;
//                     centY = HH/2;
//                     break;
//            case 2:  centX = HW/2;
//                     centY = 3*HH/2;
//                     break;
//            case 3:  centX = 3*HW/2;
//                     centY = 3*HH/2;
//                     break;
//            default: centX = HW;
//                     centY = HH;
//                     break;
//      }
      p += oscillation(osc_offset);    
      float k = lr/br;
      float a = p/lr;
      float t = 0;
      
      push();
      translate(centX, centY);
      zoom();
      noFill();
      alphaCalc();
      stroke(c, alpha);
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
      endShape(CLOSE);
      pop();
//    }
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

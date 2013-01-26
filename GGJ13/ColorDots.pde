ArrayList dots = new ArrayList();
class ColorDot
{
  color c;
  int start,type;
  
  ColorDot(int... s)
  {
    c = color(round(random(1))*200+55,round(random(1))*200+55,round(random(1))*200+55);
    type = floor(random(1)*4);
    if(s.length > 0)
      start = s[0];
    else
      start = millis();
  }
  
  void draw()
  {
    push();
    translate(HW,HH);
    float t = (millis()-start)/3000f;
    rotate(t/50);
    stroke(c);
    strokeWeight(3);
    noFill();
    ellipse(60*cos(t), 80*sin(t), 16, 16);
    pop();
  }
}

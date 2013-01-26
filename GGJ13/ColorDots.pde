ArrayList dots = new ArrayList();
class ColorDot
{
  color c;
  int start, type;

  ColorDot(int... s)
  {
    c = color(round(random(1))*200+55, round(random(1))*200+55, round(random(1))*200+55);
    type = floor(random(1)*4);
    if (s.length > 0)
      start = s[0];
    else
      start = millis();
  }

  void draw()
  {
    push();
    translate(HW, HH);
    float t = (millis()-start)/3000f;
    rotate(t/50);
    stroke(c);
    strokeWeight(3);
    float x = 60*cos(t);
    float y = 80*sin(t);
    float md = dist(HW, HH, mouseX, mouseY);
    float ma = atan2(mouseY-HH, mouseX-HW)-(t/50);
    float mx = md*cos(ma);
    float my = md*sin(ma);
    if(dist(x, y, mx, my) < 16)
    {
      fill(c);
      ellipse(x, y, 20, 20);
    }
    else
    {
      noFill();
      ellipse(x, y, 16, 16);
    }
    pop();
  }
}


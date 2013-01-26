ArrayList dots = new ArrayList();
class ColorDot
{
  color c;
  int start,type;
  
  ColorDot()
  {
    c = color(round(random(1))*255,round(random(1))*255,round(random(1))*255);
    type = floor(random(1)*4);
    start = millis();
  }
  
  void draw()
  {
    push();
    translate(HW,HH);
    int t = (millis()-start)/500;
    rotate(t);
    stroke(c);
    strokeWeight(3);
    noFill();
    ellipse(50*cos(t), 100*sin(t), 10, 10);
    pop();
  }
}

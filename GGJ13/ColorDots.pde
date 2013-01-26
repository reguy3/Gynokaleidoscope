ArrayList dots = new ArrayList();
boolean dotSelected = false;
color[] colors = {
  color(100), 
  color(225, 50, 50), 
  color(50, 225, 50), 
  color(50, 50, 225), 
  color(225, 225, 50), 
  color(225, 50, 225), 
  color(50, 225, 225), 
  color(225)
};
class ColorDot
{
  color c;
  int start, type, prevMillis;
  boolean selected = false;
  Point prev;

  ColorDot(int... s)
  {
    c = colors[floor(random(8))];
    type = floor(random(1)*4);
    if (s.length > 0)
      start = s[0];
    else
      start = millis();
  }

  void draw()
  {
    push();
    // DOT SELECTED BEHAVIOR
    if (selected)
    {
      stroke(0);
      strokeWeight(5);
      ellipse(prev.x, prev.y, 20, 20);
      line(prev.x, prev.y, mouseX, mouseY);
      fill(c);
      stroke(c);
      strokeWeight(3);
      ellipse(prev.x, prev.y, 20, 20);
      line(prev.x, prev.y, mouseX, mouseY);
      if (!mousePressed)
      {
        selected = false;
        dotSelected = false;
        start += millis()-prevMillis;
        if (currentShape<shapeCount)
        {
          shapes.add(new Rose(this));  
          currentShape++;
          for (int i=0; i<currentShape; i++)
          {
            ((Shape)shapes.get(i)).scaleUp();
          }
          dots.add(new ColorDot());
          dots.remove(dots.indexOf(this));
        }
      }
    }
    // ORBIT BEHAVIOR
    else
    {
      prevMillis = millis();
      float t = (prevMillis-start)/3000f;
      float x = 40*cos(t);
      float y = 60*sin(t);
      float d = dist(0, 0, x, y);
      float a = atan2(y, x)-(t/9);
      x = d*cos(a)+HW;
      y = d*sin(a)+HH;

      if (dist(x, y, mouseX, mouseY) < 16)
      {
        stroke(0);
        strokeWeight(5);
        noFill();
        ellipse(x, y, 20, 20);
        fill(c);
        stroke(c);
        strokeWeight(3);
        ellipse(x, y, 20, 20);
        if (!dotSelected && !pmousePressed && mousePressed)
        {
          dotSelected = true;
          selected = true;
        }
      }
      else
      {
        stroke(0);
        strokeWeight(5);
        noFill();
        ellipse(x, y, 16, 16);
        stroke(c);
        strokeWeight(3);
        ellipse(x, y, 16, 16);
      }
      prev = new Point(round(x), round(y));
    }
    pop();
  }
}


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
  int start, prevMillis;
  boolean selected = false;
  Point prev;

  ColorDot(int... s)
  {
    c = colors[floor(random(8))];
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
      dragShape(prev.x, prev.y);
      if (!mousePressed)
      {
        selected = false;
        dotSelected = false;
        start += millis()-prevMillis;
        if (currentShape<shapeCount)
        {
          for (int i=0; i<currentShape; i++)
            ((Shape)shapes.get(i)).scaleUp();
          shapes.add(createNewShape());  
          currentShape++;
          if (currentShape+dots.size() <= shapeCount)
          {
            dots.add(new ColorDot());
          }
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
        shape(x, y, true);
        if (!dotSelected && !pmousePressed && mousePressed)
        {
          dotSelected = true;
          selected = true;
        }
      }
      else
        shape(x, y, false);
      prev = new Point(round(x), round(y));
    }
    pop();
  }
  
  Shape createNewShape() {
    return new Rose(this);
  }

  void shape(float x, float y, boolean hover) {
    int r = hover ? 20 : 16;
    stroke(0);
    strokeWeight(5);
    noFill();
    ellipse(x, y, r, r);
    if (hover)
      fill(c);
    stroke(c);
    strokeWeight(3);
    ellipse(x, y, r, r);
  }

  void dragShape(float x, float y) {
    stroke(0);
    strokeWeight(5);
    ellipse(x, y, 20, 20);
    line(x, y, mouseX, mouseY);
    fill(c);
    stroke(c);
    strokeWeight(3);
    ellipse(x, y, 20, 20);
    line(x, y, mouseX, mouseY);
  }
}

class RoseDot extends ColorDot
{
  int frame = 0;
  Rose rose = new Rose(0, 0, 0, 0);

  RoseDot(int... s)
  {
    super(s);
  }
  
  Shape createNewShape()
  {
    return new Rose(this);
  }

  void shape(float x, float y, boolean hover)
  {
    int r = hover ? 20 : 16;
    rose.pleaseDraw(4, r, millis()/600f, x, y, 0, hover ? 7 : 5);
    rose.pleaseDraw(4, r, millis()/600f, x, y, c, 3);
  }

  void dragShape(float x, float y)
  {
    stroke(0);
    strokeWeight(5);
    rose.pleaseDraw(4, 20, millis()/600f, x, y, 0, 5);
    line(x, y, mouseX, mouseY);
    fill(c);
    stroke(c);
    strokeWeight(3);
    rose.pleaseDraw(4, 20, millis()/600f, x, y, c, 3);
    line(x, y, mouseX, mouseY);
  }
}

class SpiroDot extends ColorDot
{
  int frame = 0;
  Spiro spiro;
  
  SpiroDot(int... s)
  {
    super(s);
    spiro = new Spiro(10, 20, 5, c);
  }
  
  Shape createNewShape()
  {
    return new Spiro(this);
  }
  
  void shape(float x, float y, boolean hover)
  {
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, 0, hover ? 7 : 5);
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, c, hover ? 5 : 3);
  }

  void dragShape(float x, float y)
  {
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, 0, 7);
    stroke(0);
    strokeWeight(5);
    line(x, y, mouseX, mouseY);
    strokeWeight(1);
    fill(c);
    float osc = sin(STEP*frame)/3+.5;
    ellipse(x+(osc*(mouseX-x)), y+(osc*(mouseY-y)), 20, 20);
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, c, 5);
    stroke(c);
    strokeWeight(3);
    line(x, y, mouseX, mouseY);
    frame++;
  }
}


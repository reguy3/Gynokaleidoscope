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
      dragShape(prev.x, prev.y);
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
  Spiro spiro = new Spiro(0, 0, 0, 0);
  
  SpiroDot(int... s)
  {
    super(s);
  }

  void dragShape(float x, float y) {
    //spiro.pleaseDraw();
    stroke(0);
    strokeWeight(5);
    line(x, y, mouseX, mouseY);
    strokeWeight(1);
    fill(c);
    float osc = sin(STEP*frame)/2+.5;
    ellipse(x+(osc*(mouseX-x)), y+(osc*(mouseY-y)), 20, 20);
    //spiro.pleaseDraw();
    stroke(c);
    strokeWeight(3);
    line(x, y, mouseX, mouseY);
    frame++;
  }
}


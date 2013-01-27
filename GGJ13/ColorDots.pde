ArrayList dots = new ArrayList();
boolean dotSelected = false;
color[] colors = {
  //color(100),
  //**/ 
  color(225, 60, 60), 
  color(0, 225, 0), 
  //color(70, 70, 225),
  //*/ 
  //color(225, 225, 50), 
  //color(225, 50, 225), 
  color(50, 225, 225),
  //*/ 
  //color(225)
};
class ColorDot
{
  color c;
  int start, prevMillis;
  boolean selected = false;
  Point prev;

  ColorDot(int... s)
  {
    c = colors[floor(random(colors.length))];
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
        if (currentShape<shapeLimit)
        {
          for (int i=0; i<currentShape; i++)
            ((Shape)shapes.get(i)).scaleUp();
          shapes.add(createNewShape());  
          currentShape++;
          if (currentShape+dots.size() <= shapeLimit)
          {
            dots.add(createNewDot());
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
      float x = 10*cos(t);
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

  Shape createNewShape()
  {
    return new Rose(ceil(random(9))+1, 200, 0, colors[floor(random(3))]);
  }

  void shape(float x, float y, boolean hover)
  {
  }

  void dragShape(float x, float y)
  {
  }
}

ColorDot createNewDot(int... s)
{
  switch(floor(random(3)))
  {
  case 0:
    return new RoseDot(s);
  case 1:
    return new SpiroDot(s);
  case 2:
    return new HyperDot(s);
  }
  return new RoseDot(s);
}

class RoseDot extends ColorDot
{
  float peelRate = 60;
  float frame = peelRate * 2;
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
    rose.pleaseDraw(4, r+2, millis()/600f, x, y, 0, 0);
    rose.pleaseDraw(4, r, millis()/600f, x, y, c, 0);
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
    peel(frame, peelRate, c);
    if (frame < peelRate*10) frame++;
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
    float osc = sin(STEP*frame/3)/3+.5;
    ellipse(x+(osc*(mouseX-x)), y+(osc*(mouseY-y)), 20, 20);
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, c, 5);
    stroke(c);
    strokeWeight(3);
    line(x, y, mouseX, mouseY);
    frame++;
  }
}

class HyperDot extends ColorDot
{
  Hypercycloid cycloid;
  float peelRate = 60;
  float frame = peelRate*2;

  HyperDot(int... s)
  {
    super(s);
    cycloid = new Hypercycloid(c);
  }

  Shape createNewShape()
  {
    return new Hypercycloid(this);
  }

  void shape(float x, float y, boolean hover)
  {
    cycloid.pleaseDraw(5, hover ? 32:26, millis()/600f, x, y, 0, 0);
    cycloid.pleaseDraw(5, hover ? 30:24, millis()/600f, x, y, c, 0);
  }

  void dragShape(float x, float y)
  {
    stroke(0);
    strokeWeight(5);
    cycloid.pleaseDraw(5, 32, millis()/600f, x, y, 0, 0);
    line(x, y, mouseX, mouseY);
    fill(c);
    stroke(c);
    strokeWeight(3);
    cycloid.pleaseDraw(5, 30, millis()/600f, x, y, c, 0);
    line(x, y, mouseX, mouseY);
    peel(frame, peelRate, c);
    if (frame < peelRate*10) frame++;
  }
}

void peel(float frame, float peelRate, color c)
{
  push();
  noStroke();
  translate(mouseX, mouseY);
  float theta = atan2(mouseY-HH, mouseX-HW);
  for (float i=0;i<TWO_PI;i+=TWO_PI/(frame/peelRate))
  {
    Point pos = new Point(ceil(16*cos(i+theta)), ceil(16*sin(i+theta)));
    fill(0);
    ellipse(pos.x, pos.y, 10, 10);
    fill(c);
    ellipse(pos.x, pos.y, 8, 8);
  }
  pop();
}


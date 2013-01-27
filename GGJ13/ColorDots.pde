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
  float s = 0f;
  int start, prevMillis;
  boolean selected = false;
  Point prev;
  int TYPE;

  ColorDot(color[]... ci)
  {
    if (ci.length > 0 && ci[0].length > 0)
    {
      c = ci[0][0];
    }
    else
      c = colors[floor(random(colors.length))];
    start = floor(random(sq(millis())));
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
          dots.remove(dots.indexOf(this));
          if (currentShape+dots.size() <= shapeLimit)
          {
            dots.add(createNewDot());
          }
        }
      }
    }
    // ORBIT BEHAVIOR
    else
    {
      push();
      translate(HW, HH);
      scale(s);
      s = min(1, s+.02);
      prevMillis = millis();
      float t = (prevMillis-start)/3000f;
      float x = 10*cos(t)/s;
      float y = 60*sin(t)/s;
      float d = dist(0, 0, x, y);
      float a = atan2(y, x)-(t/9);
      x = d*cos(a);
      y = d*sin(a);

      if (s == 1 && dist(x, y, mouseX-HW, mouseY-HH) < 16)
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
      pop();
      prev = new Point(round(x+HW), round(y+HH));
    }
    pop();
  }

  Shape createNewShape()
  {
    return new Rose(ceil(random(7))+3, 200, 0, colors[floor(random(3))]);
  }

  void shape(float x, float y, boolean hover)
  {
  }

  void dragShape(float x, float y)
  {
  }
}

ColorDot createNewDot()
{
  color[] c = new color[0];
  int type;
  if (dots.size() > 1)
  {
    int j, i = floor(random(dots.size()));
    do {
      j = floor(random(dots.size()));
    } 
    while (j == i);
    ColorDot op1 =(ColorDot) dots.get(i);
    ColorDot op2 =(ColorDot) dots.get(j);
    type = op1.TYPE == op2.TYPE
      ? op1.TYPE
      : 3 - op1.TYPE - op2.TYPE;
    c = new color[1];
    c[0] = colorIndex(op1.c) == colorIndex(op2.c)
      ? op1.c
        : colors[3 - colorIndex(op1.c) - colorIndex(op2.c)];
    println("OP1: "+op1.TYPE+" "+colorIndex(op1.c));
    println("OP2: "+op2.TYPE+" "+colorIndex(op2.c));
    println("NEW: "+type+" "+colorIndex(c[0]));
    println("---");
  } 
  else {
    type = floor(random(3));
  }

  switch(type)
  {
  case ROSE:
    return new RoseDot((color[]) c);
  case SPIRO:
    return new SpiroDot((color[]) c);
  case HYPER:
    return new HyperDot((color[]) c);
  }
  return new RoseDot((color[]) c);
}
ColorDot createNewDot(int type, int c)
{
  color[] ca = {colors[c]};
  switch(type) {
  case ROSE:
    return new RoseDot(ca);
  case SPIRO:
    return new SpiroDot(ca);
  case HYPER:
    return new HyperDot(ca);
  }
  return new RoseDot(ca);
}

class RoseDot extends ColorDot
{
  float peelRate = 60;
  float frame = peelRate * 2;
  Rose rose = new Rose(0, 0, 0, 0);

  RoseDot(color[] ci)
  {
    super(ci);
    TYPE = ROSE;
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
  Spiro spiro = new Spiro(10, 20, 5, c);

  SpiroDot(color[] ci)
  {
    super(ci);
    TYPE = SPIRO;
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
  Hypercycloid cycloid = new Hypercycloid(color(0));
  float peelRate = 60;
  float frame = peelRate*2;

  HyperDot(color[] ci)
  {
    super(ci);
    TYPE = HYPER;
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


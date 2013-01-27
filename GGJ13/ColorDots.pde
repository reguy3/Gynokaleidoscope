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
  int ts = 1;
  float s = 0f;
  int start, prevMillis, owidth;
  boolean selected = false;
  Point prev;
  int TYPE;
  PImage icon;

  ColorDot(color[]... ci)
  {
    if (ci.length > 0 && ci[0].length > 0)
    {
      c = ci[0][0];
    }
    else
      c = colors[floor(random(colors.length))];
    start = floor(random(MAX_INT));
    owidth = floor(random(50))+10;
  }

  void draw()
  {
    push();
    // DOT SELECTED BEHAVIOR
    if (selected)
    {
      dragShape(prev.x, prev.y);
      translate(prev.x, prev.y);
      rotate(millis()/600f);
      image(icon, -30, -30, 60, 60);
      if (!mousePressed)
      {
        selected = false;
        dotSelected = false;
        start += millis()-prevMillis;
        if (currentShape<shapeLimit)
        {
          for (int i=0; i<currentShape; i++)
            ((Shape)shapes.get(i)).scaleUp();
          Shape newShape = createNewShape();
          shapes.add(newShape);  
          currentShape++;
          inPlay.add(newShape);
          if (inPlay.size() == 3)
          {
            if (isSet(((Shape) inPlay.get(0)), ((Shape) inPlay.get(1)), ((Shape) inPlay.get(2)), false))
            {
              int nextLevel = currentLevel.levelNum+1;
              playBabby(nextLevel+1);
              println("nl: "+nextLevel);
              sfade = fade;
              fade = 255;
              if (nextLevel == levels.size())
              {
                // YOU WIN!
                int j = 0;
                for (int i=shapes.size()-1;i>=0;i--)
                {
                  ((Shape) shapes.get(i)).tscale = (++j)*.1;
                }
                for (int i=0;i<dots.size();i++)
                {
                  ((ColorDot) dots.get(i)).ts = 0;
                }
                inPlay = new ArrayList();
                mode = FADE;
                return;
              }
              else 
              {
                bgPrev = bgCurr;
                bgCurr = bgNext;
                bgNext = bgArray[nextLevel];
                currentLevel = ((Level) levels.get(nextLevel));
                shapeCount = currentLevel.dots.length;
              }
              playWin();
            }
            else
            {
              playFail();
              println("FAIL");
              currentLevel.displayedText = false;
            }
            dots = currentLevel.set();
            for (int i=0;i<inPlay.size();i++)
            {
              ((Shape) inPlay.get(i)).scaleUp();
            }
            inPlay = new ArrayList();
          } 
          else {
            dots.remove(dots.indexOf(this));
            /*
            if (currentShape+dots.size() <= shapeLimit)
             {
             dots.add(createNewDot());
             } */
          }
        }
      }
    }
    // ORBIT BEHAVIOR
    else
    {
      translate(HW, HH);
      scale(s);
      if (ts == 1)
        s = min(1, s+.1);
      else
        s = max(0, s-.05);
      prevMillis = millis();
      float t = (prevMillis-start)/3000f;
      float x = owidth*cos(t)/s;
      float y = 60*sin(t)/s;
      float d = dist(0, 0, x, y);
      float a = atan2(y, x)-(t/9);
      x = d*cos(a);
      y = d*sin(a);

      translate(x, y);
      rotate(millis()/600f);
      if (s == 1 && dist(x, y, mouseX-HW, mouseY-HH) < 16)
      {
        image(icon, -30, -30, 60, 60);
        if (!dotSelected && !pmousePressed && mousePressed)
        {
          dotSelected = true;
          int index = dots.indexOf(this);
          for (int i=index;i<dots.size();i++)
          {
            ColorDot di = (ColorDot) dots.get(i);
            if (s == 1 && dist(di.prev.x, di.prev.y, mouseX, mouseY) < 16)
              index = i;
          }
          ((ColorDot) dots.get(index)).selected = true;
        }
      }
      else
        image(icon, -25, -25, 50, 50);
      prev = new Point(round(x+HW), round(y+HH));
    }
    pop();
  }

  Shape createNewShape()
  {
    return new Shape(color(255), -1);
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
  color[] ca = {
    colors[c]
  };
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
  Rose rose;

  RoseDot(color[] ci)
  {
    super(ci);
    rose = new Rose(ci[0]);
    TYPE = ROSE;
    icon = loadImage("icons/"+ROSE+colorIndex(c)+".png");
  }

  Shape createNewShape()
  {
    playGrow();
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
    line(x, y, mouseX, mouseY);
    fill(c);
    stroke(c);
    strokeWeight(3);
    line(x, y, mouseX, mouseY);
    peel(frame, peelRate, c);
    if (frame < peelRate*10) frame++;
  }
}

class SpiroDot extends ColorDot
{
  int frame = 0;
  Spiro spiro;

  SpiroDot(color[] ci)
  {
    super(ci);
    TYPE = SPIRO;
    spiro = new Spiro(ci[0]);
    icon = loadImage("icons/"+SPIRO+colorIndex(c)+".png");
  }

  Shape createNewShape()
  {
    playGrow();
    return new Spiro(this);
  }

  void shape(float x, float y, boolean hover)
  {
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, 0, hover ? 7 : 5);
    spiro.pleaseDraw(x, y, millis()/600f, 10, 20, 5, c, hover ? 5 : 3);
  }

  void dragShape(float x, float y)
  {
    stroke(0);
    strokeWeight(5);
    line(x, y, mouseX, mouseY);
    strokeWeight(1);
    fill(c);
    float osc = sin(STEP*frame/3)/3+.5;
    ellipse(x+(osc*(mouseX-x)), y+(osc*(mouseY-y)), 20, 20);
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

  HyperDot(color[] ci)
  {
    super(ci);
    TYPE = HYPER;
    cycloid = new Hypercycloid(ci[0]);
    icon = loadImage("icons/"+HYPER+colorIndex(c)+".png");
  }

  Shape createNewShape()
  {
    playGrow();
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
    line(x, y, mouseX, mouseY);
    fill(c);
    stroke(c);
    strokeWeight(3);
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


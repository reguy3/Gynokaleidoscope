import java.awt.Point;
import krister.Ess.*;

static final float STEP = TWO_PI/50;
float HW, HH;
int R = 100;
int r = 160;
float P = 60;
boolean pmousePressed = false;
int shapeCount = 5;
int shapeLimit = 16;
int currentShape = 0;
ArrayList shapes;

void setup() 
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  dots = new ArrayList();
  for (byte i=0;i<shapeCount;i++)
    dots.add(new HyperDot(floor(random(1000000000))));
  shapes = new ArrayList(shapeLimit);
  
  // UNIT TESTING
  /*
  println(isSet(
    new Hypercycloid(0,0,0,colors[0]),
    new Rose(0,0,0,colors[0]),
    new Hypercycloid(0,0,0,colors[0]),
    false
  ));
  // true */
  /* 
  println(isSet(
    new Hypercycloid(0,0,0,colors[0]),
    new Rose(0,0,0,colors[0]),
    new Hypercycloid(0,0,0,colors[1]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Hypercycloid(0,0,0,colors[0]),
    new Rose(0,0,0,colors[1]),
    new Hypercycloid(0,0,0,colors[2]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Rose(0,0,0,colors[0]),
    new Rose(0,0,0,colors[1]),
    new Rose(0,0,0,colors[2]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Rose(0,0,0,colors[0]),
    new Rose(0,0,0,colors[1]),
    new Rose(0,0,0,colors[1]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Rose(4,0,0,colors[1]),
    new Rose(5,0,0,colors[2]),
    true
  ));
  // true */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Hypercycloid(5,0,0,colors[1]),
    new Rose(4,0,0,colors[2]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Rose(3,0,0,colors[1]),
    new Rose(3,0,0,colors[2]),
    true
  ));
  // true */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Rose(4,0,0,colors[1]),
    new Rose(4,0,0,colors[2]),
    true
  ));
  // false */
}

void draw()
{
  background(0);
  // Vignette
  // Draw layers
  for (int i=0;i<shapes.size();i++)
    ((Shape)shapes.get(i)).draw();
  // Draw dots
  for (int i=0;i<dots.size();i++)
    ((ColorDot)dots.get(i)).draw();
  pmousePressed = mousePressed;
}

float oscillation(float osc_offset)
{
  return sin(millis()/500f+osc_offset);
}

float oscillation()
{
  return sin(millis()/500f);
}

void push()
{
  pushMatrix();
  pushStyle();
}
void pop()
{
  popStyle();
  popMatrix();
}


import java.awt.Point;
import krister.Ess.*;

static final float STEP = TWO_PI/50;
float HW, HH;
int R = 100;
int r = 160;
float P = 60;
String levelFile = "levels.txt";
boolean pmousePressed = false;
int shapeCount = 5;
int shapeLimit = 16;
int currentShape = 0;
ArrayList shapes;
ArrayList levels;


void setup()
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  dots = new ArrayList();
  for (byte i=0;i<shapeCount;i++)
    dots.add(new HyperDot(floor(random(1000000000))));
  shapes = new ArrayList(shapeLimit);
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

void createLevels()
{
  levels = new ArrayList();
  String lines[] = loadStrings(levelFile);
  for (int i=0; i<lines.length; i++)
  {
     String properties[] = split(lines[0], " % ");
     levels.add(new Level(Integer.parseInt(properties[0]), properties[1], properties[2]);
  }
}


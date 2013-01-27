import java.awt.Point;
import krister.Ess.*;

static final float STEP = TWO_PI/50;
static final int ROSE = 0;
static final int SPIRO = 1;
static final int HYPER = 2;

float HW, HH;
String levelFile = "levels.txt";
boolean pmousePressed = false;
int shapeCount = 5;
int shapeLimit = 16;
int currentShape = 0;
ArrayList shapes;
ArrayList levels;
int tInit = 0;
Level currentLevel;

void setup() 
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  createLevels();
  currentLevel = (Level)(levels.get(0));
  dots = new ArrayList();
  for (byte i=0;i<shapeCount;i++)
    dots.add(createNewDot());
  shapes = new ArrayList(shapeLimit);
  unitTesting();
  textFont(createFont("Arial", 48));
  //setupSound();
  //playMainTheme();
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
  currentLevel.levelText();
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

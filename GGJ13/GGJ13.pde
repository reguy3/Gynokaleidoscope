import java.awt.Point;
import krister.Ess.*;

static final float STEP = TWO_PI/50;
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
int backgrounds = 9; //number of images
PImage[] bgArray;

void setup() 
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  createLevels();
  currentLevel = (Level)(levels.get(1));
  dots = currentLevel.set();
  shapes = new ArrayList(shapeLimit);
  unitTesting();
  textFont(createFont("Arial", 48));
  bgArray = new PImage[backgrounds];
  for(int i=0;i<backgrounds;i++)
    bgArray[i] = loadImage(i+".jpg");
  //setupSound();
  //playMainTheme();
}

void draw()
{
  background(bgArray[currentLevel.bg]);
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

import java.awt.Point;
import krister.Ess.*;

static final float STEP = TWO_PI/50;
static final int ROSE = 0;
static final int HYPER = 1;
static final int SPIRO = 2;

float HW, HH;
String levelFile = "levels.txt";
boolean pmousePressed = false;
int shapeCount = 5;
int shapeLimit = 100;
int currentShape = 0;
ArrayList shapes;
ArrayList levels;
int tInit = 0;
Level currentLevel;
int backgrounds = 8; //number of images
PImage[] bgArray;

void setup() 
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  createLevels();
  currentLevel = (Level)(levels.get(0));
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

float tfade = 0, fade = 0;
void draw()
{
  // Background, next level
  background(bgArray[currentLevel.levelNum+1]);
  // Faded current level
  tfade = (3-inPlay.size())*(255/3);
  fade = (tfade - fade) / 500;
  pushMatrix();
  tint(255, fade);
  image(bgArray[currentLevel.levelNum],0,0);
  popMatrix();
  // Draw layers
  for (int i=0;i<shapes.size();i++)
  {
    if(shapes.size()-i > 10) continue;
    //fill(0, 52);
    //rect(0, 0, width, height);
    ((Shape)shapes.get(i)).draw();
  }
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


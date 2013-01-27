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
  size(1600, 1200);
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
  bgPrev = bgArray[0];
  bgCurr = bgArray[0];
  bgNext = bgArray[1];
  setupSound();
  playMainTheme();
}

PImage bgPrev, bgCurr, bgNext;
float tfade = 255, fade = 255, sfade = 0, fadeLength = 10;
void draw()
{
  // Background, next level
  background(bgNext);
  // Faded current level
  tfade = (3-inPlay.size())*(255/3);
  fade += (tfade - fade) / fadeLength;
  sfade -= sfade < 5 ? sfade : sfade/fadeLength;
  println(sfade);
  pushMatrix();
  tint(255, fade);
  image(bgCurr,0,0);
  if(sfade>0 && currentLevel.levelNum > 0)
  {
    tint(255, sfade);
    image(bgPrev,0,0);
  }
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

void exit()
{
  stopSound();
  println("stop");
  super.exit();
}


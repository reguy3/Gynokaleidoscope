import java.awt.Point;
import krister.Ess.*;

static final float STEP = TWO_PI/50;
static final int ROSE = 0;
static final int HYPER = 1;
static final int SPIRO = 2;

int mode = 0;
static final int TITLE = 0;
static final int GAME = 1;
static final int END = 2;
static final int FADE= 3;

float HW, HH;
String levelFile = "levels2.txt";
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
float superFade = 0;

void setup() 
{
  size(displayWidth, displayHeight);
  HW = width/2;
  HH = height/2;
  createLevels();
  currentLevel = (Level)(levels.get(0));
  dots = currentLevel.set();
  shapes = new ArrayList(shapeLimit);
  unitTesting();
  textFont(createFont("Arial", 180));
  bgArray = new PImage[backgrounds];
  for (int i=0;i<backgrounds;i++)
    bgArray[i] = loadImage(i+".jpg");
  bgPrev = bgArray[0];
  bgCurr = bgArray[0];
  bgNext = bgArray[1];
  setupSound();
  playMainTheme();

  ekg = new float[ceil(260/5)];
  for (int i=0;i<ekg.length;i++)
    ekg[i] = 0f;
  ekg[2] = 20f;
  ekg[3] = 100f;
  ekg[4] = -20f;
  ekg[8] = 5f;
}

PImage bgPrev, bgCurr, bgNext;
float tfade = 255, fade = 255, sfade = 0, fadeLength = 10;
float[] ekg;
void draw()
{
  soundLoop();
  switch(mode)
  {
  case TITLE:
    image(bgArray[0], 0, 0, width, height);
    //filter(BLUR, 8);
    textAlign(CENTER);
    textSize(180);
    for (int i=0;i<2;i++)
    {
      //filter(BLUR, 2);
      fill(i*255);
      stroke(i*255);
      strokeWeight(12);
      strokeCap(SQUARE);
      text("scope", HW+100, HH-(i*5));
      noFill();
      beginShape();
      for (int x=0;x<260;x+=10)
      {
        vertex(HW-410+x, HH-5-(i*5)-ekg[(frameCount+floor(x/10))%ekg.length]);
      }
      endShape();
    }
    break;

  case GAME:
  case FADE:
    textSize(40);
    // Background, next level
    if (mode == GAME)
    {
      if (bgNext == null)
        background(255);
      else
        image(bgNext, 0, 0, width, height);
      // Faded current level
      tfade = (3-inPlay.size())*(255/3);
      fade += (tfade - fade) / fadeLength;
      sfade -= sfade < 5 ? sfade : sfade/fadeLength;
      //println(sfade);
      pushStyle();
      tint(255, fade);
      image(bgCurr, 0, 0, width, height);
      if (sfade>0 && currentLevel.levelNum > 0)
      {
        tint(255, sfade);
        image(bgPrev, 0, 0, width, height);
      }
      popStyle();
    }
    else
      background(255);
    // Draw layers
    for (int i=0;i<shapes.size();i++)
    {
      if (shapes.size()-i > 10) continue;
      //fill(0, 52);
      //rect(0, 0, width, height);
      ((Shape)shapes.get(i)).draw();
    }
    // Draw dots
    if (mode == GAME)
      for (int i=0;i<dots.size();i++)
        ((ColorDot)dots.get(i)).draw();
    else
    {
      fill(255);
      // TEXT?
    }
    if (mode == FADE)
    {
      superFade += 255/240;
      fill(255, superFade);
      stroke(255);
      rect(0, 0, width, height);
      fill(0, 255*sin((superFade/480)*TWO_PI));
      text("Well done.", HW, height-50);
      if (255-superFade < 10)
      {
        mode = END;
      }
    }
    pmousePressed = mousePressed;
    currentLevel.levelText();
    break;
  case END:
    background(255, 255, 200);
    fill(0);
    text("You can stop struggling now. You've prepared all you can. It's time.", 0, HH, width, 300);
    break;
  }
}

float oscillation(float osc_offset)
{
  if (millis()%1000 == 0)
  {
    // BRYAN MAYER! HEARTBEAT HERE!
  }
  return sin((((millis()%1000)/1000f)*currentLevel.tempo+osc_offset)*TWO_PI);
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

void mouseClicked()
{
  if (mode > 0) return;
  mode = 1;
}

void exit()
{
  stopSound();
  println("exiting");
  super.exit();
}

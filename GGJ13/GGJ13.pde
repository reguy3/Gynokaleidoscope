import java.awt.Point;

static final float STEP = TWO_PI/50;
float HW, HH;
int R = 100;
int r = 160;
float P = 60;
boolean pmousePressed = false;

void setup()
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  dots = new ArrayList();
  for (byte i=0;i<4;i++)
    dots.add(new ColorDot(floor(random(10000000))));
}

void draw()
{
  background(0);
  // Vignette
  // Draw layers
  for (int i=0;i<roses.size();i++)
    ((Rose)roses.get(i)).draw();
  // Draw dots
  for (int i=0;i<dots.size();i++)
    ((ColorDot)dots.get(i)).draw();
  pmousePressed = mousePressed;
}

float oscillation()
{
  return sin(millis()/500f);
}

void keyPressed()
{
  if (key == ' ')
    ((Rose)roses.get(0)).tscale *= 2;
}

Point click1 = null;
void mouseClicked()
{
  roses.add(new Rose(4, floor(dist(mouseX, mouseY, HW, HH)), atan2(mouseY-HH, mouseX-HW), color(255, 0, 0)));
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


import java.awt.Point;

static final float STEP = TWO_PI/50;
float HW, HH;
int R = 100;
int r = 160;
float P = 60;
boolean pmousePressed = false;
int shapeCount = 4;
int currentShape = 0;
ArrayList shapes;

void setup()
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  dots = new ArrayList();
  for (byte i=0;i<4;i++)
    dots.add(new ColorDot(floor(random(10000000))));
  shapes = new ArrayList(shapeCount);
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

float oscillation()
{
  return sin(millis()/500f);
}

void keyPressed()
{
  if(key == ' ')
    ((Shape)shapes.get(currentShape)).scaleUp();
}

Point click1 = null;
void mouseClicked()
{
  if(currentShape<shapeCount)
  {
    shapes.add(new Rose(4, floor(dist(mouseX, mouseY, HW, HH)), atan2(mouseY-HH, mouseX-HW), color(255, 0, 0)));  
    currentShape++;
    for(int i=0; i<currentShape; i++)
    {
      ((Shape)shapes.get(i)).scaleUp();
    }
  }
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


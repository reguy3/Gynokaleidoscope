import java.awt.Point;

static final float STEP = TWO_PI/50;
float HW, HH;
int R = 100;
int r = 160;
float P = 60;

void setup()
{
  size(800, 600);
  HW = width/2;
  HH = height/2;
  dots = new ArrayList();
  dots.add(new ColorDot(floor(random(10000000))));
  dots.add(new ColorDot(floor(random(10000000))));
  dots.add(new ColorDot(floor(random(10000000))));
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
}

float oscillation()
{
  return sin(millis()/500f);
}

void keyPressed()
{
  if(key == ' ')
    ((Rose)roses.get(0)).tscale *= 2;
}

Point click1 = null;
void mouseClicked()
{
  /*
    float a2 = atan2(mouseY-HH, mouseX-HW);
   float diff = abs(a1-a2);
   int petals = 7;
   float m = 3;
   for(int i=petals;i<16;i++) {
   if(m < diff%(TWO_PI/i)) {
   m = diff%(TWO_PI/i);
   petals = i;
   }
   }*/
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

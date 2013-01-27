void createLevels()
{
  levels = new ArrayList();
  String[] lines = loadStrings(levelFile);
  for (int i=0;i<lines.length;i++)
  {
    String[] data = lines[i].split("\t");
    levels.add(new Level(i, data[1], int(data[0]), subset(data, 2)));
  }
}

class Level
{
  int levelNum, bg;
  float tempo;
  String storyText;
  String audioFile;
  boolean hasSound = false;
  boolean displayedText = false;
  String[] dots;

  public Level (int _levelNum, String _storyText, int bpm, String[] _dots)
  {
    levelNum = _levelNum;
    storyText = _storyText;
    tempo = bpm/100f;
    bg = 0;
    audioFile = "audio/level_"+levelNum+".mp3";
    dots = _dots;
  }

  ArrayList set()
  {
    ArrayList set = new ArrayList(dots.length);
    for (int i=0;i<dots.length;i++)
    {
      //println("Dot: " + dots[i].charAt(0) +" "+ dots[i].charAt(1)); 
      //println(parseInt(dots[i].charAt(0)+""));
      set.add(createNewDot(parseInt(dots[i].charAt(0)+""), parseInt(dots[i].charAt(1)+"")));
    }
    return set;
  }

  float textFade = 0;
  void levelText() {
    int duration = 5000;
    if (!displayedText)
    {
      tInit = millis();
      displayedText = true;
    }
    int target = keyPressed || millis()-tInit < duration
      ? 255
      : 0;
    textFade = abs(target-textFade) < 15
      ? target
      : textFade+(target-textFade)/15;
    if(textFade == 0) return;
    textAlign(CENTER);
    int shift = 200;
    if (keyPressed) tInit += 3*(millis()-tInit)/4;
    fill(0, textFade);
    text("Week " + (levelNum+1), HW, 75);
    text(storyText, 0, height-shift, width, shift);
  }
}


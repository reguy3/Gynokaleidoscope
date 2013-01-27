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
  int levelNum, tempo;
  String storyText;
  String audioFile;
  boolean hasSound = false;
  boolean displayedText = false;
  ColorDot[] set;

  public Level (int _levelNum, String _storyText, int bpm, String[] dots)
  {
    levelNum = _levelNum;
    storyText = _storyText;
    tempo = bpm;
    audioFile = "audio/level_"+levelNum+".mp3";
    set = new ColorDot[dots.length];
    for(int i=0;i<dots.length;i++)
    {
      //println("Dot: " + dots[i].charAt(0) +" "+ dots[i].charAt(1)); 
      //println(parseInt(dots[i].charAt(0)+""));
      set[i] = createNewDot(parseInt(dots[i].charAt(0)+""), parseInt(dots[i].charAt(1)+""));
    }
  }


void levelText() {
  textAlign(CENTER);
  int shift = 50;
  if(!displayedText)
  {
    tInit = millis();
    displayedText = true;
  }
  int seconds = 5;
  if (millis()-tInit < seconds*1000) {
    text("Level " + levelNum, width/2, shift);
    text(storyText, width/2, height-shift);
  }
}
}
  
  


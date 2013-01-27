
class Level
{
  int levelNum;
  String storyText;
  String audioFile;
  boolean hasSound = false;
  
  public Level (int _levelNum, String _storyText, String _audioFile)
  {
    levelNum = _levelNum;
    storyText = _storyText; 
    audioFile = _audioFile;
    if(!audioFile.equals(""))
    {
      hasSound = true;
    }
  }
}

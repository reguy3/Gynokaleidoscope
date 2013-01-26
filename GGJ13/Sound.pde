import krister.Ess.*;

AudioChannel mainTheme;
AudioChannel seWinChime;
AudioChannel seChime1, seChime2, seChime3, seChime4, seChime5, seChime6, seChime7, seChime8;
AudioChannel seSoftChime1, seSoftChime2, seSoftChime3, seSoftChime4, seSoftChime5, seSoftChime6, seSoftChime7, seSoftChime8;
AudioChannel seMultiChime1, seMultiChime2, seMultiChime3, seMultiChime4, seMultiChime5, seMultiChime6, seMultiChime7, seMultiChime8;
AudioChannel seBlock1, seBlock2, seBlock3, seBlock4, seBlock5, seBlock6, seBlock7, seBlock8,
             seBlock9, seBlock10, seBlock11, seBlock12, seBlock13, seBlock14, seBlock15;

void setupSound()
{
  // start up Ess
  Ess.start(this);

  // load background songs into new AudioChannels
  mainTheme = new AudioChannel("MotherNodeTheme.mp3");
  
  // load Chime sound effects
  seChime1 = new AudioChannel("Chime1.mp3");
  seChime2 = new AudioChannel("Chime2.mp3");
  seChime3 = new AudioChannel("Chime3.mp3");
  seChime4 = new AudioChannel("Chime4.mp3");
  seChime5 = new AudioChannel("Chime5.mp3");
  seChime6 = new AudioChannel("Chime6.mp3");
  seChime7 = new AudioChannel("Chime7.mp3");
  seChime8 = new AudioChannel("Chime8.mp3");
  
  // load soft chimes
  seSoftChime1 = new AudioChannel("SoftChime1.mp3");
  seSoftChime2 = new AudioChannel("SoftChime2.mp3");
  seSoftChime3 = new AudioChannel("SoftChime3.mp3");
  seSoftChime4 = new AudioChannel("SoftChime4.mp3");
  seSoftChime5 = new AudioChannel("SoftChime5.mp3");
  seSoftChime6 = new AudioChannel("SoftChime6.mp3");
  seSoftChime7 = new AudioChannel("SoftChime7.mp3");
  seSoftChime8 = new AudioChannel("SoftChime8.mp3");
  
  // load multi-chimes
  seMultiChime1 = new AudioChannel("MultiChime1.mp3");
  seMultiChime2 = new AudioChannel("MultiChime2.mp3");
  seMultiChime3 = new AudioChannel("MultiChime3.mp3");
  seMultiChime4 = new AudioChannel("MultiChime4.mp3");
  seMultiChime5 = new AudioChannel("MultiChime5.mp3");
  seMultiChime6 = new AudioChannel("MultiChime6.mp3");
  seMultiChime7 = new AudioChannel("MultiChime7.mp3");
  
  // load blocks
  seBlock1 = new AudioChannel("Block1.mp3");
  seBlock2 = new AudioChannel("Block2.mp3");
  seBlock3 = new AudioChannel("Block3.mp3");
  seBlock4 = new AudioChannel("Block4.mp3");
  seBlock5 = new AudioChannel("Block5.mp3");
  seBlock6 = new AudioChannel("Block6.mp3");
  seBlock7 = new AudioChannel("Block7.mp3");
  seBlock8 = new AudioChannel("Block8.mp3");
  seBlock9 = new AudioChannel("Block9.mp3");
  seBlock10 = new AudioChannel("Block10.mp3");
  seBlock11 = new AudioChannel("Block11.mp3");
  seBlock12 = new AudioChannel("Block12.mp3");
  seBlock13 = new AudioChannel("Block13.mp3");
  seBlock14 = new AudioChannel("Block14.mp3");
  seBlock15 = new AudioChannel("Block15.mp3");
  
  // win chime
  seWinChime = new AudioChannel("WinChime.mp3");
}


//
// Music
//

// Start the main theme
void playMainTheme()
{
  //println("main theme");
  mainTheme.gain(5);
  mainTheme.play(Ess.FOREVER);
}

void stopMainTheme()
{
  //println("stop main theme");
  if (mainTheme.state == Ess.PLAYING)
  {
    //println("main theme playing...");
    mainTheme.stop();
  }
}



//
// Sound Effects
//


//Chimes
void playChime()
{
  if (seChime1.state == Ess.PLAYING)
    seChime1.stop();
  if (seChime2.state == Ess.PLAYING)
    seChime2.stop();
  if (seChime3.state == Ess.PLAYING)
    seChime3.stop();
  if (seChime4.state == Ess.PLAYING)
    seChime4.stop();
  if (seChime5.state == Ess.PLAYING)
    seChime5.stop();
  if (seChime6.state == Ess.PLAYING)
    seChime6.stop();
  if (seChime7.state == Ess.PLAYING)
    seChime7.stop();
  if (seChime8.state == Ess.PLAYING)
    seChime8.stop();
  
  int rand = int(random(8));
  switch(rand)
  {
  case 0:
    seChime1.play();
    break;
  case 1:
    seChime2.play();
    break;
  case 2:
    seChime3.play();
    break;
  case 3:
    seChime4.play();
    break;
  case 4:
    seChime5.play();
    break;
  case 5:
    seChime6.play();
    break;
  case 6:
    seChime8.play();
    break;
  default:
    seChime8.play();
    break;
  }
}


//Soft Chimes
void playSoftChime()
{
  if (seSoftChime1.state == Ess.PLAYING)
    seSoftChime1.stop();
  if (seSoftChime2.state == Ess.PLAYING)
    seSoftChime2.stop();
  if (seSoftChime3.state == Ess.PLAYING)
    seSoftChime3.stop();
  if (seSoftChime4.state == Ess.PLAYING)
    seSoftChime4.stop();
  if (seSoftChime5.state == Ess.PLAYING)
    seSoftChime5.stop();
  if (seSoftChime6.state == Ess.PLAYING)
    seSoftChime6.stop();
  if (seSoftChime7.state == Ess.PLAYING)
    seSoftChime7.stop();
  if (seSoftChime8.state == Ess.PLAYING)
    seSoftChime8.stop();
  
  
  int rand = int(random(8));
  switch(rand)
  {
  case 0:
    seSoftChime1.play();
    break;
  case 1:
    seSoftChime2.play();
    break;
  case 2:
    seSoftChime3.play();
    break;
  case 3:
    seSoftChime4.play();
    break;
  case 4:
    seSoftChime5.play();
    break;
  case 5:
    seSoftChime6.play();
    break;
  case 6:
    seSoftChime8.play();
    break;
  default:
    seSoftChime8.play();
    break;
  }
}


//Multi Chimes
void playMultiChime()
{
  if (seMultiChime1.state == Ess.PLAYING)
    seMultiChime1.stop();
  if (seMultiChime2.state == Ess.PLAYING)
    seMultiChime2.stop();
  if (seMultiChime3.state == Ess.PLAYING)
    seMultiChime3.stop();
  if (seMultiChime4.state == Ess.PLAYING)
    seMultiChime4.stop();
  if (seMultiChime5.state == Ess.PLAYING)
    seMultiChime5.stop();
  if (seMultiChime6.state == Ess.PLAYING)
    seMultiChime6.stop();
  if (seMultiChime7.state == Ess.PLAYING)
    seMultiChime7.stop();
  
  int rand = int(random(7));
  switch(rand)
  {
  case 0:
    seMultiChime1.play();
    break;
  case 1:
    seMultiChime2.play();
    break;
  case 2:
    seMultiChime3.play();
    break;
  case 3:
    seMultiChime4.play();
    break;
  case 4:
    seMultiChime5.play();
    break;
  case 5:
    seMultiChime6.play();
    break;
  default:
    seMultiChime7.play();
    break;
  }
}


// Blocks
void playBlock()
{
  if (seBlock1.state == Ess.PLAYING)
    seBlock1.stop();
  if (seBlock2.state == Ess.PLAYING)
    seBlock2.stop();
  if (seBlock3.state == Ess.PLAYING)
    seBlock3.stop();
  if (seBlock4.state == Ess.PLAYING)
    seBlock4.stop();
  if (seBlock5.state == Ess.PLAYING)
    seBlock5.stop();
  if (seBlock6.state == Ess.PLAYING)
    seBlock6.stop();
  if (seBlock7.state == Ess.PLAYING)
    seBlock7.stop();
  if (seBlock8.state == Ess.PLAYING)
    seBlock8.stop();
  if (seBlock9.state == Ess.PLAYING)
    seBlock9.stop();
  if (seBlock10.state == Ess.PLAYING)
    seBlock10.stop();
  if (seBlock11.state == Ess.PLAYING)
    seBlock11.stop();
  if (seBlock12.state == Ess.PLAYING)
    seBlock12.stop();
  if (seBlock13.state == Ess.PLAYING)
    seBlock13.stop();
  if (seBlock14.state == Ess.PLAYING)
    seBlock14.stop();
  if (seBlock15.state == Ess.PLAYING)
    seBlock15.stop();
  
  
  int rand = int(random(15));
  switch(rand)
  {
  case 0:
    seBlock1.gain(10);
    seBlock1.play();
    break;
  case 1:
    seBlock1.gain(10);
    seBlock1.play();
    break;
  case 2:
    seBlock3.gain(6);
    seBlock3.play();
    break;
  case 3:
    seBlock4.gain(6);
    seBlock4.play();
    break;
  case 4:
    seBlock5.gain(4);
    seBlock5.play();
    break;
  case 5:
    seBlock6.gain(2);
    seBlock6.play();
    break;
  case 6:
    //seBlock8.gain(10);
    seBlock8.play();
    break;
  case 7:
    //seBlock8.gain(10);
    seBlock8.play();
    break;
  case 8:
    //seBlock9.gain(10);
    seBlock9.play();
    break;
  case 9:
    //seBlock10.gain(10);
    seBlock10.play();
    break;
  case 10:
    //seBlock11.gain(10);
    seBlock11.play();
    break;
  case 11:
    //seBlock12.gain(10);
    seBlock12.play();
    break;
  case 12:
    //seBlock13.gain(10);
    seBlock13.play();
    break;
  case 13:
    //seBlock15.gain(10);
    seBlock15.play();
    break;
  default:
    //seBlock15.gain();
    seBlock15.play();
    break;
  }
  println(rand);
}


//WinChime
void sePlayWin()
{
  seWinChime.play();
}


public void stopSound()
{
  Ess.stop();
  super.stop();
}


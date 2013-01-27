AudioChannel mainTheme;
AudioChannel seLevWin, seLevFail;
AudioChannel seGrow1, seGrow2, seGrow3, seGrow4;
AudioChannel seHalfHeart1, seHalfHeart2, seFullHeart;


int growCount = 0;
boolean dir = true;
boolean beatCheck = true;
int osc = 1000;

void setupSound()
{
  // start up Ess
  Ess.start(this);

  // load background songs into new AudioChannels
  mainTheme = new AudioChannel("Gynacalypso.mp3");
  
  // load win/lose sound effects
  seLevWin = new AudioChannel("LevWin.mp3");
  seLevFail = new AudioChannel("LevFail.mp3");
  
  // load grow sound effects
  seGrow1 = new AudioChannel("Grow1.mp3");
  seGrow2 = new AudioChannel("Grow2.mp3");
  seGrow3 = new AudioChannel("Grow3.mp3");
  seGrow4 = new AudioChannel("Grow4.mp3");
  
  seHalfHeart1 = new AudioChannel("HalfHeart1.mp3");
  seHalfHeart2 = new AudioChannel("HalfHeart2.mp3");
  seFullHeart = new AudioChannel("WholeHeart.mp3");
  seFullHeart.gain(5);

}


//
// Music
//

// Start the main theme
void playMainTheme()
{
  //println("main theme");
  mainTheme.gain(-5);
  mainTheme.play(Ess.FOREVER);
}

void stopMainTheme()
{
  if (mainTheme.state == Ess.PLAYING)
  {
    mainTheme.stop();
  }
}



//
// Sound Effects
//

//Win/Lose
void playWin()
{
  stopAllSE();
  seLevWin.play();
}

void playFail()
{
  stopAllSE();
  seLevFail.play();
}

void playGrow()
{
  stopAllSE();
  switch(growCount)
  {
    case 0:
      seGrow1.play();
      break;
    case 1:
      seGrow2.play();
      break;
    case 2:
      seGrow3.play();
      break;
    case 3:
      seGrow4.play();
      break;
    default:
      seGrow1.play();
      break;
  }
    
  if(growCount < 3 && dir)
    growCount++;
  else if (growCount > 0 && !dir)
    growCount--;
  else if (growCount == 0)
  {
    growCount++;
    dir = true; 
  }
  else // growCount == 3
  {
     growCount--;
     dir = false;
  }
}

void playWholeHeart()
{
   seFullHeart.play(); 
}

void soundLoop()
{
  if (millis()%osc <= 100)
  {
    if(beatCheck)
    {
      beatCheck = false;
      playWholeHeart();
    }
  }
  else
    beatCheck = true;
}

void stopAllSE()
{
  if (seGrow1.state == Ess.PLAYING)
    seGrow1.stop();
  if (seGrow2.state == Ess.PLAYING)
    seGrow2.stop();
  if (seGrow3.state == Ess.PLAYING)
    seGrow3.stop();
  if (seGrow4.state == Ess.PLAYING)
    seGrow4.stop();
  if (seLevWin.state == Ess.PLAYING)
    seLevWin.stop();
  if (seLevFail.state == Ess.PLAYING)
    seLevFail.stop();
}


/*
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
*/

public void stopSound()
{
  Ess.stop();
  super.stop();
}


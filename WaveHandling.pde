/**
* Checks to see if wave has been won or lost and handles game accordingly. 
* If wave has been won then the score is increased by the number of cities still alive and the number of bombs left over.
* A check is carried out to see if a city should and can be revived before the next wave of meteors
* are spawned through a method call and the ballistae are rest.
* If the wave has been lost then the game over message is displayed along with the wave number and the
* player's final score.
*/
void waveStatusCheck() {
  state s = waveStatusCheckCondition();//State of current city is acquired
  
  //Successful wave ended 
  if (s == state.won) {
    int aliveCityCount = 0;
    int bombCount = 0;
    int multiplier = scoreMultiplier();
    
    //Check to see how many cities are alive (cityState[i] == true) at the end of the round
    for(int i=0;i<cityState.length;i++){
      if(cityState[i])
        aliveCityCount++;
    }
    
    //Check to see how many bombs were left unused at the end of the round
    for(int i=0;i<ballistae.length;i++){
      if(ballistaState[i])
        bombCount += ballistae[i].bombCounter;
    }
    
    //Score is updated accordingly for the cities alive and bombs unused
    score+= aliveCityCount * (100 * multiplier);
    score+= bombCount * (5 * multiplier);
    
    //Check to see if city revival score threshold has been reached 
    if(score >= 10000){
      for(int i=0; i<cityState.length; i++)
        if(cityState[i] == false){//Check to see if there's a city to revive 
          cityState[i] = true;//City revived
          score-=10000;//'Active' score reduced by 10,000 to stop duplicate revivals
          citiesRevived++;//Number of cities revived incremented for total score purposes
          cityRevived = true;//Boolean that tracks if city has been recently revived set to true
          time = millis();//Time of city's revival stored
          return;
        }
    }
    
    addMeteors();//Next wave of meteor's created
    
    //Ballistae reset to start of round values
    for (int i=0; i<ballistae.length; i++) {
      ballistaState[i] = true;
      ballistae[i].bombCounter = 10;
    }
    //Total bomb count and number of bombs in play reset to start of round values
    bombCount = 30;
    bombsInPlay = 0;
    //Bomb statuses and explosion sizes reset to start of round values
    for (int i=0; i < explosions.length; i++) {
      bombs[i] = null;
      explosions[i] = 1;
    }
    
    //Round is lost
  }else if(s == state.lost){
    gameOver.play();
    gameOver.rewind();
    fill(240, 196, 32);
    textAlign(CENTER);
    
    textSize(30);
    text("GAME OVER", width/2, (height/2)-45);
    
    textSize(20);
    text("Wave:"+ wave, width/2, height/2-20);
    text("Score:"+ score, width/2, height/2+5);
    
    textSize(12);
    text("Press 0 to play again", width/2, (height/2)+30);
    text("Press 1 to return to the main menu", width/2, (height/2)+50);
    text("Press 2 to view the high score table", width/2, (height/2)+50);
    
    //Check to see user input to send user to correct screen, including restarting the game
    if(keyPressed == true &&  key == '0'){
       reset();
    }else if(keyPressed == true && key == '1'){
       screenView = menuScreen; 
    }
    
  }
}

/**
* Checks to see what the current status of the wave is.
*
* @param cityAlive Used to track if an alive city (true) is within the cityState array.
* @return the state of the wave. Won if cityAlive, but  every !(meteorState[]). Ongoing if 
* cityAlive and at least one meteorState[]. Lost if !cityAlive.
*/
state waveStatusCheckCondition() {
  boolean cityAlive = false;//Used to see if there is an alive city remaining

  //Loops through every boolean in cityState, checking for a true
  for (int i=0; i < cityState.length; i++) {
    if (cityState[i]) {//Alive city found
      cityAlive= true;//Alive city tracker set to true
    }
  }

  if (cityAlive) {//If there is a city alive
    //Loops through every boolean in the meteorState array to see if a meteor is still active
    for (int i=0; i<meteorState.length; i++) {
      if (meteorState[i]) {//Active meteor found
        return state.ongoing;//Meteors still on the go, so wave is ongoing
      }
    }
    return state.won;//No meteors on the go, but a city is alive, so wave has been won
  }else{
    return state.lost;//No cities alive, so wave has been lost
  }
}

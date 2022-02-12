void waveStatusCheck() {
  state s = waveStatusCheckCondition();
  
  //Successful wave ended 
  if (s == state.won) {
    int aliveCityCount = 0;
    int bombCount = 0;
    
    for(int i=0;i<cityState.length;i++){
      if(cityState[i] == true)
        aliveCityCount++;
    }
    
    for(int i=0;i<ballistae.length;i++){
      if(ballistaState[i] == true)
        bombCount += ballistae[i].bombCounter;
    }
        
    if(wave < 3){
       score+= aliveCityCount * 100;
       score+= bombCount * 5;
    }else if(wave < 5){
       score+= aliveCityCount * 200;
       score+= bombCount * 10;
    }else if(wave < 7){
       score+= aliveCityCount * 300;
       score+= bombCount * 15;
    }else if(wave < 9){
       score+= aliveCityCount * 400;
       score+= bombCount * 20;
    }else if(wave < 11){
       score+= aliveCityCount * 500;
       score+= bombCount * 25;
    }else{
       score+= aliveCityCount * 600;
       score+= bombCount * 30;
    }
    
    if(score >= 10000){
      for(int i=0; i<cityState.length; i++)
        if(cityState[i] == false){
          cityState[i] = true;
          score-=10000;
          citiesRevived++;
          cityRevived = true;
          time = millis();
          return;
        }
    }
    
    enemyCount=0;
    addMeteors();
    
    for (int i=0; i<ballistae.length; i++) {
      ballistaState[i] = true;
      ballistae[i].bombCounter = 10;
    }
    bombCount = 30;
    bombsInPlay = 0;
    for (int i=0; i < explosions.length; i++) {
      bombs[i] = null;
      explosions[i] = 1;
      println(explosions[i]);
    }
    
  }else if(s == state.lost){
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
    
    if(keyPressed == true &&  key == '0'){
       reset();
    }else if(keyPressed == true && key == '1'){
       screenView = menuScreen; 
    }
    
  }
}

state waveStatusCheckCondition() {
  boolean cityAlive = false;

  for (int i=0; i < cityState.length; i++) {
    if (cityState[i] == true) {
      cityAlive= true;
    }
  }

  if (cityAlive) {
    for (int i=0; i<meteorState.length; i++) {
      if (meteorState[i]==true) {
        return state.ongoing;
      }
    }
    return state.won;
  }else{
    return state.lost;
  }
}

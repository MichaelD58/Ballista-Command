/**
* A new wave is started. Using the previous wave's meteors count, a new wave count is acquired. New meteor, meteorState
* and meteorExplisions arrays are initialised. A terminal velocity for every meteor in that wave is acquired. For each meteor,
* their state is set to true and their explosion counter is set to 1. Its starting X and Y coordinate is also calculated. 
* Finally, the meteors are initialised in the meteors array using the previouslt acquired terminal velocity, start coordinates
* as well as a randomly generated starting velocity (both in the x and y directions).
*/
void addMeteors() {
  wave++;//New wave is started
  
  int previousCount;//Integer used to store the number of meteors in the wave before
  //Checks to see if the meteors array was initialised previously, getting its size. If it has
  //not been initialised before (wave 1), then the previous count is set to 4.
  if(meteors == null){
    previousCount = 4;
  }else{
    previousCount = meteors.length;
  }
  int meteorCount = previousCount + 1 + (int)Math.log(wave);//New meteor count is acquired
  
  meteors = new Meteor[meteorCount];//Array of meteors is initialised
  meteorState = new boolean[meteorCount];//Array of meteor's states is initialised
  meteorExplosions = new int[meteorCount];//Array of meteor's explosion counter is initialised
  
  float terminalVelocity = 0.9 + ((float)wave/10);//Terminal velocity of the meteors is acquired
  
  //For every meteor in the meteors array
  for (int i=0; i<meteors.length; i++) {
    meteorState[i]= true;
    meteorExplosions[i] = 1;

    int startX = (int)random(0, width);//Starting X coordinate is acquired
    int startY = (int)random(-(meteors.length * 100), 0);//Starting Y coordinate is acquired
    
    //Meteor is initialised in the meteors array
    meteors[i]=new Meteor(startX, startY, random(0, 3), random(0, 1) + (wave/10), 1, terminalVelocity);
  }
}

/**
* A simple check to see if any meteor has gone below the visible screen, setting said meteor's state to false in the
* meteorState array if that is indeed the case.
*/
void removeMeteorCheck() {
  for (int i=0; i<meteors.length; i++){
    if(meteors[i].position.y > height){
      meteorState[i] =false;
    }
  }
}

void explodeMeteorCheck(){
  for(int i = 0; i < meteors.length; i++){
    if(meteors[i].exploding){
      if(meteorExplosions[i] < 60){
          noStroke();
          fill(255,67,27);
          circle(meteors[i].position.x, meteors[i].position.y, meteorExplosions[i]);
     
          for (int j=0; j<meteors.length; j++) {
            if(meteorState[j] && explosionTouchingMeteors(j, i)){
              meteorState[j] = false;
              meteors[j].exploding = true;
              score += (25 * scoreMultiplier());
            }
          }
          
          meteorExplosions[i]+=2;
      }else{
        meteors[i].exploding = false;
      }
       
    }  
  }
}
  
boolean explosionTouchingMeteors(int j, int i){
 if((meteors[j].position.x <= meteors[i].position.x + meteorExplosions[i]) && (meteors[j].position.x >= meteors[i].position.x - meteorExplosions[i])){
   if((meteors[j].position.y <= meteors[i].position.y + meteorExplosions[i]) && (meteors[j].position.y >= meteors[i].position.y - meteorExplosions[i])){
     return true;
   }
 }
 
 return false;
}

boolean explosionTouchingMeteors(int j){
 if((meteors[j].position.x <= additionalEnemy.position.x + additionalEnemy.explodingCounter) && (meteors[j].position.x >= additionalEnemy.position.x - additionalEnemy.explodingCounter)){
   if((meteors[j].position.y <= additionalEnemy.position.y + additionalEnemy.explodingCounter) && (meteors[j].position.y >= additionalEnemy.position.y - additionalEnemy.explodingCounter)){
     return true;
   }
 }
 
 return false;
}

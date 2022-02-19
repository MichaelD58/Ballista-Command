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
  if(wave == 1){
    previousCount = 4;
  }else{
    previousCount = meteors.length;
  }
  int meteorCount = previousCount + 1 + (int)Math.log(wave);//New meteor count is acquired
  
  meteors = new Meteor[meteorCount];//Array of meteors is initialised
  meteorState = new boolean[meteorCount];//Array of meteor's states is initialised
  meteorExplosions = new int[meteorCount];//Array of meteor's explosion counter is initialised
  
  terminalVelocity = 0.9 + ((float)wave/10);//Terminal velocity of the meteors is acquired
  
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

/**
  * Check to see if a meteor is still to explode, continuing to draw the growing explosion if so. There is also a series of checks
  * to see if the meteor's explosion is colliding with both other meteors and the additional enemies. If collisions are detected, then
  * the thing being collided with is set to explode and the score is increased accordingly
  *
  * @param i an integer for the index of the meteor which explosion is being dealt with
  */
void explodeMeteorCheck(){
  for(int i = 0; i < meteors.length; i++){
    if(meteors[i].exploding){
      //If meteor has not fully exploded
      if(meteorExplosions[i] < 60){
          noStroke();
          fill(255,67,27);
          circle(meteors[i].position.x, meteors[i].position.y, meteorExplosions[i]);//Explosion is drawn
     
          //Check with every meteor to see if it is colliding with the meteor's explosion 
          for (int j=0; j<meteors.length; j++) {
            if(meteorState[j] && explosionTouchingMeteors(j, i)){
              meteorState[j] = false;//Meteor state set to false as it has been exploded
              meteors[j].exploding = true;//Meteor explosion state activated
              score += (25 * scoreMultiplier());
              meteorExploded.play();
              meteorExploded.rewind();
            }
          }
          
          //Check with the additional enemy to see if it is colliding with the meteor's explosion 
          if(wave > 1 && additionalEnemy.status && meteorExplosionTouchingAdditionalEnemy(i)){
            additionalEnemy.status = false;//Additional enemy state set to false as it has been exploded
            additionalEnemy.exploding = true;//Additional enemy explosion state activated
            score += (100 * scoreMultiplier());
            additionalEnemyExploded.play();
            additionalEnemyExploded.rewind();
          }
          
          meteorExplosions[i]+=2;
      }else{
        meteors[i].exploding = false;//Explosion is finished and explosion state is ended
      }
       
    }  
  }
}

/**
* Check to see if another meteor is within the meteor's explosion
*
* @param i an integer for the index of the meteor being checked
* @param j an integer for the index of the meteor which explosion is being checked against the meteor for a collision
* @return Boolean that represents whether there is a collision occuring
*/
boolean explosionTouchingMeteors(int j, int i){
 if((meteors[j].position.x <= meteors[i].position.x + meteorExplosions[i]) && (meteors[j].position.x >= meteors[i].position.x - meteorExplosions[i])){
   if((meteors[j].position.y <= meteors[i].position.y + meteorExplosions[i]) && (meteors[j].position.y >= meteors[i].position.y - meteorExplosions[i])){
     return true;
   }
 }
 
 return false;
}

boolean explosionTouchingMeteors(int j){
 if((meteors[j].position.x <= additionalEnemy.position.x + additionalEnemy.explodingCounter - 20) && (meteors[j].position.x >= additionalEnemy.position.x - additionalEnemy.explodingCounter + 20)){
   if((meteors[j].position.y <= additionalEnemy.position.y + additionalEnemy.explodingCounter - 20) && (meteors[j].position.y >= additionalEnemy.position.y - additionalEnemy.explodingCounter + 20)){
     return true;
   }
 }
 
 return false;
}

void split(){ 
  int counter = 0;
      
   for(int i = 0; i< meteors.length; i++){
     if(meteorState[i] && meteors[i].split == 1 && ((int)meteors[i].position.y == meteors[i].splitY)){
       for(int j = 0; j < meteorState.length; j++){
         if(!meteorState[j]){
            meteorState[i] = false;
            meteors[j] = new Meteor(meteors[i].position.x, meteors[i].position.y, random(0, 3), 1, 1, terminalVelocity);
            meteorState[j] = true;
            meteorExplosions[j] = 1;
            counter++;
         }
         if(counter == 3){
           break;
         }
       }
     }
   }
}

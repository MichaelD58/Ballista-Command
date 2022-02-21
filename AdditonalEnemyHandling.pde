/**
* Additional enemy is initialsed based on a set of random values for its X coordinate, object type
* X coordinates that it will fire at. Its Y coordinate is also decided based on what the wave number
* is
*/
void addAdditionalEnemy(){
  //https://stackoverflow.com/questions/21246696/generating-a-number-between-1-and-2-java-math-random
  //Randomiser for spawn side and enemy type
  int rdmGeneratorPostion = (Math.random() <= 0.5) ? 1 : 2;
  int rdmGeneratorObject = (Math.random() <= 0.5) ? 1 : 2;
  
  //Randomiser for the additional enemy's Y coordinate that increases as the wave number increases
  float startY = 0 + ((wave - 1) * 50);
  if(startY > 500){
    startY = 500;//Y coordinate caps out at 500
  }
  
  //Additional enemy is initialised
  if(rdmGeneratorPostion == 1){
      additionalEnemy = new AdditionalEnemy((float) -400,startY,1, 0, rdmGeneratorObject);
  }else{
      additionalEnemy = new AdditionalEnemy((float)width + 400,startY, -1, 0, rdmGeneratorObject);
  }
  
  
  //Additional enemy's fireAt array is filled with random X coordinates 
  for(int i = 0; i< additionalEnemy.fireAtX.length; i++){
      int x = (int)random(0, width);//Starting X coordinate for this meteor 
      additionalEnemy.fireAtX[i] = x;
  }
} 

/**
* Manages the movement of the additonal enemy by calling its integrate method and drawing it at the
* new position
*/
void additionalEnemyMovement(){
  additionalEnemy.integrate();
  additionalEnemy.draw();
}

/**
* Check to see if the additional enemy is within the bomb's explosion
*
* @param i an integer for the index of the bomb which explosion is being checked against the meteor for a collision
* @return Boolean that represents whether there is a collision occuring
*/
boolean bombExplosionTouchingAdditionalEnemy(int i) {
  if(additionalEnemy.type == 1){//Circle (satellite) collision detection
    if ((additionalEnemy.position.x <= bombs[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x >= bombs[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= bombs[i].position.y + explosions[i]- 20) && (additionalEnemy.position.y >= bombs[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }else{//Rectangle (bomber) collision detection
    if ((additionalEnemy.position.x <= bombs[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x + 50 >= bombs[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= bombs[i].position.y + explosions[i] -20) && (additionalEnemy.position.y + 20 >= bombs[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }
  return false;
}

/**
* Check to see if the additional enemy is within the meteor's explosion
*
* @param i an integer for the index of the bomb which explosion is being checked against the meteor for a collision
* @return Boolean that represents whether there is a collision occuring
*/
boolean meteorExplosionTouchingAdditionalEnemy(int i) {
  println(i);
  if(additionalEnemy.type == 1){//Circle (satellite) collision detection
    if ((additionalEnemy.position.x <= meteors[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x >= meteors[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= meteors[i].position.y + explosions[i]- 20) && (additionalEnemy.position.y >= meteors[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }else{//Rectangle (bomber) collision detection
    if ((additionalEnemy.position.x <= meteors[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x + 50 >= meteors[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= meteors[i].position.y + explosions[i] -20) && (additionalEnemy.position.y + 20 >= meteors[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }
  return false;
}

/**
* Check to see if the additional enemy is still to explode, continuing to draw the growing explosion if so. There is also a series of checks
* to see if the additional enemy's explosion is colliding with other meteors. If collisions are detected, then the meteor being
* collided with is set to explode and the score is increased accordingly
*/
void explodeAdditionalEnemyCheck(){
    if(additionalEnemy.exploding){
      //If additional enemy has not fully exploded
      if(additionalEnemy.explodingCounter < 70){
          noStroke();
          fill(255,67,27);
          if(additionalEnemy.type == 1){
            circle(additionalEnemy.position.x, additionalEnemy.position.y, additionalEnemy.explodingCounter);
          }else{
            circle(additionalEnemy.position.x + 25, additionalEnemy.position.y + 10, additionalEnemy.explodingCounter);
          }
          
          //Check with every meteor to see if it is colliding with the explosion 
          for (int j=0; j<meteors.length; j++) {
            if(meteorState[j] && explosionTouchingMeteors(j)){
              meteorState[j] = false;//Meteor state set to false as it has been exploded
              meteors[j].exploding = true;//Meteor explosion state activated
              score += (25 * scoreMultiplier());
              //Meteor explosion sound
              meteorExploded.play();
              meteorExploded.rewind();
            }
          }

          additionalEnemy.explodingCounter+=2;
      }else{
       additionalEnemy.exploding = false;//Explosion is finished and explosion state is ended
      }
       
    }  
}

/**
* Manages the firing of meteors out of the addittional enemy. Checks to see if the additional enemy has reached one
* of the X coordinates that a meteor is to be fired at, checks to see if a meteor has been used to fire and then initialises
* the meteor at the addtional enemy's position.
*/
void additionalEnemyFireMeteor(){ 
    for(int i = 0; i< additionalEnemy.fireAtX.length; i++){//For the three possible meteors that can be fired
      if(additionalEnemy.position.x == additionalEnemy.fireAtX[i]){//If the additional enemy is at the fire position
        for(int j = 0; j < meteorState.length; j++){
          if(!meteorState[j]){//If there is a meteor that has already been used (destroyed/fallen off the screen)
             meteors[j] = new Meteor(additionalEnemy.position.x, additionalEnemy.position.y, random(0, 3), 1, 1, terminalVelocity);//Initialises meteor at new coordinates
             meteorState[j] = true;
             meteorExplosions[j] = 1;
             break;
          }
        }
      }
    } 
}

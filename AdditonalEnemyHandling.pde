void addAdditionalEnemy(){
  //https://stackoverflow.com/questions/21246696/generating-a-number-between-1-and-2-java-math-random
  int rdmGeneratorPostion = (Math.random() <= 0.5) ? 1 : 2;
  int rdmGeneratorObject = (Math.random() <= 0.5) ? 1 : 2;
  
  float startY = 0 + ((wave - 1) * 50);
  if(startY > 500){
    startY = 500;
  }
  
  if(rdmGeneratorPostion == 1){
      additionalEnemy = new AdditionalEnemy((float) -400,startY,1, 0, rdmGeneratorObject);
  }else{
      additionalEnemy = new AdditionalEnemy((float)width + 400,startY, -1, 0, rdmGeneratorObject);
  }
  
  for(int i = 0; i< additionalEnemy.fireAtX.length; i++){
      int startX = (int)random(0, width);//Starting X coordinate for this meteor 
      additionalEnemy.fireAtX[i] = startX;
  }
} 

void additionalEnemyMovement(){
  additionalEnemy.integrate();
  additionalEnemy.draw();
}

boolean bombExplosionTouchingAdditionalEnemy(int i) {
  if(additionalEnemy.type == 1){
    if ((additionalEnemy.position.x <= bombs[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x >= bombs[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= bombs[i].position.y + explosions[i]- 20) && (additionalEnemy.position.y >= bombs[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }else{
    if ((additionalEnemy.position.x <= bombs[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x + 50 >= bombs[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= bombs[i].position.y + explosions[i] -20) && (additionalEnemy.position.y + 20 >= bombs[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }
  return false;
}

boolean meteorExplosionTouchingAdditionalEnemy(int i) {
  println(i);
  if(additionalEnemy.type == 1){
    if ((additionalEnemy.position.x <= meteors[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x >= meteors[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= meteors[i].position.y + explosions[i]- 20) && (additionalEnemy.position.y >= meteors[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }else{
    if ((additionalEnemy.position.x <= meteors[i].position.x + explosions[i] - 20) && (additionalEnemy.position.x + 50 >= meteors[i].position.x - explosions[i] + 20)) {
      if ((additionalEnemy.position.y <= meteors[i].position.y + explosions[i] -20) && (additionalEnemy.position.y + 20 >= meteors[i].position.y - explosions[i] + 20)) {
        additionalEnemy.status = false;
        return true;
      }
    }
  }
  return false;
}


void explodeAdditionalEnemyCheck(){
    if(additionalEnemy.exploding){
      if(additionalEnemy.explodingCounter < 70){
          noStroke();
          fill(255,67,27);
          if(additionalEnemy.type == 1){
            circle(additionalEnemy.position.x, additionalEnemy.position.y, additionalEnemy.explodingCounter);
          }else{
            circle(additionalEnemy.position.x + 25, additionalEnemy.position.y + 10, additionalEnemy.explodingCounter);
          }
          
          for (int j=0; j<meteors.length; j++) {
            if(meteorState[j] && explosionTouchingMeteors(j)){
              meteorState[j] = false;
              meteors[j].exploding = true;
              score += (25 * scoreMultiplier());
            }
          }

          additionalEnemy.explodingCounter+=2;
      }else{
       additionalEnemy.exploding = false;
      }
       
    }  
}

void additionalEnemyFireMeteor(){ 
    for(int i = 0; i< additionalEnemy.fireAtX.length; i++){
      if(additionalEnemy.position.x == additionalEnemy.fireAtX[i]){
        for(int j = 0; j < meteorState.length; j++){
          if(!meteorState[j]){
             meteors[j] = new Meteor(additionalEnemy.position.x, additionalEnemy.position.y, random(0, 3), 1, 1, terminalVelocity);
             meteorState[j] = true;
             meteorExplosions[j] = 1;
             break;
          }
        }
      }
    } 
}

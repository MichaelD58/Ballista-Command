void addMeteors() {
  wave++;

  meteors = new Meteor[newMeteorCount(wave)];
  meteorState = new boolean[meteors.length];
  meteorExplosions = new int[meteors.length];
  
  for (int i=0; i<meteors.length; i++) {
    meteorState[i]= true;

    int startX= (int)random(0, width);
    int startY= (int)random(-(meteors.length * 100), 0);
    float terminalVelocity = 0.9 + ((float)wave/10);
    
    meteors[i]=new Meteor(startX, startY, (int)random(0, 3), (int)random(1, 2) + (wave/10), 1, terminalVelocity);
    meteorExplosions[i] = 1;
  }
}

void removeMeteorCheck() {
  for (int i=0; i<meteors.length; i++){
    if(meteors[i].position.y > height){
      meteorState[i] =false;
    }
  }
}

int newMeteorCount(int wave){
  int meteorCount = 0;
  
  if (wave<6){
      meteorCount = 5 + ((wave  - 1) *2);
    }else if (wave<11){
      meteorCount = (int)(5 + ((wave  - 1) * 2.5));
    }else if (wave<16){
      meteorCount = 5 + ((wave  - 1) *3);
    }else if (wave<21){
      meteorCount = (int)(5 + ((wave  - 1) *3.5));
    }else if (wave<26){
      meteorCount = 5 + ((wave  - 1) * 4);
    }else if(wave<31){
      meteorCount = (int)(5 + ((wave  - 1) * 4.5));
    }
    
    return meteorCount;
}

void explodeMeteor(int i){
  if(meteorExplosions[i] < 35){
    for(meteorExplosions[i] = 1; meteorExplosions[i] < 35; meteorExplosions[i]++){
       noStroke();
       fill(255,67,27);
       circle(meteors[i].position.x, meteors[i].position.y, 35);
       println("hello" + meteorExplosions[i]);
     
      for (int j=0; j<meteors.length; j++) {
        if(meteorState[j] && explosionTouchingMeteors(j, i)){
          meteorState[j] = false;
          score += (25 * scoreMultiplier());
          explodeMeteor(j);
        }
      }
    }  
  }
}

boolean explosionTouchingMeteors(int j, int i){
 if((meteors[j].position.x <= meteors[i].position.x + 35) && (meteors[j].position.x >= meteors[i].position.x - 35)){
   if((meteors[j].position.y <= meteors[i].position.y + 35) && (meteors[j].position.y >= meteors[i].position.y - 35)){
     return true;
   }
 }
 
 return false;
}

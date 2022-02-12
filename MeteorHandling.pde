void addMeteors() {
  wave++;

  meteors = new Meteor[newMeteorCount(wave)];
  meteorState = new boolean[meteors.length];
  
  for (int i=0; i<meteors.length; i++) {
    meteorState[i]= true;

    int startX= (int)random(0, width);
    int startY= (int)random(-(meteors.length * 100), 0);
    float terminalVelocity = 0.9 + ((float)wave/10);
    
    meteors[i]=new Meteor(startX, startY, (int)random(0, 3), (int)random(1, 2) + (wave/10), 1, terminalVelocity);
  }
}

void removeMeteorCheck() {
  for (int i=0; i<meteors.length; i++){
    meteorState[i] = meteors[i].meteorUsed();
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

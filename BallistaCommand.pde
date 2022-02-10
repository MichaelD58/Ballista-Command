final int menuScreen = 0,
  gameScreen = 1;

int screenView = menuScreen,
  score,
  wave,
  enemyCount;

boolean cityState[],
  ballistaState[],
  meteorState[];

City cities[];

Ballista ballistae[];

City city ;

Meteor meteors[];

PFont atari;

PVector gravityMain;

float velocity;

void setup() {
  size(1000, 700);
  noCursor();
  reset();
}

enum state {
  ongoing,
  won,
  lost
}

void reset() {
  score = 0;
  wave = 0;
  enemyCount = 0;
  gravityMain = new PVector(0, height/18000000f);
  addMeteors();
  cities = new City[6];
  cityState = new boolean[cities.length];
  for (int i=0; i<cityState.length; i++) {
    cityState[i]=true;
  }

  ballistae = new Ballista[3];
  ballistaState=new boolean[ballistae.length];
  for (int i=0; i<ballistaState.length; i++) {
    ballistaState[i]=true;
  }
}

void draw() {
  background(0);
  noStroke();
  atari = createFont("PressStart2P-vaV7.ttf", 18);
  textFont(atari);

  if(screenView == gameScreen){
    textAlign(LEFT);
    fill(240, 196, 32);
    text("Score: "+(score), 5, 25);
    fill(240, 196, 32);
    text("Wave: "+wave, (width/2)-65, 25);
    for (int i=0; i<meteorState.length; i++) {
      if (meteorState[i]==true) {
        enemyCount++;
      }
    }
    text("Meteors left:"+ enemyCount, width-290, 25);

    for (int i=0; i < meteors.length; i++) {
      removeMeteor();
      PVector position = meteors[i].position;
      if (meteorState[i] == true) {
        meteors[i].integrate(gravityMain);
        fill(250) ;
        circle(position.x, position.y, 13);
      }
      drawCities();
      drawBallistae();
    }

    waveStatusCheck();
    enemyCount = 0;
    crosshair();
  }
  
  if (screenView == 0) {
    background(0);

    textSize(40);
    textAlign(CENTER);
    fill(240, 196, 32);
    text("Ballista Command", width/2, 200);
    textSize(18);
    text("0. Play Game", width/2, 270);

    if (key== '0') {
      screenView = gameScreen;
    }
  }
}

void crosshair() {
  stroke(250);
  line(mouseX-4, mouseY-4, mouseX, mouseY);
  line(mouseX+4, mouseY+4, mouseX, mouseY);
  line(mouseX+4, mouseY-4, mouseX, mouseY);
  line(mouseX-4, mouseY+4, mouseX, mouseY);
}

void drawCities() {
  int rect[]= new int[4];
  
  for (int i=0; i<cities.length; i++) {
    if (i < 3) {
      rect[0]= (i * (width/10))+((width/10) + 58);
    } else {
      rect[0]= (i * (width/10))+((width/10) + 198);
    }
    rect[1]= height - 20;
    rect[2]= width/23;
    rect[3]= height/35;

    cities[i]=new City(rect[0], rect[1], rect[2], rect[3]);
    cities[i].draw();
  }
}

void drawBallistae() {
  ballistae[0]=new Ballista(60, height - 40, 15, height, 105, height);
  ballistae[1]=new Ballista((width/2), height - 40, (width / 2) - 45, height, (width/2) + 45, height);
  ballistae[2]=new Ballista(width - 60, height - 40, width - 105, height, width - 15, height);

  for (int i=0; i<ballistae.length; i++) {
    ballistae[i].draw();
  }
}

void addMeteors() {
  wave++;

  meteors = new Meteor[newMeteorCount(wave)];
  meteorState=new boolean[meteors.length];
  
  for (int i=0; i<meteors.length; i++) {
    meteorState[i]= true;

    //randomly assigning a starting position for the meteor above the visible screen
    int startX= (int)random(0, width);
    int startY=(int)random(-(meteors.length*100), 0);
    float terminalVelocity = 0.9 + ((float)wave/10);
    
    meteors[i]=new Meteor(startX, startY, (int)(random(0, 3) + (wave/5)), (int)random(1, 2), 1, terminalVelocity);
  }
}

void removeMeteor() {
  for (int i=0; i<meteors.length; i++)
    meteorState[i]=meteors[i].meteorUsed();
}

void waveStatusCheck() {

  //if the wave was passed
  if (waveStatusCheckCondition() == state.won) {
    //for(int i=0;i<city_dead.length;i++)
    //  if(city_dead[i]==false)
    //    score+=(100*(wave>10 ? 6 :((wave+1)/2)));
    //  score+=((30-active_missile_counter)*5*(wave>10?6:((wave+1)/2)));
    //if(score>=10000){
    //  for(int i=0;i<city_dead.length;i++)
    //    if(city_dead[i] && score >=10000){
    //      city_dead[i]=false;
    //      score-=10000;
    //      score_reduction+=10000;
    //    }
    //}
    enemyCount=0;
    addMeteors();

    //add_silos();
    //active_missile_counter=0;
  }

  ////if the wave failed
  //if(waveStatusCheckCondition() == 2){
  //  fill(30,64,99);
  //  textAlign(CENTER);
  //  textSize(23);
  //  text("You Lose!",width/2,(height/2)-45);
  //  text("Wave:"+wave,width/2,height/2-20);
  //  text("Score:"+(score + score_reduction),width/2,height/2+5);
  //  textSize(12);
  //  text("Press Spacebar to Try Again.",width/2, (height/2)+30);
  //  if(keyPressed==true && key==' '){
  //      reset=true;
  //      start();
  //  }
  //}
}

state waveStatusCheckCondition() {
  boolean cityAlive = false;

  for (int i=0; i<meteorState.length; i++) {
    if (meteorState[i]==true) {
      return state.ongoing;
    }
  }

  for (int i=0; i<cityState.length; i++) {
    if (cityState[i] == true) {
      cityAlive= true;
    }
  }

  if (cityAlive) {
    return state.won;
  } else {
    return state.lost;
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

final int menuScreen = 0,
  gameScreen = 1;

int screenView = menuScreen,
  score,
  wave,
  enemyCount,
  bombsInPlay;

//State arrays used to store if the objects in the names are alive or dead (true or false)
boolean cityState[],
  ballistaState[],
  meteorState[];

City cities[];//Array storing each city

Ballista ballistae[];//Array storing each ballistae

Meteor meteors[];

Bomb bombs[];

PFont atari;

PVector gravityMain;

float velocity;

enum state {
  ongoing,
  won,
  lost
}

void setup() {
  size(1000, 700);
  noCursor(); //Dont want the cursor appearing when playing the game
  reset();//Calls the reset function which initialises many of the game's variables as well as begins the game
}

//Method to initialise many of the game's variables
void reset() {
  score = 0;
  wave = 0;
  enemyCount = 0;
  gravityMain = new PVector(0, height/18000000f);
  
  bombs = new Bomb[30];
  newBallistae();
  addMeteors();
  
  //Array of cities is initialised along with the array used to store the state of each city
  cities = new City[6];
  cityState = new boolean[cities.length];
  for (int i=0; i<cityState.length; i++) {
    cityState[i]=true;
  }

  //Array of ballistae is initialised along with the array used to store the state of each ballista
  ballistae = new Ballista[3];
  ballistaState=new boolean[ballistae.length];
  for (int i=0; i<ballistaState.length; i++) {
    ballistaState[i]=true;
  }
  
}

void draw() {
  background(0);//Black background for greatest contrast with all colours
  noStroke();//To prevent outlines for the ballistae and cities
  atari = createFont("PressStart2P-vaV7.ttf", 18);
  textFont(atari);

  if(screenView == gameScreen){
    
    for (int i=0; i < meteors.length; i++) {
      removeMeteor();
      PVector position = meteors[i].position;
      if (meteorState[i] == true) {
        meteors[i].integrate(gravityMain);
        fill(145, 49, 42);
        circle(position.x, position.y, 10);
      }
      drawCities(position.x, position.y);
      drawBallistae(position.x,position.y);
    }
    
    textAlign(LEFT);
    fill(240, 196, 32);
    text("Score:"+(score), 5, 25);
    fill(240, 196, 32);
    text("Wave:"+wave, (width/2)-65, 25);
    for (int i=0; i<meteorState.length; i++) {
      if (meteorState[i]==true) {
        enemyCount++;
      }
    }
    text("Meteors left:"+ enemyCount, width-290, 25);

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

    if (keyPressed==true &&  key == '0') {
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

//Method to fill the cities array and then draw them
void drawCities(float x,float y) {
  int rect[]= new int[4];
  
  //For the six cities
  for (int i=0; i<cities.length; i++) {//For every city
    //Check to see what group the city belongs to
    if (i < 3) {
      rect[0]= (i * (width/10))+((width/10) + 58);//First three
    } else {
      rect[0]= (i * (width/10))+((width/10) + 198);//Second three
    }
    rect[1]= height - 20;//Top-left y-coordinate
    rect[2]= width/23;//Width
    rect[3]= height/35;//Height

    cities[i]=new City(rect[0], rect[1], rect[2], rect[3]);//Added to the cities array

    if(cities[i].checkState(x,y) && cityState[i]==true){
      cities[i].draw();//City is drawn
    }else{
      cityState[i]=false;
    }
    
  }
}

//Method to fill the ballistae array
void newBallistae() {
  ballistae[0]=new Ballista(60, height - 40, 15, height, 105, height);//Left-most ballista
  ballistae[1]=new Ballista((width/2), height - 40, (width / 2) - 45, height, (width/2) + 45, height);//Center ballista
  ballistae[2]=new Ballista(width - 60, height - 40, width - 105, height, width - 15, height);//Right-most ballista
  
}

//Method to draw the ballistae
void drawBallistae(float x,float y) {
  //All three ballistae are drawn
  for (int i=0; i<ballistae.length; i++) {
    
    if(!(ballistae[i].checkState(x,y) && ballistaState[i])){
      ballistaState[i] = false;
      ballistae[i].bombCounter = 0;
    }
    
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
    
    meteors[i]=new Meteor(startX, startY, (int)random(0, 3), (int)random(1, 2) + (wave/10), 1, terminalVelocity);
  }
}

void removeMeteor() {
  for (int i=0; i<meteors.length; i++)
    meteorState[i] = meteors[i].meteorUsed();
}

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
    //if(score>=10000){
    //  for(int i=0;i<city_dead.length;i++)
    //    if(city_dead[i] && score >=10000){
    //      city_dead[i]=false;
    //      score-=10000;
    //      score_reduction+=10000;
    //    }
    //}
    enemyCount=0;
    bombsInPlay = 0;
    newBallistae();
    addMeteors();
    
    for (int i=0; i<ballistae.length; i++) {
      ballistaState[i] = true;
      ballistae[i].bombCounter = 10;
    }
    bombCount = 30;
    
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
    
    if(keyPressed==true &&  key == '0'){
       reset();
    }else if(keyPressed==true && key == '1'){
       screenView = menuScreen; 
    }
    
  }
}

state waveStatusCheckCondition() {
  boolean cityAlive = false;

  for (int i=0; i<cityState.length; i++) {
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

void keyPressed(){
  if(screenView == gameScreen){
    if(keyPressed==true && (key == 'z' || key == 'x' || key == 'c')){
      if(waveStatusCheckCondition() != state.lost && bombsInPlay < 30){
        int x = mouseX;
        int y = (height - mouseY);
        int ballista;
      
        if(key == 'z'){
          ballista = 0;
        }else if(key == 'x'){
          ballista = 1;
        }else 
          ballista = 2;
      
        fireBomb(ballista, x, y);
      }
    }
  }
}

void fireBomb(int chosenBallista, int x, int y){
      
  //if(s[origin].missile_counter==0){
  //   switch(origin){
  //      case 0:{if(s[1].missile_counter!=0) origin=1; else if(s[2].missile_counter!=0) origin=2; }break;
  //      case 1:{ origin= (int)mtargetx/400; if(origin==1) origin=2; if(s[0].missile_counter==0) origin=2; else if(s[2].missile_counter==0) origin=0;}break;
  //      case 2:{if(s[1].missile_counter!=0) origin=1; else if(s[0].missile_counter!=0) origin=0; }break;
  //   }
  //}
  
  ballistae[chosenBallista].createBomb((ballistae[chosenBallista].x2 + ballistae[chosenBallista].x3)/2, ballistae[chosenBallista].y1, (float)(x-((ballistae[chosenBallista].x1 + ballistae[chosenBallista].x2)/2))/23,(float)-y/23,1);
  bombs[bombsInPlay++] = ballistae[chosenBallista].bomb;

}

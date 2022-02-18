void setup() {
  frameRate(30);
  size(1000, 700);
  noCursor(); //Dont want the cursor appearing when playing the game
  reset();//Calls the reset function which initialises many of the game's variables as well as begins the game
}

/**
* Method to initialise many of the game's variable
*/
void reset() {
  score = 0;
  wave = 0;
  enemyCount = 0;//Numbers of meteors in play
  gravityMain = new PVector(0, height/18000000f);//Constant for the impact of gravity
  bombsInPlay = 0;
  
  bombs = new Bomb[30];
  explosions = new int[30];
  for(int i = 0; i < explosions.length; i++){
    explosions[i] = 1;
  }
  
  //Array of cities is initialised along with the array used to store the state of each city
  cities = new City[6];
  cityState = new boolean[cities.length];
  for (int i=0; i<cityState.length; i++) {
    cityState[i]=true;
  }
  citiesRevived = 0;
  cityRevived = false;

  //Array of ballistae is initialised along with the array used to store the state of each ballista
  ballistae = new Ballista[3];
  ballistaState=new boolean[ballistae.length];
  for (int i=0; i<ballistaState.length; i++) {
    ballistaState[i]=true;
  }
  
  addMeteors();//First round is started by generating new meteors
  createBallistae();//Method is called to initialise the first wave's ballistae
  
}

void draw() {
  background(0);//Black background for greatest contrast with all colours
  noStroke();//To prevent outlines for the ballistae and cities
  atari = createFont("PressStart2P-vaV7.ttf", 18);//Importing downloaded font
  textFont(atari);//Setting font to the imported font

  //Check to see if the game is to be shown
  if(screenView == gameScreen){
    
    //For every meteor
   for (int i=0; i < meteors.length; i++) {
      removeMeteorCheck();//Check to see if meteor is out of bounds
      PVector position = meteors[i].position;
      if (meteorState[i]){//Check to see if meteor is still active
        meteors[i].integrate(gravityMain);//Meteor's integrate function is called
        fill(145, 49, 42);
        circle(position.x, position.y, 10);//Visual representation of the meteor is displayed
      }
      drawCities(position.x, position.y);//Function to draw the cities and check for meteor collision
      drawBallistae(position.x,position.y);//Function to draw the ballistae and check for meteor collision
    }
    
    //For loop used to acquire a count of every meteor which has as active state (true)
    for (int i=0; i <meteorState.length; i++) {
      if (meteorState[i] == true) {
        enemyCount++;
      }
    }
    
    textAlign(LEFT);
    fill(240, 196, 32);
    text("Score:" + (score + (citiesRevived * cityReviveCost)), 5, 25);//User's score
    text("Wave:"+ wave, (width/2)-65, 25);//Wave number
    text("Meteors left:"+ enemyCount, width-290, 25);//Meteors left in wave

    waveStatusCheck();//Check to see what the current state of the wave is
    bombMovement();
    bombSetOffCheck();
    explodeMeteorCheck();
    
    
    textAlign(CENTER);
    textSize(20);
    
    if(cityRevived){
      fill(240, 196, 32);
      
      if( millis() < time + 2000){
        text("City Rebuilt!", width/2, 200);
      }else{
        cityRevived = false;
      }
    }
    
    if(wave > 1){
      if(enemyCount == 0){
        addAdditionalEnemy(); 
      }
      additionalEnemyMovement();
      explodeAdditionalEnemyCheck();
      additionalEnemyFireMeteor();
    }
    
    enemyCount = 0;//Active meteor count is set back to 0 so that it can be refreshed with each frame
    crosshair();//Crosshair details are drawn
  }
  
  //Check to see if the menu is to be shown
  if (screenView == menuScreen) {
    background(0);
    textSize(40);
    textAlign(CENTER);
    
    fill(240, 196, 32);
    text("Ballista Command", width/2, 200);
  
    textSize(18);
    text("0. Play Game", width/2, 270);

    //Check(s) for user input for menu interaction
    if(keyPressed==true &&  key == '0') {
      screenView = gameScreen;
    }
  }
}

//Crosshair draw details
void crosshair() {
  stroke(250);
  line(mouseX-4, mouseY-4, mouseX+4, mouseY+4);
  line(mouseX+4, mouseY-4, mouseX-4, mouseY+4);
}

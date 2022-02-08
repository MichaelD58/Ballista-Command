final int menuScreen = 0,
          gameScreen = 1;
          
int screenView = menuScreen,
    score,
    wave,
    enemyCount;
    
boolean cityState[],
        ballistaState[],
        fullScreenToggled = true;
        
City cities[];

Ballista ballistae[];
    
City city ;

PFont atari;

void setup() {
  size(1000,700);
  noCursor();
  reset();
}

void reset(){
  score = 0;
  wave = 0;
  enemyCount = 0;
  
  cities = new City[6];
  cityState = new boolean[cities.length];
  for(int i=0;i<cityState.length;i++){
    cityState[i]=true;
  }
  
  ballistae = new Ballista[3];
  ballistaState=new boolean[ballistae.length];
  for(int i=0;i<ballistaState.length;i++){
    ballistaState[i]=true;
  }
}

void draw(){
 background(0);
 atari = createFont("PressStart2P-vaV7.ttf", 18);
 textFont(atari);
 textAlign(LEFT);
    fill(240,196,32);
    text("Score: "+(score),5,25);
    fill(240,196,32);
    text("Wave: "+wave,(width/2)-65,25);
    //for(int i=0;i<particle_dead.length;i++)
    //  if(particle_dead[i]==false)
        //particle_count++;
    text("Meteors left: "+ enemyCount,width-290,25);
    
    drawCities();
    drawBallistae();
    
    if(screenView == 0){
    background(0);
    
    textSize(40);
    textAlign(CENTER);
    fill(240,196,32);
    text("Ballista Command",width/2,200);
    textSize(18);
    text("0. Play Game",width/2,270);
    
      if (key== '0'){
        screenView = gameScreen;
      }
    
    }
    crosshair();
}

void crosshair(){
  stroke(250);
  line(mouseX-4,mouseY-4,mouseX,mouseY);
  line(mouseX+4,mouseY+4,mouseX,mouseY);
  line(mouseX+4,mouseY-4,mouseX,mouseY);
  line(mouseX-4,mouseY+4,mouseX,mouseY);
  noStroke();
  fill(250);
}

void drawCities(){
  int rect[]= new int[4];
  for(int i=0;i<cities.length;i++){
    if(i < 3){
      rect[0]= (i * (width/10))+((width/10) + 58);
    }else{
      rect[0]= (i * (width/10))+((width/10) + 198);
    }
    rect[1]= height - 20;
    rect[2]= width/23;
    rect[3]= height/35;
   
    cities[i]=new City(rect[0],rect[1],rect[2],rect[3]);
    cities[i].draw();
  }
}

void drawBallistae(){
  ballistae[0]=new Ballista(60,height - 40,15,height, 105, height);
  ballistae[1]=new Ballista((width/2),height - 40, (width / 2) - 45,height, (width/2) + 45, height);
  ballistae[2]=new Ballista(width - 60,height - 40,width - 105 ,height, width - 15, height);
  
  for(int i=0;i<ballistae.length;i++){
    ballistae[i].draw();
  }
}

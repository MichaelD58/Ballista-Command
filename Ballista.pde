class Ballista{
  float x1, y1, x2, y2, x3, y3;
  
  int bombCounter;//Number of bombs the ballista is currently holding
  
  Bomb bomb;
  
  Ballista(float x1, float y1, float x2, float y2, float x3, float y3){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.x3 = x3;
    this.y3 = y3;
    bombCounter = 10;
  }
  
  void draw() {
    fill(0, 250 , 0) ;
    triangle(x1, y1, x2, y2, x3, y3) ;
    textAlign(CENTER);
    //Check to see if the ballista has ran out of bombs, if so count colour will be red
    if (bombCounter > 0){
      fill(255);
    }else{
      fill(255, 0, 0);
    }
    text(bombCounter,((x2+x3)/2),(y1+height + 27)/2); 
  }
  
  boolean checkState(float meteorX, float meteorY){
    //http://www.jeffreythompson.org/collision-detection/tri-point.php
    float actualArea = abs( (x2-x1)*(y3-y1) - (x3-x1)*(y2-y1) );
    
    float area1 = abs( (x1-meteorX)*(y2-meteorY) - (x2-meteorX)*(y1-meteorY) );
    float area2 = abs( (x2-meteorX)*(y3-meteorY) - (x3-meteorX)*(y2-meteorY) );
    float area3 = abs( (x3-meteorX)*(y1-meteorY) - (x1-meteorX)*(y3-meteorY) );
  
    if (area1 + area2 + area3 == actualArea) {
      return false;
    }
  
    return true;
  }
  
  void createBomb(float x, float y, float vel1, float vel2, int invMass){
    if(bombCounter>0){
      bomb = new Bomb(x, y, vel1, vel2, invMass);
      bombCounter--;
    }
  }
  
}

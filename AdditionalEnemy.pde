class AdditionalEnemy{
  
  public PVector velocity, position;
  
  boolean status,
          exploding;
  
  int type,
      explodingCounter;
  
  int fireAtX[];
  
  AdditionalEnemy(float x, float y, float vel1, float vel2, int objType){
    velocity = new PVector(vel1, vel2);
    position = new PVector(x, y);
    status = true;
    exploding = false;
    type = objType;
    explodingCounter = 1;
    fireAtX = new int[3];
  }
  
  void draw() {
    if(status){
      noStroke();
      fill(145, 49, 42);
      if(type == 1){
         circle(position.x,position.y,40);
      }else{
         rect(position.x,position.y,50, 20);
      }
     
    }
  }
  
  void integrate() {
     position.add(velocity) ;//Position is updated according to the velocity vector   
  }
  
}

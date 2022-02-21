class AdditionalEnemy{
  
  public PVector velocity, position;
  
  boolean status,
          exploding;//Tracks if the additional enemy is currently exploding
  
  int type,//Tracks the type of the additional enemy (bomber or satellite)
      explodingCounter;
  
  int fireAtX[];//The x coordinate at which the additional enemy can shoot meteors
  
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
      //Draws shape based on what type of additional enemy it is
      if(type == 1){
         circle(position.x,position.y,40);//Satellite
      }else{
         rect(position.x,position.y,50, 20);//Bomber
      }
     
    }
  }
  
  /**
  * Updates the position vector of the additional enemy using the velocity
  */
  void integrate() {
     position.add(velocity) ;//Position is updated according to the velocity vector   
  }
  
}

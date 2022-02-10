class Meteor{
  
  public PVector velocity, position, acceleration;
  
  final float drag = 0.995f;
  
  boolean status;
  
  int invMass;
  
  float terminalVelocity;
  
  Meteor(int x, int y, float vel1, float vel2, int m, float tv){
    velocity = new PVector(vel1, vel2);
    position = new PVector(x, y);
    acceleration= new PVector();
    invMass = m;
    status = true;
    terminalVelocity = tv;
  }
  
  void integrate(PVector gravity) {
    if (invMass <= 0) return ;//We don't integrate objects with infinite mass
     
     position.add(velocity) ;
    
     acceleration.add(gravity);
     acceleration.mult(invMass); 
    
     if(acceleration.y > 0.2){
       acceleration.y = 0.2;
     }
     
     if(velocity.y <= terminalVelocity){
      velocity.add(acceleration);
      velocity.mult(drag);
     }
    println(terminalVelocity + " " + velocity.y);
    
    if((position.x < 0) || (position.x > width)){
      velocity.x = -velocity.x ;
    }
  }
  
  boolean meteorUsed(){
    if(position.y > height - 13){
      status = false;
      return false;
    }else{
      return true;
    }
  }
  
}

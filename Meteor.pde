class Meteor{
  
  public PVector velocity, position, acceleration;
  
  final float drag = 0.995f;
    
  int invMass;
  
  float terminalVelocity;
  
  boolean exploding;
  
  Meteor(float x, float y, float vel1, float vel2, int m, float tv){
    velocity = new PVector(vel1, vel2);
    position = new PVector(x, y);
    acceleration= new PVector();
    invMass = m;
    terminalVelocity = tv;
    exploding = false;
  }
  
  void integrate(PVector gravity) {
    if (invMass <= 0) return ;//We don't integrate objects with infinite mass
     
     position.add(velocity) ;
    
     acceleration.add(gravity);
     acceleration.mult(invMass); 
     
     if(velocity.y <= terminalVelocity){
      velocity.add(acceleration);
      velocity.mult(drag);
     }
    
    if((position.x < 0) || (position.x > width)){
      velocity.x = -velocity.x ;
    }
  }
  
}

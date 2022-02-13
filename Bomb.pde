class Bomb{
  
  public PVector velocity, position, acceleration;
  
  final float drag = 0.995f;
  
  boolean status,
          active;
  
  int invMass;
  
  Bomb(float x, float y, float vel1, float vel2, int m){
    velocity = new PVector(vel1, vel2);
    position = new PVector(x, y);
    acceleration= new PVector();
    invMass = m;
    status = false;
    active = false;
  }
  
  void integrate(PVector gravity) {
    if (invMass <= 0) return ;//We don't integrate objects with infinite mass
     
     position.add(velocity) ;
    
     acceleration.add(gravity);
     acceleration.mult(invMass); 
    
     velocity.add(acceleration);
     velocity.mult(drag);
  }
 
}

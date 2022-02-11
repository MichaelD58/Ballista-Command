class Bomb{
  
  public PVector velocity, position, acceleration;
  
  final float drag = 0.9999f;
  
  boolean status;
  
  int invMass;
  
  Bomb(float x, float y, float vel1, float vel2, int m){
    velocity = new PVector(vel1, vel2);
    position = new PVector(x, y);
    acceleration= new PVector();
    invMass = m;
    status = true;
  }
  
  void integrate(PVector gravity) {
    if (invMass <= 0) return ;//We don't integrate objects with infinite mass
     
     position.add(velocity) ;
    
     acceleration.add(gravity);
     acceleration.mult(invMass); 
    
     velocity.add(acceleration);
     velocity.mult(drag);
  }
  
  boolean bombUsed(){
    if(position.y > height){
      status = false;
      return false;
    }else{
      return true;
    }
  }
}

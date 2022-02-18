class Meteor{
  
  public PVector velocity, position, acceleration;
  
  final float drag = 0.995f;//Pre-defined constant representing drag
    
  int invMass;//The iMass of the meteor
  
  float terminalVelocity;//Float used to store the top Y velocity that a meteor can reach
  
  boolean exploding;
  
  int split,
      splitY;
  
  Meteor(float x, float y, float vel1, float vel2, int m, float tv){
    velocity = new PVector(vel1, vel2);
    position = new PVector(x, y);
    acceleration= new PVector();
    invMass = m;
    terminalVelocity = tv;
    exploding = false;
    split = (int) (Math.random()*(9)) + 1;
    splitY = (int)random(0, height);
  }
  
  /**
  * Updates the vectors of the meteor. The velocity vector is not updated after terminal velocity has been reached.
  * Also handles negative mass as well as a check to ensure that meteors bounce off of the screen walls instead of 
  * going out of bounds.
  *
  * @param gravity The constant reperesenting gravity for this implementation that will be applied
  * to the acceleration vector.
  */
  void integrate(PVector gravity) {
    if (invMass <= 0) return ;//We don't integrate objects with infinite mass
     
     position.add(velocity) ;//Position is updated according to the velocity vector
    
     //Acceleration vector is updated according to the gravatational constant as well as the object's mass
     acceleration.add(gravity);
     acceleration.mult(invMass); 
     
     //Check to see if the terminal velocity has been reached. If not, the velocity
     //is manipulated towards it.
     if(velocity.y < terminalVelocity){
      //Velocity vector is updated according to the accelerationv vector as well as the drag constant
      velocity.add(acceleration);
      velocity.mult(drag);
     }
    
    //Used to keep all meteors in bounds by bouncing off the screen 'walls'
    if((position.x < 0) || (position.x > width)){
      velocity.x = -velocity.x ;
    }
  }
  
}

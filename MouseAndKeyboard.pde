/**
* The details for the drawing of the crosshair
*/
void crosshair() {
  stroke(250);
  line(mouseX-4, mouseY-4, mouseX+4, mouseY+4);
  line(mouseX+4, mouseY-4, mouseX-4, mouseY+4);
}

/**
* Taking the player's input and crosshair position, decides which ballista they
* have decided to fire from and checks to see if there are bombs left to fire before
* calling the fire method. Also checks to ensure there are bombs left to fire and that
* the wave has not been lost
*/
void keyPressed(){
  if(screenView == gameScreen){//If in game
    if(keyPressed == true && (key == 'z' || key == 'x' || key == 'c')){//If one of the fire keys have been pressed
      if(waveStatusCheckCondition() != state.lost && bombsInPlay < 30){//If bombs left in wave and wave not lost
        //Crosshair coordinates acquired
        int x = mouseX;
        int y = (height - mouseY);
        int ballistaChosen;
      
        //Ballista chosen is based on what key was pressed
        if(key == 'z'){
          ballistaChosen = 0;
        }else if(key == 'x'){
          ballistaChosen = 1;
        }else{
          ballistaChosen = 2;
        }
        
        //Check to ensure the ballista has bombs left to fire before the fireBomb function is called
        if(ballistae[ballistaChosen].bombCounter != 0){
          fireBomb(x, y, ballistaChosen);
        }
        
      }
    }
  }
}

/**
* Taking the player's crosshair position, decides which ballista they have decided to 
* fire from and checks to see if there are bombs left to fire before calling the fire 
* method. If there are no bombs left, then it uses the X coordinate again to decide what
* ballistae should be fired from as an alternative.
*/
void mouseClicked(){
  if(screenView == gameScreen){//If in game
      if(waveStatusCheckCondition() != state.lost && bombsInPlay < 30){//If bombs left in wave and wave not lost
        //Crosshaor coordinates acquired
        int x = mouseX;
        int y = (height - mouseY);
        int ballistaChosen;
        
        //Using the crosshair's x coordinate, decides which ballista to fire from
        if(x < 285){
          ballistaChosen = 0;
        }else if(x < 715){
          ballistaChosen = 1;
        }else{
          ballistaChosen = 2;
        }
        
        //A series of if statements to see if the chosen ballista has bombs left and
        //if not, what ballista to fire from as an alternative
        if (ballistae[ballistaChosen].bombCounter == 0) {//Chosen ballista has no bombs left
          switch(ballistaChosen) {
            case 0://Left ballista was original choice
              if (ballistae[1].bombCounter > 0) {
                 ballistaChosen = 1;//Choose middle ballista if it has bombs left
              }else if(ballistae[2].bombCounter > 0) {
                ballistaChosen = 2;//Since no bombs are remaining in the other two, the right-most
                                   //ballista has been chosen
              }
            case 1://Middle ballista was original choice
              //If crosshair was to the right side of the center
              if (x >= width/2) {
                if (ballistae[2].bombCounter > 0) {
                  ballistaChosen = 2;//Choose right ballista if it has bombs left
                  break;
                }else if(ballistae[0].bombCounter > 0) {
                  ballistaChosen = 0;//Since no bombs are remaining in the other two, the left-most
                                     //ballista has been chosen
                }
                //If crosshair was to the left side of the center
            }else{
              if (ballistae[0].bombCounter > 0) {
                ballistaChosen = 0;//Choose left ballista if it has bombs left
              }else if(ballistae[2].bombCounter > 0) {
                ballistaChosen = 2;//Since no bombs are remaining in the other two, the right-most
                                   //ballista has been chosen
              }
            }
           case 2://Right ballista was original choice
              if (ballistae[1].bombCounter > 0) {
                ballistaChosen = 1;//Choose middle ballista if it has bombs left
              }else if(ballistae[0].bombCounter > 0) {
                ballistaChosen = 0;//Since no bombs are remaining in the other two, the left-most
                                   //ballista has been chosen
              }
          }
        }
      
        fireBomb(x, y, ballistaChosen);
      }
  }
}

/**
* The details for the drawing of the crosshair
*/
void crosshair() {
  stroke(250);
  line(mouseX-4, mouseY-4, mouseX+4, mouseY+4);
  line(mouseX+4, mouseY-4, mouseX-4, mouseY+4);
}

void keyPressed(){
  if(screenView == gameScreen){
    if(keyPressed == true && (key == 'z' || key == 'x' || key == 'c')){
      if(waveStatusCheckCondition() != state.lost && bombsInPlay < 30){
        int x = mouseX;
        int y = (height - mouseY);
        int ballistaChosen;
      
        if(key == 'z'){
          ballistaChosen = 0;
        }else if(key == 'x'){
          ballistaChosen = 1;
        }else{
          ballistaChosen = 2;
        }
      
        fireBomb(x, y, ballistaChosen);
      }
    }
  }
}

void mouseClicked(){
  if(screenView == gameScreen){
      if(waveStatusCheckCondition() != state.lost && bombsInPlay < 30){
        int x = mouseX;
        int y = (height - mouseY);
        int ballistaChosen;
        
        if(x < 285){
          ballistaChosen = 0;
        }else if(x < 715){
          ballistaChosen = 1;
        }else{
          ballistaChosen = 2;
        }
      
        fireBomb(x, y, ballistaChosen);
      }
  }
}

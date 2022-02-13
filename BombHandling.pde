void fireBomb(int x, int y, int chosenBallista){
      
  if(ballistae[chosenBallista].bombCounter == 0){
     switch(chosenBallista){
       case 0:
         if(ballistae[1].bombCounter > 0){
           chosenBallista = 1;
         }else if(ballistae[2].bombCounter > 0){
           chosenBallista = 2;
         }
       case 1:
         if(x >= width/2){
           if(ballistae[2].bombCounter > 0){
             chosenBallista = 2;
             break;
           }else if(ballistae[0].bombCounter > 0){
             chosenBallista = 0;
           }
         }else{
           if(ballistae[0].bombCounter > 0){
             chosenBallista = 0;
           }else if(ballistae[2].bombCounter > 0){
             chosenBallista = 2;
           }
         }
       case 2:
         if(ballistae[1].bombCounter > 0){
           chosenBallista = 1;
         }else if(ballistae[0].bombCounter > 0){
           chosenBallista = 0;
         }
     }
  }
  
  ballistae[chosenBallista].createBomb((ballistae[chosenBallista].x2 + ballistae[chosenBallista].x3)/2, ballistae[chosenBallista].y1, (float)((x - ballistae[chosenBallista].x1)/175),(float)-y/140,1);
  bombs[bombsInPlay++] = ballistae[chosenBallista].bomb;
}

void bombMovement(){
  
  for(int i = 0; i<bombs.length; i++){
      if(bombs[i] != null && !(bombs[i].status)){
          PVector position = bombs[i].position;
          bombs[i].integrate(gravityMain);
      
          if(explosions[i] == 1){
            fill(250);
            circle(position.x,position.y,5);
          }  
        
    }
  }

 }
 
 void bombSetOffCheck(){
  
   if(keyPressed == true && key == ' '){
     for(int i = 0; i < bombs.length; i++){
       if(bombs[i] != null && (!bombs[i].status)){
           bombs[i].active = true;
       }
     }
   }
   
   for(int i = 0; i < bombs.length; i++){
     if(bombs[i] != null && bombs[i].active){
       if(i == 0){ 
           if(explosions[i] < 35){
             explode(i);
           }
       }else if(explosions[i - 1] >= 20 ){
           explode(i);
       }
     }
   }

 }
 
void explode(int i){
  if(explosions[i] < 35){
     noStroke();
     fill(255,67,27);
     circle(bombs[i].position.x, bombs[i].position.y,explosions[i]);
     explosions[i]++;
  }else{
     bombs[i].status = true;
     bombs[i].active = false;
  }
}

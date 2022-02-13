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

void bombHandling(){
  int i=0;
  
  while(i < 30 && bombs[i] != null){
    if( bombsInPlay < 31){
      PVector position = bombs[i].position;
      bombs[i].integrate(gravityMain);
      
      //if(bombs[i].detonated()){
      //  if(explosions[i] < 35){
      //    noStroke();
      //    fill(255,67,27);
      //    circle(bombs[i].position.x, bombs[i].position.y,explosions[i]);
      //    explosions[i]++;
      //  }
      //}else{
        if(bombs[i].status == false){
          fill(250);
          circle(position.x,position.y,5);
        }
        
      //}
    }
    i++;
  }
 }
 
 void explosionCheck(){
   
   if(keyPressed == true && key == ' '){
     int count = frameCount;
     for(int i = 0; i < bombs.length; i++){
       while(bombs[i] != null){
         if(!bombs[i].status){
           PVector position = bombs[i].position;
           if(frameCount == count + 30){
               if(explosions[i] < 35){
                  noStroke();
                  fill(255,67,27);
                  circle(bombs[i].position.x, bombs[i].position.y,explosions[i]);
                  explosions[i]++;
              }
           }
         }
       }
     }
   }
   
 }

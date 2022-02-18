/**
* Acquires the score multiplier for the wave
*
* @return multipler Integer that will be used to multiply the score by
*/
int scoreMultiplier(){
   int multiplier = 1;
 
   if(wave < 3){
       return multiplier;
   }else if(wave < 5){
       return multiplier * 2;
   }else if(wave < 7){
       return multiplier * 3;
    }else if(wave < 9){
       return multiplier * 4;
    }else if(wave < 11){
       return multiplier * 5;
    }else{
       return multiplier * 6;
    }
 
}

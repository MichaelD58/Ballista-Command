/**
* Sets the top-left corner coordinates for the cities as well as the city
* width and height. Then assigns these values to a new city object within the cities array.
* Finally, checks to see if the city should be drawn or not and responds accordingly.
*
* @param  x a float of the x coordinate of a meteor to use for collision checking
* @param  y a float of the y coordinate of a meteor to use for collision checking
*/
void drawCities(float x,float y) {
  int rect[]= new int[4];
  
  //For the six cities
  for (int i=0; i<cities.length; i++) {//For every city
    //Check to see what group the city belongs to
    if (i < 3) {
      rect[0]= (i * (width/10))+((width/10) + 58);//First three
    } else {
      rect[0]= (i * (width/10))+((width/10) + 198);//Second three
    }
    rect[1]= height - 20;//Top-left y-coordinate
    rect[2]= width/23;//Width
    rect[3]= height/35;//Height

    cities[i]=new City(rect[0], rect[1], rect[2], rect[3]);//Added to the cities array

    //Check to see if city has been hit by meteor or if it is already dead
    if(cities[i].checkState(x,y) && cityState[i]){
      cities[i].draw();//City is drawn
    }else{
      cityState[i]=false;//City's state is set to false
    }
    
  }
}

/**
* Initialises the the ballistae array with three ballistae with hard-coded coordinates.
*/
void createBallistae() {
  ballistae[0]=new Ballista(60, height - 40, 15, height, 105, height);//Left-most ballista
  ballistae[1]=new Ballista((width/2), height - 40, (width / 2) - 45, height, (width/2) + 45, height);//Center ballista
  ballistae[2]=new Ballista(width - 60, height - 40, width - 105, height, width - 15, height);//Right-most ballista
}

/**
* Draws the three ballistae. Also carries out a check via a method call to see what should be displayed for the ballista's
* bomb counter.
*
* @param  x a float of the x coordinate of a meteor to use for collision checking
* @param  y a float of the y coordinate of a meteor to use for collision checking
*/
void drawBallistae(float x,float y) {
  //All three ballistae are drawn
  for (int i=0; i<ballistae.length; i++) {
    
    //Check to see if ballista has been hit by meteor or if it is already deactivated
    if(!(ballistae[i].checkState(x,y) && ballistaState[i])){
      //Ballista deactivated
      ballistaState[i] = false;
      ballistae[i].bombCounter = 0;
    }
    
    ballistae[i].draw();
  }
}

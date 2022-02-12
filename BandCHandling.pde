//Method to fill the cities array and then draw them
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

    if(cities[i].checkState(x,y) && cityState[i]==true){
      cities[i].draw();//City is drawn
    }else{
      cityState[i]=false;
    }
    
  }
}

//Method to fill the ballistae array
void createBallistae() {
  ballistae[0]=new Ballista(60, height - 40, 15, height, 105, height);//Left-most ballista
  ballistae[1]=new Ballista((width/2), height - 40, (width / 2) - 45, height, (width/2) + 45, height);//Center ballista
  ballistae[2]=new Ballista(width - 60, height - 40, width - 105, height, width - 15, height);//Right-most ballista
  
}

//Method to draw the ballistae whilst checking if they have been hit by a meteor
void drawBallistae(float x,float y) {
  //All three ballistae are drawn
  for (int i=0; i<ballistae.length; i++) {
    
    if(!(ballistae[i].checkState(x,y) && ballistaState[i])){
      ballistaState[i] = false;
      ballistae[i].bombCounter = 0;
    }
    
    ballistae[i].draw();
  }
}

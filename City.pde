class City{
  float x, y, cityWidth , cityHeight ;
  
  City(float x, float y, float cityWidth, float cityHeight){
      this.x = x;
      this.y = y;
      this.cityWidth = cityWidth;
      this.cityHeight = cityHeight;
  }
  
  
  void draw() {
    fill(0, 0 , 250) ;
    rect(x, y, cityWidth, cityHeight) ;
  }
  
  
  /**
  * Simple check to see if current meteor looked at is within the bounds of the city
  *
  * @param  x a float of the x coordinate of a meteor
  * @param  y a float of the y coordinate of a meteor
  * @return a boolean value representing if the city is still alive or not
  */
  boolean checkState(float meteorX, float meteorY){
    if((meteorX < (x + cityWidth + 9) && meteorX > x - 9) && (meteorY < (y+ cityHeight) && meteorY > y)){
      return false;
    }
    return true;
  }
    
}

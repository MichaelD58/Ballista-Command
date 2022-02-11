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
  
  boolean checkState(float meteorX, float meteorY){
    if((meteorX < (x + cityWidth) && meteorX > x) && (meteorY < (y+ cityHeight) && meteorY > y)){
      return false;
    }
    return true;
  }
    
}

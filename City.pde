class City{
  int x, y, cityWidth , cityHeight ;
  
  City(int x, int y, int cityWidth, int cityHeight){
      this.x = x;
      this.y = y;
      this.cityWidth = cityWidth;
      this.cityHeight = cityHeight;
  }
  
  void draw() {
    fill(0, 0 , 250) ;
    rect(x, y, cityWidth, cityHeight) ;
  }
    
}

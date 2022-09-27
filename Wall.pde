class Wall{
  float x, y;
  int w, h;
  
 
  Wall(int x, int y, int w, int h)
  {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    
    
  }
  
  public void display()
  {
    fill(255, 0, 0);
    rect(x, y, w, h);
   
    
  }
}

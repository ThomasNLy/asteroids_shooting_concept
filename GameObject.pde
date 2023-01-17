class GameObject{
  int x;
  int y;
  int size;
 
  float xSpeed;
  float ySpeed;
  int wd, ht;
  
  int centerX, centerY;

  GameObject(){}
  
  int[] getCenter()
  {
    int[] arr = {this.x + this.wd/2, this.y + this.ht/2};
    return (arr);
  }

}

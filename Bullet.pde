class Bullet extends GameObject{
  //float x;
  //float y;
  
  float directionX;
  float directionY;
  
  Bullet(int x, int y, float directionX, float directionY) {
    
    this.x = x;
    this.y = y;
    this.directionX = directionX; 
    this.directionY = directionY;
    this.xSpeed  = 10;
    this.ySpeed = 10;
    this.size = 20;
  }

  void display()
  {
   
    fill(0, 140, 200);
    circle(this.x, this.y, size);
  }

  void move()
  {
    this.x += directionX * xSpeed;
    this.y += directionY * ySpeed;
  }
}

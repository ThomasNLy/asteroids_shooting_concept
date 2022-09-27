class Bullet {
  float x;
  float y;
  int speed = 10;
  float directionX;
  float directionY;
  int size = 20;
  Bullet(float x, float y, float directionX, float directionY) {
    this.x = x;
    this.y = y;
    this.directionX = directionX; 
    this.directionY = directionY;
  }

  void display()
  {
   
    fill(0, 140, 200);
    circle(this.x, this.y, size);
  }

  void move()
  {
    this.x += directionX * speed;
    this.y += directionY * speed;
  }
}

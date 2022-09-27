class Enemy {
  int x;
  int y;
  int size = 40;
  float xSpeed;
  float ySpeed;
  boolean hurt = false;
  int state = 2;
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    this.xSpeed = random(-3, 3);
    this.ySpeed = random(-3, 3);
  }

  void display()
  {
    color c = hurt ? color(255, 0, 0) : color(140);
   
    fill(c);
    rect(this.x, this.y, size, size);
  }
  
  void move()
  {
    this.x += xSpeed;
    this.y += ySpeed;
  }
}

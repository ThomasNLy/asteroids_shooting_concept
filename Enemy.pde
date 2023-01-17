class Enemy extends GameObject{
 
  boolean hurt = false;
  int state = 2;
  Enemy(int x, int y) {
    super();
    this.x = x;
    this.y = y;
    this.xSpeed = random(-3, 3);
    this.ySpeed = random(-3, 3);
    
    this.wd = 40;
    this.ht = 40;
    this.size = this.wd + this.ht;
    this.centerX = this.x + this.wd / 2;
    this.centerY = this.y + this.wd / 2;
  }

  void display()
  {
    color c = hurt ? color(255, 0, 0) : color(140);
   
    fill(c);
    rect(this.x, this.y, this.wd, this.ht);
  }
  
  void move()
  {
    this.x += xSpeed;
    this.y += ySpeed;
  }
}

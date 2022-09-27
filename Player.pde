class Player{
  int x;
  int y;
  int size;
  int playerDirectionX;
  int playerDirectionY;
  int xSpeed;
  int ySpeed;
  Player(int x, int y)
  {
    this.x = x;
    this.y = y;
    size = 50;
    playerDirectionX = this.x + size + 10;
    playerDirectionY = this.y;
  }
  
  void display()
  {
    strokeWeight(1);
    stroke(0);
    fill(255);
    rect(this.x, this.y, this.size, this.size);
  }
  void move()
  {
    x += xSpeed;
    y += ySpeed;
  }
  
  int[] getCenter()
  {
    int[] arr = {this.x + size/2, this.y + size/2};
    return (arr);
  }
}

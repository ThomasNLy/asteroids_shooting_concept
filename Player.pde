class Player {
  int x;
  int y;
  int size;
 
  int xSpeed;
  int ySpeed;
  Player(int x, int y)
  {
    this.x = x;
    this.y = y;
    size = 50;
  }

  void display()
  {
    //displaying the player by translating them from the origin to where the player's position will be
    pushMatrix();
    strokeWeight(1);
    stroke(0);
    fill(255);
    translate(getCenter()[0], getCenter()[1]);
    rotate(calculateAngle());
    triangle(20, 0, -5, -10, -5, 10);
    popMatrix();
    hitbox();
    
  }
  
  void hitbox()
  {
    fill(255, 180);
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


  //--------------------used to calcualte the angle the player rotates and rotates them---------------------
  float calculateAngle()
  {
    float playerCenterX = getCenter()[0];
    float playerCenterY = getCenter()[1];
    float x = mouseX - playerCenterX;
    float y = mouseY - playerCenterY;

    float angleInRadians = atan(y/x); // will only calcualte from -PI/2 to PI/2
    //float angleInDegrees = (angleInRadians* 180/PI);
   
    if (mouseX < playerCenterX)
    {
      // if mouse past left side used to make the player rotate full 360 degrees as atan() only calculates from -90 to 90 degrees
      return angleInRadians + PI;
    }

    //translate(100, 100);
    else {
      return angleInRadians;
    }
  }
}

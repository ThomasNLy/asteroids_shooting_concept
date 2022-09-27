Player player;
Enemy enemy;
int playerCenterX;
int playerCenterY;
int x;
int y;
ArrayList<Bullet> bullets;
float bulletDirectionVector[];
ArrayList<Enemy> enemyList;

int enemySpawn[][] = {{30, 30}, {500, 30}, {30, 500}, {500, 500}};

Wall w;


//-------------controls-------
final int W = 87;
final int A = 65;
final int S = 83;
final int D = 68;
void setup()
{
  frameRate(60);
  size(600, 600);
  background(180);
  player = new Player(width/2, height/2);
  bulletDirectionVector = new float[2];

  //------------enemy spawn points------

  bullets = new ArrayList<Bullet>();
  enemyList = new ArrayList<Enemy>();
  for (int i = 0; i < 4; i ++)
  {
    int randomSpawnLoc = int(random(4));

    enemyList.add(new Enemy(enemySpawn[randomSpawnLoc][0], enemySpawn[randomSpawnLoc][1]));
  }
  
  //--------------walls-----------
  w = new Wall(200, 100, 100, 100);
}

void draw()
{
  playerCenterX = player.getCenter()[0];
  playerCenterY = player.getCenter()[1];
  background(180);
  player.display();
  player.move();
  //-------------aiming reticle
  fill(0, 180, 70);
  stroke(0);
  strokeWeight(1);
  line(playerCenterX, playerCenterY, mouseX, mouseY);
  circle(mouseX, mouseY, 10);



  //----------bullets 2 for loops are needed 1 for moving and displaying another 1 for handling logic for deleting-------------
  
  //updateBulletBounce();
  
  //---bullets move and display---------
  for (int i = 0; i < bullets.size(); i++) {
    
    if(wallCollide(w, bullets.get(i), bullets.get(i).size/2))
    {
      PVector np = nearestPoint(w, bullets.get(i));
      reflect(np, bullets.get(i));
      //break;
    }
    bullets.get(i).move();
    bullets.get(i).display();
    
    //int enemyCenterX = enemy.x + enemy.size/2;
    //int enemyCenterY = enemy.y + enemy.size/2;

    //println(distFromEnemy);
    
    if (bullets.get(i).x > width || bullets.get(i).x < 0 || bullets.get(i).y > height || bullets.get(i).y < 0)
    {
      bullets.remove(bullets.get(i));
    }
    
    
  }
  //----------------updating bullets hitting the enemy----------
  for (int i = bullets.size() -1; i >= 0; i--)
  {

    for (int j = enemyList.size() - 1; j >= 0; j--)
    {
      if (colliding(enemyList.get(j), bullets.get(i)))
      {
        if (enemyList.get(j).state == 2)
        {
          
            Enemy spawn = new Enemy(enemyList.get(j).x, enemyList.get(j).y);
            spawn.state = 1;
            spawn.size = 20;
            Enemy spawn2 = new Enemy(enemyList.get(j).x, enemyList.get(j).y);
            spawn2.state = 1;
            spawn2.size = 20;
            enemyList.add(spawn);
            enemyList.add(spawn2);
        }
        enemyList.remove(j);
        bullets.remove(bullets.get(i));
        break;
      }
    }
  }
  
  
  
  
  //----------------------walls----------
  w.display();
  
  

  updateEnemy();
  if (enemyList.size() <= 0)
  {
    setup();
  }
  
  calculateAngle();
}


boolean colliding(Enemy enemy, Bullet b)
{
  int enemyCenterX = enemy.x + enemy.size/2;
  int enemyCenterY = enemy.y  + enemy.size/2;
  int distFromEnemy = (int)Math.sqrt((b.x - enemyCenterX)  * (b.x - enemyCenterX) + (b.y - enemyCenterY) * (b.y - enemyCenterY));
  if (distFromEnemy < (b.size/2 + enemy.size/2))
  {
    return true;
  }
  return false;
}

//-------------------wall collision for bullet----------------
boolean wallCollide(Wall w, Bullet b, int size)
{
  if((b.x - size) <= (w.x + w.w) && (b.x + size >= w.x))
  {
    if((b.y + b.size) >= w.y && (b.y - b.size) <= (w.y + w.h))
    {
      return true;
    }
  }
  return false;
}
//--------------reflecting bullet-------------------
void reflect(PVector nearestPoint, Bullet b)
{
  float normalX = b.x - nearestPoint.x;
  float normalY = b.y - nearestPoint.y;
  println(nearestPoint.x);
  line(b.x, b.y, nearestPoint.x, nearestPoint.y);
  float normalize = (float)Math.sqrt((nearestPoint.x - b.x) * (nearestPoint.x - b.x) + (nearestPoint.y  - b.y) * (nearestPoint.y  - b.y));
  normalX *= 1/normalize;
  normalY *= 1/normalize;
  
  float dotProduct = (normalX * b.directionX) + (normalY * b.directionY);
  b.directionX -= 2 * dotProduct * normalX;
  b.directionY -= 2 * dotProduct * normalY;
  
}

//--------------finding nearest point using box collision--------------------
PVector nearestPoint(Wall w, Bullet b)
{
  
  if(b.x >= (w.x + w.w))
  {
    return new PVector(w.x + w.w, b.y);
  }
  else if(b.x  <= w.x)
  {
    return new PVector(w.x, b.y);
  }
  
  else if((b.y + b.size/2) <= w.y)
  {
    println("Top");
    return new PVector(b.x, w.y);
  }
  
  else
  {
    println("Bottom");
    return new PVector(b.x, w.y + w.h);
  }
}

void updateBulletBounce()
{
  for (Bullet b : bullets)
  {
    if(wallCollide(w, b, b.size/2))
    {
      PVector np = nearestPoint(w, b);
      reflect(np, b);
      break;
    }
  }
}

void updateEnemy()
{
  for (int i = 0; i < enemyList.size(); i++)
  {
    enemyList.get(i).move();
    enemyList.get(i).display();

    if (enemyList.get(i).x < 0)
    {
      enemyList.get(i).x = width;
    } else if ( enemyList.get(i).x > width)
    {
      enemyList.get(i).x = 0;
    }

    if (enemyList.get(i).y < 0)
    {
      enemyList.get(i).y = height;
    } else if (enemyList.get(i).y > height)
    {
      enemyList.get(i).y = 0;
    }
  }
}

/**
 magnitude is the length of a vector from the origin,
 distance formula is used to calculate distance between 2 points(vectors) or the length of the points with out shifting back to origin
 calculates the direction vector for the bullet to move towards
 */
float [] calculateBulletDirection(int x1, int y1, int playerX, int playerY)
{
  float directionVectorX = x1 - playerX;
  float directionVectorY = y1 - playerY;
  float magnitude = (float)Math.sqrt(directionVectorX * directionVectorX + directionVectorY * directionVectorY);
  //println(magnitude);
  directionVectorX /= magnitude;
  directionVectorY /= magnitude;
  //println("dir x" + directionVectorX);
  //println(directionVectorX + ", " + directionVectorY);
  float[] a = {directionVectorX, directionVectorY};
  return a;
}


void calculateAngle()
{
  float x = mouseX - playerCenterX;
  float y = mouseY - playerCenterY;
  
  float angleInRadians = atan(y/x);
  //float angleInDegrees = (angleInRadians* 180/PI);
  
  
  
  pushMatrix();
  translate(playerCenterX , playerCenterY ); // translate the origin to be the center of the player
  
  //translate(100, 100);
  rotate(angleInRadians );
  rect(0 - player.size/2, 0 - player.size/2 , player.size, player.size);
  
  
  popMatrix();
  //println("angle in degrees " + angleInDegrees);
}

void mousePressed()
{
  bulletDirectionVector = calculateBulletDirection(mouseX, mouseY, playerCenterX, playerCenterY);
  bullets.add(new Bullet(playerCenterX, playerCenterY, bulletDirectionVector[0], bulletDirectionVector[1]));
}
void keyPressed()
{
  if (keyCode == W)
    player.ySpeed = -5;
  if (keyCode == S)
    player.ySpeed = 5;
  if (keyCode == A)
    player.xSpeed = -5;
  if (keyCode == D)
    player.xSpeed = 5;
}

void keyReleased()
{
  if (keyCode == W || keyCode == S)
    player.ySpeed = 0;

  if (keyCode == D || keyCode == A)
    player.xSpeed = 0;
}

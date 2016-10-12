SpaceShip s1 = new SpaceShip(250,750, 1); 
SpaceShip s2 = new SpaceShip(100, 750, 2); 
ArrayList<Bullet> bullets = new ArrayList();
ArrayList<Asteriod> asteriods = new ArrayList();


class SpaceShip
{
  int x;
  int y; 
  int player;
  
  SpaceShip(int x, int y, int player)
  {
    this.x = x; 
    this.y = y; 
    this.player = player; 
  }
  
  //getter and setters 
  int getX()
  {
    return this.x; 
  }
  
  void setX(int x)
  {
    this.x = x; 
  }
  
  int getY()
  {
    return this.y; 
  }
  
  void setY(int y)
  {
    this.y = y; 
  }
  
  void display()
  {
    if(player == 1)
    {
      fill(0,255,0);
    }
    else
    {
      fill(255,255,0); 
    }
    noStroke(); 
    rect(x, y, 50, 50);
  }
  
}

class Bullet//bullet class
{
  int x;
  int y;
  int speed;
  Bullet(int x, int y)
  {
    this.x = x; 
    this.y = y; 
  }
  //getter and setters 
  int getX()
  {
    return this.x; 
  }
  
  void setX(int x)
  {
    this.x = x; 
  }
  
  int getY()
  {
    return this.y; 
  }
  
  void setY(int y)
  {
    this.y = y; 
  }
  void display()
  {
    stroke(255);
    point(x,y);
  }
  void move()
  {
    y -= 2;
  }
}

class Asteriod
{
  int x; 
  int y=0; 
  int speed; 
  int size; 
  Asteriod(int x, int speed, int size)
  {
    this.x = x; 
    this.speed = speed; 
    this.size = size; 
  }
    //getter and setters 
  int getX()
  {
    return this.x; 
  }
  
  void setX(int x)
  {
    this.x = x; 
  }
  
  int getY()
  {
    return this.y; 
  }
  
  void setY(int y)
  {
    this.y = y; 
  }
  
  void display()
  {
    fill(0,0,255);
    noStroke(); 
    rect(x, y, 50, size);
  }
  
  void move() 
  {
    y += speed; 
  }
  
}

void moveAllBullets()
{
  for(Bullet temp : bullets)
  {
    temp.move();
  }
}

void displayAllBullets()
{
  for(Bullet temp : bullets)
  {
    temp.display();
  }
}

void removeToBulletLimit(int maxLength)
{
  while(bullets.size() > maxLength)
  {
    bullets.remove(0);
  }
  for(Bullet b : bullets)
  {
    if(b.y <= 0)
    {
      bullets.remove(b); 
      break; 
    }
  }
}

void mousePressed()//add a new bullet if mouse is clicked
{
  Bullet temp = new Bullet(mouseX,mouseY);
  bullets.add(temp);
}

//gives the spaceship movement
void keyPressed()
{
  if(key == CODED){
    switch(keyCode)
    {
      case RIGHT:
        s1.x +=20; 
        break;
      case LEFT:
        s1.x-=20; 
        break;
      default:
        break;
    }
  }
  else if(keyPressed) //space is not special key 
  {
    if(key == ' ' )
    {
      Bullet temp = new Bullet(s1.x+25,s1.y);
      bullets.add(temp);
    }
    else if(key == 'a' || key =='A')
    {
      s2.x -=20; 
    }
    else if(key == 'd' || key == 'D')
    {
      s2.x +=20; 
    }
  }
} 

void keepSpaceShipsInCanvas(SpaceShip s)
{
  if(s.getX() < 0 )
  {
    s.setX(0); 
  }
  else if(s.getX() > 450)
  {
    s.setX(450); 
  }
}


void displayAllAsteriods()
{
  for(Asteriod temp : asteriods)
  {
    temp.display();
  }
}

void asteriodsAssemble()
{

  for(int x = 0; x <=400; x+=50)
  {
    Asteriod b = new Asteriod(x,(int)random(3)+1,(int)random(100)+1); 
    asteriods.add(b); 
  }
}

void moveAllAsteriods()
{
  for(Asteriod temp : asteriods)
  {
    temp.move();
  }
}

void pushBack()
{
  for(Asteriod a : asteriods)
  {
    for(Bullet b : bullets)
    {
      if((int)b.getX() >= a.getX() && (int)b.getX() <= (a.getX() +50) && (int)b.getY() >= a.getY() && (int)b.getY() <= a.getY()+a.size)
      {
        //push spaceships back 
        a.setY(a.getX() -50); 
        bullets.remove(b); 
        break;
      }
    }

  }
}

void destroyAsteriod()
{
  boolean hit = false; 
  for(Asteriod a : asteriods)
  {
    for(Bullet b : bullets)
    {
      if((int)b.getX() >= a.getX() && (int)b.getX() <= (a.getX() +50) && (int)b.getY() >= a.getY() && (int)b.getY() <= a.getY()+a.size)
      {
        bullets.remove(b); 
        hit = true; 
        break;
      }
    }
    if(hit == true)
    {
      asteriods.remove(a);
      break; 
    }
  }
}
  

void loseCondition()
{
  for(Asteriod a : asteriods)
  {
    if(a.y >= 800)
    {
      fill(255, 0, 0);
      textSize(32);
      text("YOU LOSE", 200, 400); 

    }
  }
}

void winCondition()
{
  if (asteriods.size() == 0)
  {
      fill(0, 102, 153);
      textSize(32);
      text("YOU WIN", 200, 400); 
  }
    
}

void setup()
{
  size(500,800); 
  asteriodsAssemble(); 
}

void draw()
{
  background(0); 
  s1.display();
  keepSpaceShipsInCanvas(s1); 
  
  /* For Player 2  */
  //s2.display(); 
  //keepSpaceShipsInCanvas(s2); 
  
  /* Bullet bookkepping code */
  removeToBulletLimit(500);
  moveAllBullets();
  displayAllBullets();
  
  /* Asteriod book keeping code */
  moveAllAsteriods(); 
  displayAllAsteriods(); 
  
  /* Effects of the bullets */
  pushBack();
  //destroyAsteriod();
  
  /* Game Conditions */
  loseCondition();
  winCondition(); 

}
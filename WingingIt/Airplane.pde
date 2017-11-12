class Airplane {
  float x, y;
  float angle;

  ArrayList<Point> points = new ArrayList<Point>();

  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  int timeSinceLastBullet = 10;
  float bulletDelay = 20;
  
  int speed = 5;
  
  int bulletSpeed = 10;
  
  boolean shielded = false;

  Airplane(int x, int y) {
    this.x = x;
    this.y = y;
    this.angle = PI;
  }

  void show() {
    //draw trail
    for (int i = 0; i<points.size(); i++) {
      Point p1 = points.get(i);
      noStroke();
      fill(150, 100);
      ellipse(p1.getX()+50*cos(angle), p1.getY()+50*sin(angle), i/4, i/4);
      ellipse(p1.getX()+30*cos(angle), p1.getY()+30*sin(angle), i/4, i/4);
      ellipse(p1.getX()-50*cos(angle), p1.getY()-50*sin(angle), i/4, i/4);
      ellipse(p1.getX()-30*cos(angle), p1.getY()-30*sin(angle), i/4, i/4);
    }
    //cuttoff trail
    if (points.size()>50) {
      points.remove(0);
    }

    for (int i = 0; i<bullets.size(); i++) {
      bullets.get(i).show();
    }


    noStroke();
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(angle);
    translate(-x, -y);


    //turbines
    fill(250);
    rect(x+50, y-20, 10, 35);
    rect(x+30, y-15, 10, 45);
    rect(x-50, y-20, 10, 35);
    rect(x-30, y-15, 10, 45);
    //wings
    fill(230);

    pushMatrix();
    translate(x-30, y);
    rotate(PI/8);
    translate(-x+30, -y);
    rect(x-30, y, 80, 30);
    popMatrix();

    pushMatrix();
    translate(x+30, y);
    rotate(-PI/8);
    translate(-x-30, -y);
    rect(x+30, y, 80, 30);
    popMatrix();

    //body
    fill(250);
    ellipse(x, y, 25, 120);

    //window
    fill(15);
    ellipse(x, y+50, 10, 7);

    //stripes
    fill(#ff604f);
    rect(x, y, 5, 80);

    if (shielded) {
      fill(#ff0000, 100);
      ellipse(x, y, 100, 100);
    }
    this.update();
    popMatrix();
  }

  void update() {
    float dX = mouseX-x;
    float dY = mouseY-y;
    float mouseAngle = atan(dY/dX) ;

    if (abs(dX)>1 && abs(dY) >1) {
      if (mouseX>=x) {
        if (mouseY<=y) {
          mouseAngle=atan((mouseY-y)/(mouseX-x))+2*PI;
        } else {
          mouseAngle=atan((mouseY-y)/(mouseX-x));
        }
      } else {
        mouseAngle=atan((mouseY-y)/(mouseX-x))+PI;
      }
      if (mouseAngle > TWO_PI) {
        mouseAngle = 0;
      } else if (mouseAngle<0) {
        mouseAngle = TWO_PI;
      }

      float dA = (mouseAngle - angle - PI/2);
      angle+=dA;
      if (mousePressed) {
        x -= speed*sin(angle);
        y += speed*cos(angle);
      }
    }

    if (keyPressed) {
      if (key == ' ' && timeSinceLastBullet>=bulletDelay) {
        bullets.add(new Bullet(new Point(x, y), angle, bulletSpeed));
        timeSinceLastBullet = 0;
      }
    }
    
    for (int i = bullets.size()-1; i>=0; i--) {
    if (bullets.get(i).point.getX()>1150 || bullets.get(i).point.getX()<-150) {
      bullets.remove(i);
    } else if (bullets.get(i).point.getY()>1150 || bullets.get(i).point.getY()<-150) {
      bullets.remove(i);
    }
  }

    timeSinceLastBullet++;
    points.add(new Point(x, y));
  }

  void giveShield() {
    shielded = true;
  }
  
  boolean isShielded(){
    return shielded;
  }
  
  void breakShield(){
   shielded = false; 
  }
  
  void increaseBulletSpeed(int speed){
   bulletSpeed+=speed; 
  }
  
  void increaseBulletRate(float factor){
    bulletDelay = bulletDelay/factor ;
  }
  
  void increaseSpeed(int speed){
    this.speed+=speed;
  }
}
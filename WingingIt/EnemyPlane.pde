class EnemyPlane {
  float x, y;
  float angle;
  int speed = 7;

  ArrayList<Point> points = new ArrayList<Point>();


  EnemyPlane(int x, int y) {
    this.x = x;
    this.y = y;
    this.angle = random(0, TWO_PI);
  }

  void show() {
    //draw trail
    for (int i = 0; i<points.size(); i++) {
      Point p1 = points.get(i);
      noStroke();
      fill(120, 100);
      ellipse(p1.getX()+50*cos(angle), p1.getY()+50*sin(angle), i/4, i/4);
      ellipse(p1.getX()+30*cos(angle), p1.getY()+30*sin(angle), i/4, i/4);
      ellipse(p1.getX()-50*cos(angle), p1.getY()-50*sin(angle), i/4, i/4);
      ellipse(p1.getX()-30*cos(angle), p1.getY()-30*sin(angle), i/4, i/4);
    }
    //cuttoff trail
    if (points.size()>20) {
      points.remove(0);
    }


    noStroke();
    rectMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(angle);
    translate(-x, -y);


    //turbines
    fill(140);
    rect(x+50, y-20, 10, 35);
    rect(x+30, y-15, 10, 45);
    rect(x-50, y-20, 10, 35);
    rect(x-30, y-15, 10, 45);
    //wings
    fill(120);

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
    fill(140);
    ellipse(x, y, 25, 120);

    //window
    fill(0);
    ellipse(x, y+50, 10, 7);

    //stripes
    fill(#b4e84a);
    rect(x, y, 5, 80);

    this.update();
    popMatrix();
  }

  void update() {
    x -= speed*sin(angle);
    y += speed*cos(angle);
    points.add(new Point(x, y));
  }
  
}
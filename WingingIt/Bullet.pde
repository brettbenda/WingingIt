class Bullet{
 Point point;
 float angle;
 int speed;
 
 Bullet(Point point, float angle, int speed){
   this.point = point;
   this.angle = angle;
   this.speed = speed;
 }
 
 void show(){
  fill(0);
  ellipse(point.getX(),point.getY(),10,10);
  update();
 }
 
 void update(){
  point.setX(point.getX()-speed*sin(angle)); 
  point.setY(point.getY()+speed*cos(angle)); 
 }
 
 void setSpeed(int speed){
   this.speed = speed;
 }
 
 void modSpeed(int mod){
  this.speed+=mod; 
 }
}
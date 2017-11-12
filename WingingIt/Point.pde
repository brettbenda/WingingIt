class Point{
 float x,y;
 
 Point(float x, float y){
  this.x = x;
  this.y = y;
 }
 
 void setX(float x){
   this.x = x;
 }
 
 float getX(){
  return this.x; 
 }
 
 void setY(float y){
   this.y = y;
 }
 
 float getY(){
  return this.y; 
 }
 
 
 Point getCopy(Point p){
   return new Point(p.getX(),p.getY());
 }
 
  
}
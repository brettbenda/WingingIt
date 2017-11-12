class BulletSpeedUp extends PowerUp{
  
  BulletSpeedUp(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
   fill(#ffd6a5);
   ellipse(x,y,20,20); 
   rectMode(CENTER);
   fill(#c48e4c);
   rect(x-3,y-2,2,2);
   rect(x,y+2,2,2);
   rect(x+3,y-2,2,2);
  }
  
  String getType(){
   return "bru"; 
  }
}
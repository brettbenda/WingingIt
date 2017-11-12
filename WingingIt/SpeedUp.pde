class SpeedUp extends PowerUp{
  
  SpeedUp(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
   fill(#ffadf0);
   ellipse(x,y,20,20); 
   rectMode(CENTER);
   fill(#f442d4);
   triangle(x-6,y-4,x,y+4,x+6,y-4);
  }
  
  String getType(){
   return "su"; 
  }
}
class BulletRateUp extends PowerUp{
  
  BulletRateUp(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
   fill(#f9f1b6);
   ellipse(x,y,20,20); 
   rectMode(CENTER);
   fill(#c4b64c);
   rect(x-3,y,2,2);
   rect(x,y,2,2);
   rect(x+3,y,2,2);
  }
  
  String getType(){
   return "bsu"; 
  }
}
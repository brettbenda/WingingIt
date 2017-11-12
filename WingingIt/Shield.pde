class Shield extends PowerUp{
  
  Shield(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void show(){
   fill(#d3f9b6);
   ellipse(x,y,20,20); 
   rectMode(CENTER);
   fill(#406326);
   rect(x,y,10,3);
   rect(x,y,3,10);
  }
  
  String getType(){
   return "shield"; 
  }
}
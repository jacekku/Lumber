//...Just a button...
//...
class Button{
  int x,y;
  PImage label;
  int action=-1;
  Button(int x,int y,PImage image,int action){
    this.x=x;
    this.y=y;
    this.label=image;
    this.action=action;
  }
  void show(){
    noStroke();
    if(mouseX>x&&mouseX<x+label.width&&mouseY>y&&mouseY<y+label.height){
      fill(255);
      rect(x,y,label.width,label.height);
    }
    image(label,x,y);
    stroke(1);
  }
  void handleClick(){
    if(mouseX>x&&mouseX<x+label.width&&mouseY>y&&mouseY<y+label.height){
      mouseAction=this.action;
    }
  }
  
}
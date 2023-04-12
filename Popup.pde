class Popup extends Window{
  Popup(PApplet parent,float x,float y,String title){
    super(parent, x, y, 200, 500, title, 10);
  }
  
  Popup(PApplet parent,float x,float y,String title,String body){
    super(parent, x, y, 200, 500, title, 10);
    this.body=body;
  }
  
  Popup(PApplet parent,float x,float y,String title,String body,PImage image){
    super(parent, x, y, 200, 500, title, 10);
    this.body=body;
    this.image=image;
  }
  
  PImage image;
  String body;
  
  
  
  
  
  
  
}

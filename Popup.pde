class Popup extends Window{
  Popup(PApplet parent,int PN,float x,float y,String title,PImage image){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.image=image;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,String body){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,String body,String bodyA){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.bodyA=bodyA;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,String body,String bodyA,String bodyB){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.bodyA=bodyA;
    this.bodyB=bodyB;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,String body,String bodyA,String bodyB,String bodyC){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.bodyA=bodyA;
    this.bodyB=bodyB;
    this.bodyC=bodyC;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,PImage image,String body){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.image=image;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,PImage image,String body,String bodyA){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.bodyA=bodyA;
    this.image=image;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,PImage image,String body,String bodyA,String bodyB){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.bodyA=bodyA;
    this.bodyB=bodyB;
    this.image=image;
    this.PN=PN;
  }
  
  Popup(PApplet parent,int PN,float x,float y,String title,PImage image,String body,String bodyA,String bodyB,String bodyC){
    super(parent, x, y, 300, 500, title, 10, null, false);
    this.body=body;
    this.bodyA=bodyA;
    this.bodyB=bodyB;
    this.bodyC=bodyC;
    this.image=image;
    this.PN=PN;
  }
  
  
  
  PImage image;
  String body,bodyA,bodyB,bodyC;
  int PN;
  
  
  void drawWindow()
  {
    textAlign(LEFT,CENTER);
    if(image != null)
    {
      image(image,x+10,y+10);
    }
    text(body,x+10,y+200);
    if(bodyA != null)
    {
      text(bodyA,x+10,y+250);
    }
    if(bodyB != null)
    {
      text(bodyB,x+10,y+300);
    }
    if(bodyC != null)
    {
      text(bodyC,x+10,y+350);
    }
  }
  
  void onCloseAction()
  {
    popupDraw[PN]=false;
    //println("test");
  }
  
  
  
  
}

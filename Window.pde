//super class that had all the things nessarry for windows on thye desktop
class Window{
  public float x,y,length,height;
  public boolean isFocused,isMinimized,mousePressedInWindow,movingWindow;
  public String title;
  public PImage icon;
  int mousePressedX,mousePressedY,moveOffsetX,moveOffsetY;
  Button titleBar;
  PApplet parent;
  
  public Window(PApplet parent,float x,float y,float length,float height,String title){
    this.x=x;
    this.y=y;
    this.length=length;
    this.height=height;
    this.title=title;
    titleBar=new Button(parent,x+1,y+1,length-2,18,title,240,240).setStrokeWeight(0);
    this.parent=parent;
  }
  
  final void draw(){
    if(!isMinimized){
      fill(240);
      if(isFocused){
        stroke(0);
      }else{
        stroke(160);
      }
      strokeWeight(1);
      rect(x,y,length,height);
      titleBar.draw();
      
      clip(x,y,length,height);//prevent drawing outside of the window area
      drawWindow();//draw Contence of the window
      noClip();
    }
  }
  
  void drawWindow(){}//this method is implmented by sub classes to accualy draw the content of the windows
  
  //returns true if the click was inside the area of the window
  final boolean mouseClicked(){
    if(!isMinimized){
      if(mouseX >= x && mouseX <= x + length && mouseY >= y && mouseY <= y + height){//if clicked within the window
        isFocused=true;
        mouseClickedInWindow((int)x-mouseX,(int)y-mouseY);
        return true;
      }else{
        isFocused=false;
      }
    }
    
    return false;
  }
  
  void mouseClickedInWindow(int x,int y){}//this method is implmented by sub classes to process mouse clicked that happen within the window
  
  final void keyPressed(){
    if(!isMinimized && !isFocused){
      keyPressedWindow(key,keyCode);
    }
  }
  
  void keyPressedWindow(char key,int keyCode){}//this method is implmented by sub classes to process key pressed enevnts that happen while the window is focused
  
  final boolean mousePressed(){
    if(!isMinimized){
      if(mouseX >= x && mouseX <= x + length && mouseY >= y && mouseY <= y + height){//if clicked within the window
        isFocused=true;
        mousePressedInWindow=true;
        mousePressedX=mouseX;
        mousePressedY=mouseY;
        if(titleBar.isMouseOver()){
          moveOffsetX=(int)x-mouseX;
          moveOffsetY=(int)y-mouseY;
          movingWindow=true;
        }
        //title bar click things here
        mousePressedWindow((int)x-mouseX,(int)y-mouseY);
        return true;
      }else{
        isFocused=false;
      }
    }
    return false;
  }
  
  void mousePressedWindow(int x,int y){}
  
  final void mouseReleased(){
    if(mousePressedInWindow){
      if(movingWindow){
        int xdif=mouseX-mousePressedX,ydif=mouseY-mousePressedY;
        x=mousePressedX-moveOffsetX;
      }
    }
  }
  
  
}

//super class that had all the things nessarry for windows on thye desktop
class Window{
  public float x,y,length,height;
  public boolean isFocused,isMinimized,mousePressedInWindow,movingWindow;
  public String title;
  public PImage icon;
  public int PID;
  public int funScale;
  int mousePressedX,mousePressedY,moveOffsetX,moveOffsetY,funness;
  Button titleBar,minimiseButton,closeButton;
  PApplet parent;
  
  public Window(PApplet parent,float x,float y,float length,float height,String title,int processID){
    this.x=x;
    this.y=y;
    this.length=length;
    this.height=height;
    this.title=title;
    titleBar=new Button(parent,x+1,y+1,length-2,18,title,240,240).setStrokeWeight(0);
    this.parent=parent;
    closeButton=new Button(parent,x+length-22,y+1,22,18,"X",#FF0000,240).setStrokeWeight(0).setTextColor(255);
    minimiseButton=new Button(parent,x+length-closeButton.lengthX-22,y+1,22,18,"-",230,220).setStrokeWeight(0);
    this.PID=processID;
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
      
      closeButton.draw();
      minimiseButton.draw();
      
      if(movingWindow){
        processRelocateWindow();
      }
    }
  }
  
  void drawWindow(){}//this method is implmented by sub classes to accualy draw the content of the windows
  
  //returns true if the click was inside the area of the window
  final boolean mouseClicked(){
    if(!isMinimized){
      if(mouseX >= x && mouseX <= x + length && mouseY >= y && mouseY <= y + height){//if clicked within the window
        isFocused=true;
        if(closeButton.isMouseOver()){
          closeButtonPressed();
        }
        if(minimiseButton.isMouseOver()){
          isMinimized=true;
          isFocused=false;
          return true;
        }
        
        mouseClickedInWindow(mouseX-(int)x,mouseY-(int)y);
        return true;
      }else{
        isFocused=false;
      }
    }
    
    return false;
  }
  
  void mouseClickedInWindow(int x,int y){}//this method is implmented by sub classes to process mouse clicked that happen within the window
  
  final void keyPressed(){
    if(!isMinimized && isFocused){
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
        mousePressedWindow(mouseX-(int)x,mouseY-(int)y);
        return true;
      }else{
        isFocused=false;
      }
    }
    return false;
  }
  
  void mousePressedWindow(int x,int y){}//this method is implmented by sub classes
  
  final void mouseReleased(){
    if(mousePressedInWindow){
      if(movingWindow){
        processRelocateWindow();
        movingWindow=false;
      }
      mouseReleasedWindow(mouseX-(int)x,mouseY-(int)y);
      mousePressedInWindow=false;
    }
  }
  
  void mouseReleasedWindow(int x,int y){}//this method is implmented by sub classes
  
  //moves the window and button on the top of the window when the window is in the proscess of moving
  private void processRelocateWindow(){
    int xdif=mouseX-mousePressedX,ydif=mouseY-mousePressedY;
    x=(mousePressedX+xdif)+moveOffsetX;
    y=(mousePressedY+ydif)+moveOffsetY;
    titleBar.x=x+1;
    titleBar.y=y+1;
    closeButton.x=x+length-22;
    closeButton.y=y+1;
    minimiseButton.x=x+length-closeButton.lengthX-22;
    minimiseButton.y=y+1;
  }
  
  private void closeButtonPressed(){
    onCloseAction();
    //remove window from window list
  }
  //called when the close window button is pressed
  void onCloseAction(){}//this method is implmented by sub classes
  
  void tick(){};//this method is implmented by sub classes
  
  int processID(){
    return PID;
  }
  
}

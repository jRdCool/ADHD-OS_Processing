import processing.core.PApplet;
class WindowButton extends Button{
  float windowX,windowY;
  private ADHD_OS.Window window;
  WindowButton(ADHD_OS.Window window, float X, float Y, float DX, float DY) {
    super(window.parent,window.x+X,window.y+Y,DX,DY);
    windowX=X;
    windowY=Y;
    this.window=window;
  }
  WindowButton(ADHD_OS.Window window, float X, float Y, float DX, float DY, String Text) {
    super(window.parent,window.x+X,window.y+Y,DX,DY,Text);
    windowX=X;
    windowY=Y;
    this.window=window;
  }
  WindowButton(ADHD_OS.Window window, float X, float Y, float DX, float DY, int c1, int c2) {
    super(window.parent,window.x+X,window.y+Y,DX,DY,c1,c2);
    windowX=X;
    windowY=Y;
    this.window=window;
  }
  WindowButton(ADHD_OS.Window window, float X, float Y, float DX, float DY, String Text, int c1, int c2) {
    super(window.parent,window.x+X,window.y+Y,DX,DY,Text,c1,c2);
    windowX=X;
    windowY=Y;
    this.window=window;
  }
  
  public Button draw() {
    window.parent.strokeWeight(0);
    window.parent.fill(sColor);
    window.parent.rect(windowX+window.x-strokeWeight, windowY+window.y-strokeWeight, lengthX+strokeWeight*2, lengthY+strokeWeight*2);
    window.parent.fill(fColor);
    window.parent.rect(windowX+window.x, windowY+window.y, lengthX, lengthY);
    window.parent.fill(textcolor);
    window.parent.textAlign(PApplet.CENTER, PApplet.CENTER);
    if (!text.equals("")) {
      window.parent.textSize(textScaleFactor);
      window.parent.text(text, lengthX/2+windowX+window.x, lengthY/2+windowY+window.y);
    }
    return this;
  }
  
  public boolean isMouseOver() {
    return window.parent.mouseX>=windowX+window.x&&window.parent.mouseX<=windowX+window.x+lengthX&&window.parent.mouseY>=window.y&&window.parent.mouseY<=window.y+lengthY;
  }
}

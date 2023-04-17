class TextEditor extends Window {
  TextEditor(PApplet parent) {
    super(parent, 200, 100, 1520, 880, "conTEXTual",1,textEditorICO,true);
  }

  String documentContent="Test";
  CursorPos cursorPos=new CursorPos(-1);
  boolean cursor =true;
  int lastCursorChangeTime=0;

  void drawWindow() {
    fill(230);
    rect(x+1, y+20, length-1, 60);
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);
    text(documentContent, x+10, y+90);
    if (cursorPos.pos==-1) {
      cursorPos.pos=documentContent.length();
      if (cursorPos.pos<0) {
        cursorPos.pos=0;
      }
    }
    int cursorLineNo=0, indexOfLastLine=0;
    for (int i=0; i<cursorPos.pos; i++) {
      if (documentContent.charAt(i)=='\n') {
        cursorLineNo++;
        indexOfLastLine=i;
      }
    }

    if (cursor)
      rect(x+10+textWidth(documentContent.substring(indexOfLastLine, cursorPos.pos)), y+95+cursorLineNo*33.2, 1, 20);

    if (millis()-lastCursorChangeTime>250) {
      cursor=!cursor;
      lastCursorChangeTime=millis();
    }
  }

  void keyPressedWindow(char key, int keyCode) {
    documentContent=processKeyboardInput(documentContent, key, keyCode, 5, cursorPos);
  }

  void mousePressedWindow(int x, int y) {
    if (y>95) {
      textSize(20);
      int vertPos=y-95;
      vertPos=(int)(vertPos/33.2);
      boolean lineExsists=false;
      int lineBegin=0, lineEnd=documentContent.length(), linesFound=0;
      for (int i=0; i<documentContent.length(); i++) {
        if (linesFound==vertPos) {
          if (documentContent.charAt(i)=='\n') {
            lineEnd=i;
            lineExsists=true;
            break;
          }
          if(i==documentContent.length()-1){
            lineExsists=true;
          }
        } else {
          if (documentContent.charAt(i)=='\n') {
            linesFound++;
            if (linesFound==vertPos)
              lineBegin=i;
          }
        }
      }

      if (!lineExsists) {
        cursorPos.pos=documentContent.length();
      } else {
        lineExsists=false;
        String line = documentContent.substring(lineBegin+1, lineEnd);
        for (int i=0; i<line.length(); i++) {
          if (x<=textWidth(line.substring(0, i))+10) {
            cursorPos.pos=lineBegin+i;
            lineExsists=true;
            break;
          }
        }
        if (!lineExsists) {
          cursorPos.pos=lineEnd;
        }
      }
    }
  }
  
  void onCloseAction()
  {
    
    
  }
  
  
}

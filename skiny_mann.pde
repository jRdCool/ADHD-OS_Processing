public class skiny_mann extends Window {
  public skiny_mann(PApplet parent) {
    super(parent, 100, 100, 1280, 720, "Skinny Mann", 2, skinnyMannIcon);
    Level.source=this;
    Stage.source=this;
    StageComponent.source=this;
    icon=skinnyMannIcon;
    for (int i=0; i<players.length; i++) {
      players[i]=new Player(20, 699, 1, 0);
    }
    loadLevel("data/levels/level-1");
  }
  boolean reachedEnd=false, checkpointIn3DStage, level_complete, E_pressed, setPlayerPosTo,viewingItemContents,e3DMode;
  String rootPath, author, displayText;
  JSONArray mainIndex;
  Level level;
  int currentStageIndex, respawnX, respawnY, respawnStage, drawCamPosX, drawCamPosY, currentPlayer=0, coinCount, displayTextUntill, selectedIndex, stageIndex, tpCords[]=new int[3], gmillis,viewingItemIndex=-1,camPos,camPosY;
  Player players[]=new Player[10];
  ArrayList<Boolean> coins;
  float Scale=1;

  void drawWindow() {
    stageLevelDraw();
  }

  void mouseClickedInWindow(int x, int y) {
  }

  void keyPressedWindow(char key, int keyCode) {
  }

  void mousePressedWindow(int x, int y) {
  }

  void mouseReleasedWindow(int x, int y) {
  }

  void stageLevelDraw() {
    Stage stage=level.stages.get(currentStageIndex);
    fill(stage.skyColor);//sky color
    rect(1,1,1280,720);
    int selectIndex=-1;//reset the selected obejct
    if (E_pressed&&viewingItemContents) {//if you are viewing the contence of an element and you press E
      E_pressed=false;//close the contence of the eleiment
      viewingItemContents=false;
      viewingItemIndex=-1;
    }
    if (stage.type.equals("stage")) {//if tthe cuurent thing that is being drawn is a stage
      e3DMode=false;//turn 3D mode off
      drawCamPosX=camPos;//versions of the camera position variblaes that only get updated once every frame and not on every physics tick
      drawCamPosY=camPosY;
      for (int i=0; stageLoopCondishen(i, stage); i++) {//loop through all elements in the stage
        noStroke();
        stage.parts.get(i).draw();//draw the element
        if (viewingItemContents&&viewingItemIndex==-1) {//if the current element has decided that you want to view it's contence but no element has been selected
          viewingItemIndex=i;//set the cuurent viewing item to this element
        }
      }
      players[currentPlayer].in3D=false;

      draw_mann(Scale*(players[currentPlayer].getX()-drawCamPosX), Scale*(players[currentPlayer].getY()+drawCamPosY), players[currentPlayer].getPose(), Scale*players[currentPlayer].getScale(), players[currentPlayer].getColor());//draw this users player
      players[currentPlayer].stage=currentStageIndex;
      //====================================================================================================================================================================================================
      //====================================================================================================================================================================================================
    }


    if (level_complete) {//if the level has been completed
      textAlign(LEFT, BOTTOM);
      textSize(Scale*100);//draw the level complete thing
      fill(255, 255, 0);
      text("LEVEL COMPLETE!!!", Scale*200, Scale*400);

      fill(255, 126, 0);
      stroke(255, 0, 0);
      strokeWeight(Scale*10);

      if (level.multyplayerMode!=2) {
        rect(Scale*550, Scale*450, Scale*200, Scale*40);//continue button
        fill(0);
        textSize(Scale*40);
        text("continue", Scale*565, Scale*485);
      }
    }
  }

  void loadLevel(String fdp) {
    try {
      reachedEnd=false;
      rootPath=fdp;
      mainIndex=loadJSONArray(rootPath+"/index.json");
      level=new Level(mainIndex);
    }
    catch(Throwable e) {
      e.printStackTrace();
    }
  }

  boolean gameVersionCompatibilityCheck(String createdVersion) {
    return true;
  }

  JSONArray loadJSONArray(String s) {
    return parent.loadJSONArray(s);
  }

  void fill(int c) {
    parent.fill(c);
  }
  void fill(int r, int g, int b) {
    parent.fill(r, g, b);
  }

  void rect(float x, float y, float width, float height) {
    parent.rect(this.x+x, this.y+y, width, height);
  }

  void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    parent.triangle(x+ x1, y+y2, x+   x2, y+y2, x+   x3, y+y3);
  }
  void circle(float x1, float y1, float d) {
    parent.circle(x+x1, y+y1, d);
  }

  void ellipse(float x1, float y1, float mx, float my) {
    parent.ellipse(x+x1, y+y1, mx, my);
  }

  void textSize(float s) {
    parent.textSize(s);
  }

  int millis() {
    return parent.millis();
  }

  void strokeWeight(float s) {
    parent.strokeWeight(s);
  }
  
  boolean stageLoopCondishen(int i, Stage stage) {
      return i<stage.parts.size();
  }

  void drawCoin(float x, float y, float Scale) {
    fill(#FCC703);
    circle(x, y, 12*Scale);
    fill(255, 255, 0);
    circle(x, y, 10*Scale);
    fill(#FCC703);
    rect(x-2*Scale, y-3*Scale, 4*Scale, 6*Scale);
  }

  void drawPortal(float x, float y, float scale) {
    fill(0);
    ellipse(x, y, 50*scale, 100*scale);
    fill(#AE00FA);
    ellipse(x, y, 35*scale, 80*scale);
    fill(0);
    ellipse(x, y, 20*scale, 60*scale);
    fill(#AE00FA);
    ellipse(x, y, 5*scale, 40*scale);
  }
  
  void draw_mann(float x, float y, int pose, float scale, int shirt_color) {
  strokeWeight(0);
  if (shirt_color==0) {//red
    fill(255, 0, 0);
    stroke(255, 0, 0);
  }

  if (pose==1) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-10*scale, y-20*scale, scale*6, scale*10);
    rect(x+4*scale, y-20*scale, scale*6, scale*10);
    rect(x-10*scale, y-10*scale, scale*6, scale*10);
    rect(x+4*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==2) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-12*scale, y-20*scale, scale*6, scale*10);
    rect(x+6*scale, y-20*scale, scale*6, scale*10);
    rect(x-14*scale, y-10*scale, scale*6, scale*10);
    rect(x+8*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==3) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-13*scale, y-20*scale, scale*6, scale*10);
    rect(x+7*scale, y-20*scale, scale*6, scale*10);
    rect(x-18*scale, y-10*scale, scale*6, scale*10);
    rect(x+12*scale, y-10*scale, scale*6, scale*10);
  }
  if (pose==4) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-12*scale, y-30*scale, scale*6, scale*10);
    rect(x+6*scale, y-30*scale, scale*6, scale*10);
    rect(x-16*scale, y-20*scale, scale*6, scale*10);
    rect(x+10*scale, y-20*scale, scale*6, scale*10);
    rect(x-19*scale, y-10*scale, scale*6, scale*10);
    rect(x+15*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==5) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-13*scale, y-20*scale, scale*6, scale*10);
    rect(x+7*scale, y-20*scale, scale*6, scale*10);
    rect(x-18*scale, y-10*scale, scale*6, scale*10);
    rect(x+12*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==6) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-12*scale, y-20*scale, scale*6, scale*10);
    rect(x+6*scale, y-20*scale, scale*6, scale*10);
    rect(x-14*scale, y-10*scale, scale*6, scale*10);
    rect(x+8*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==7) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-10*scale, y-20*scale, scale*6, scale*10);
    rect(x+4*scale, y-20*scale, scale*6, scale*10);
    rect(x-10*scale, y-10*scale, scale*6, scale*10);
    rect(x+4*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==8) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-8*scale, y-20*scale, scale*6, scale*10);
    rect(x+2*scale, y-20*scale, scale*6, scale*10);
    rect(x-6*scale, y-10*scale, scale*6, scale*10);
    rect(x+1*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==9) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-7*scale, y-20*scale, scale*6, scale*10);
    rect(x+1*scale, y-20*scale, scale*6, scale*10);
    rect(x-2*scale, y-10*scale, scale*6, scale*10);
    rect(x-4*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==10) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-8*scale, y-30*scale, scale*6, scale*10);
    rect(x+2*scale, y-30*scale, scale*6, scale*10);
    rect(x-4*scale, y-20*scale, scale*6, scale*10);
    rect(x-4*scale, y-20*scale, scale*6, scale*10);
    rect(x+2*scale, y-10*scale, scale*6, scale*10);
    rect(x-7*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==11) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-7*scale, y-20*scale, scale*6, scale*10);
    rect(x+1*scale, y-20*scale, scale*6, scale*10);
    rect(x-2*scale, y-10*scale, scale*6, scale*10);
    rect(x-4*scale, y-10*scale, scale*6, scale*10);
  }

  if (pose==12) {
    rect(x-10*scale, y-55*scale, scale*20, scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale, y-75*scale, scale*30, scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale, y-30*scale, scale*6, scale*10);
    rect(x+4*scale, y-30*scale, scale*6, scale*10);
    rect(x-8*scale, y-20*scale, scale*6, scale*10);
    rect(x+2*scale, y-20*scale, scale*6, scale*10);
    rect(x-6*scale, y-10*scale, scale*6, scale*10);
    rect(x+1*scale, y-10*scale, scale*6, scale*10);
  }
}
}

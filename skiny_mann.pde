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
  boolean reachedEnd=false, checkpointIn3DStage,level_complete,E_pressed,setPlayerPosTo;
  String rootPath, author,displayText;
  JSONArray mainIndex;
  Level level;
  int currentStageIndex, respawnX, respawnY, respawnStage, drawCamPosX, drawCamPosY, currentPlayer=0,coinCount,displayTextUntill,selectedIndex,stageIndex,tpCords[]=new int[3],gmillis;
  Player players[]=new Player[10];
  ArrayList<Boolean> coins;
  float Scale=1;

  void drawWindow() {
  }

  void mouseClickedInWindow(int x, int y) {
  }

  void keyPressedWindow(char key, int keyCode) {
  }

  void mousePressedWindow(int x, int y) {
  }

  void mouseReleasedWindow(int x, int y) {
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
  void fill(int r,int b,int g){
    parent.fill(r,g,b);
  }

  void rect(float x, float y, float width, float height) {
    parent.rect(this.x+x, this.y+y, width, height);
  }

  void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    parent.triangle(x+ x1, y+y2, x+   x2, y+y2, x+   x3, y+y3);
  }
  void circle(float x1,float y1,float d){
    parent.circle(x+x1,y+y1,d);
  }
  
  void ellipse(float x1,float y1,float mx,float my){
    parent.ellipse(x+x1,y+y1,mx,my);
  }
  
  void textSize(float s){
    parent.textSize(s);
  }
  
  int millis(){
    return parent.millis();
  }
  
  void strokeWeight(float s){
    parent.strokeWeight(s);
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
}

public class skiny_mann extends Window {
  public skiny_mann(PApplet parent) {
    super(parent, 100, 100, 1280, 720, "Skinny Mann", 2, skinnyMannIcon);
    Level.source=this;
    Stage.source=this;
    StageComponent.source=this;
    icon=skinnyMannIcon;
    gamePhysicsLoop=true;
    for (int i=0; i<players.length; i++) {
      players[i]=new Player(20, 699, 1, 0);
    }
    loadLevel("data/levels/level-1");
    thread("gamePhysicsThread");
    dead=false;
  }
  boolean reachedEnd=false, checkpointIn3DStage, level_complete, E_pressed, setPlayerPosTo, viewingItemContents, e3DMode,player1_moving_left,player1_moving_right,player1_jumping,dead=false;
  String rootPath, author, displayText;
  JSONArray mainIndex;
  Level level;
  int currentStageIndex, respawnX, respawnY, respawnStage, drawCamPosX, drawCamPosY, currentPlayer=0, coinCount, displayTextUntill, selectedIndex, stageIndex, tpCords[]=new int[3], gmillis, viewingItemIndex=-1, camPos, camPosY,mspc,eadgeScroleDist=600,eadgeScroleDistV=200,death_cool_down=600,curMills,lasMills;
  Player players[]=new Player[10];
  ArrayList<Boolean> coins;
  float Scale=1,gravity=0.001;

  void drawWindow() {
    stageLevelDraw();
    if (dead) {// when  dead
      fill(255, 0, 0);
      textSize(50*Scale);
      text("you died", x+500*Scale, y+360*Scale);
      death_cool_down++;
      if (death_cool_down>75) {// respawn cool down
        dead=false;
        player1_moving_right=false;
        player1_moving_left=false;
        player1_jumping=false;
      }
    }
    fill(255);
    textSize(50*Scale);
    textAlign(LEFT, TOP);
    text("coins: "+coinCount, x, y);
    if (millis()<gmillis) {
      glitchEffect();
    }
    if (displayTextUntill>=millis()) {
      fill(255);
      textSize(200*Scale);
      textAlign(CENTER, CENTER);
      text(displayText, x+length/2, y+height*0.2);
    }
  }

  void mouseClickedInWindow(int x, int y) {
  }

  void keyPressedWindow(char key, int keyCode) {
    if (keyCode==65) {//if A is pressed
        player1_moving_left=true;
      }
      if (keyCode==68) {//if D is pressed
        player1_moving_right=true;
      }
      if (keyCode==32) {//if space is pressed
        player1_jumping=true;
      }
      if (key=='e'||key=='E') {
        E_pressed=true;
      }
  }
  
  void keyReleasedWindow(char key,int keyCode){
  if (keyCode==65) {//if A is pressed
        player1_moving_left=false;
      }
      if (keyCode==68) {//if D is pressed
        player1_moving_right=false;
      }
      if (keyCode==32) {//if space is pressed
        player1_jumping=false;
      }
      if (key=='e'||key=='E') {
        E_pressed=false;
      }
  }

  void mousePressedWindow(int x, int y) {
  }

  void mouseReleasedWindow(int x, int y) {
  }
  
  void onCloseAction(Taskbar tb,int processID){
    gamePhysicsLoop=false;
  }

  void stageLevelDraw() {
    Stage stage=level.stages.get(currentStageIndex);
    fill(stage.skyColor);//sky color
    rect(1, 1, 1280, 720);
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
      text("LEVEL COMPLETE!!!", x+Scale*200, y+Scale*400);

      fill(255, 126, 0);
      stroke(255, 0, 0);
      strokeWeight(Scale*10);

      if (level.multyplayerMode!=2) {
        rect(Scale*550, Scale*450, Scale*200, Scale*40);//continue button
        fill(0);
        textSize(Scale*40);
        text("continue", x+Scale*565, y+Scale*485);
      }
    }
  }
  
  void physicsThread(){
    curMills=millis();
    mspc=curMills-lasMills;
    if (true) {
      try {
        playerPhysics();
      }
      catch(Throwable e) {
      }
    } else {
      random(10);//some how make it so it doesent stop the thread
    }
    lasMills=curMills;
  }

  void playerPhysics() {
    int calcingPlayer = currentPlayer;

    if (true) {
      if (player1_moving_right) {//move the player right
        float newpos=players[calcingPlayer].getX()+mspc*0.4;//calculate new position
        if (!level_colide(newpos+10, players[calcingPlayer].getY())) {//check if the player can walk up "stairs"
          if (!level_colide(newpos+10, players[calcingPlayer].getY()-25)) {//check if there is something blocking the player 25 from his feet
            if (!level_colide(newpos+10, players[calcingPlayer].getY()-50)) {//check if there is something blocking the player 50 from his feet
              if (!level_colide(newpos+10, players[calcingPlayer].getY()-75)) {//check if there is something blocking the player 75 from his feet
                players[calcingPlayer].setX(newpos);//move the player if all is good
              }
            }
          }
        } else if ((!level_colide(newpos+10, players[calcingPlayer].getY()-10)&&!level_colide(newpos+10, players[calcingPlayer].getY()-50)&&!level_colide(newpos+10, players[calcingPlayer].getY()-75))&&players[calcingPlayer].verticalVelocity<0.008) {//check if the new posaition would place the player inside of a wall
          if (!level_colide(newpos+10, players[calcingPlayer].getY()-1)) {//autojump move the player up if they could concivaly go up a stair
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-1);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-2)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-2);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-3)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-3);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-4)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-4);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-5)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-5);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-6)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-6);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-7)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-7);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-8)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-8);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-9)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-9);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-10)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-10);
          }
        }

        if (players[calcingPlayer].getAnimationCooldown()<=0) {//change the player pose to make them look like there waljking
          players[calcingPlayer].setPose(players[calcingPlayer].getPose()+1);
          players[calcingPlayer].setAnimationCooldown(4);
          if (players[calcingPlayer].getPose()==13) {
            players[calcingPlayer].setPose(1);
          }
        } else {
          players[calcingPlayer].setAnimationCooldown(players[calcingPlayer].getAnimationCooldown()-0.05*mspc);//animation cooldown
        }
      }

      if (player1_moving_left) {//player moving left
        float newpos=players[calcingPlayer].getX()-mspc*0.4;//calculte new position
        if (!level_colide(newpos-10, players[calcingPlayer].getY())) {//check if the player can walk up "stairs"
          if (!level_colide(newpos-10, players[calcingPlayer].getY()-25)) {//check if there is something blocking the player 25 from his feet
            if (!level_colide(newpos-10, players[calcingPlayer].getY()-50)) {//check if there is something blocking the player 50 from his feet
              if (!level_colide(newpos-10, players[calcingPlayer].getY()-75)) {//check if there is something blocking the player 75 from his feet
                players[calcingPlayer].setX(newpos);//move the player
              }
            }
          }
        } else if ((!level_colide(newpos-10, players[calcingPlayer].getY()-10)&&!level_colide(newpos-10, players[calcingPlayer].getY()-50)&&!level_colide(newpos-10, players[calcingPlayer].getY()-75))&&players[calcingPlayer].verticalVelocity<0.008) {//check if the new posaition would place the player inside of a wall
          if (!level_colide(newpos+10, players[calcingPlayer].getY()-1)) {//autojump move the player up if they could concivaly go up a stair
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-1);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-2)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-2);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-3)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-3);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-4)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-4);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-5)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-5);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-6)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-6);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-7)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-7);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-8)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-8);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-9)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-9);
          } else if (!level_colide(newpos-10, players[calcingPlayer].getY()-10)) {
            players[calcingPlayer].setX(newpos);
            players[calcingPlayer].setY(players[calcingPlayer].getY()-10);
          }
        }

        if (players[calcingPlayer].getAnimationCooldown()<=0) {//change the player pose to make them look lie there walking
          players[calcingPlayer].setPose(players[calcingPlayer].getPose()-1);
          players[calcingPlayer].setAnimationCooldown(4);
          if (players[calcingPlayer].getPose()==0) {
            players[calcingPlayer].setPose(12);
          }
        } else {
          players[calcingPlayer].setAnimationCooldown(players[calcingPlayer].getAnimationCooldown()-0.05*mspc);//animation cooldown
        }
      }

      if (!player1_moving_right&&!player1_moving_left) {//reset the player pose if the player is not moving
        players[calcingPlayer].setPose(1);
        players[calcingPlayer].setAnimationCooldown(4);
      }



      if (true) {//gravity
        float pd = (players[calcingPlayer].verticalVelocity*mspc+0.5*gravity*(float)java.lang.Math.pow(mspc, 2))+players[calcingPlayer].y;//calculate the new verticle position the player shoud be at

        if ((!level_colide(players[calcingPlayer].getX()-10, pd)&&!level_colide(players[calcingPlayer].getX()-5, pd)&&!level_colide(players[calcingPlayer].getX(), pd)&&!level_colide(players[calcingPlayer].getX()+5, pd)&&!level_colide(players[calcingPlayer].getX()+10, pd))) {//check if that location would be inside of the ground
          if ((!level_colide(players[calcingPlayer].getX()-10, pd-75-1)&&!level_colide(players[calcingPlayer].getX()-5, pd-75-1)&&!level_colide(players[calcingPlayer].getX(), pd-75-1)&&!level_colide(players[calcingPlayer].getX()+5, pd-75-1)&&!level_colide(players[calcingPlayer].getX()+10, pd-75-1))||players[calcingPlayer].verticalVelocity>0.001) {//check if that location would cause the player's head to be indide of something
            players[calcingPlayer].verticalVelocity=players[calcingPlayer].verticalVelocity+gravity*mspc;//calculate the players new verticle velocity
            players[calcingPlayer].y=pd;//update the postiton of the player
          } else {
            players[calcingPlayer].verticalVelocity=0;//stop the player's verticle motion
          }
        } else {
          players[calcingPlayer].verticalVelocity=0;//stop the player's verticle motion
        }
      }

      //in ground detection and rectification
      if (!(!level_colide(players[calcingPlayer].getX()-10, players[calcingPlayer].getY())&&!level_colide(players[calcingPlayer].getX()-5, players[calcingPlayer].getY())&&!level_colide(players[calcingPlayer].getX(), players[calcingPlayer].getY())&&!level_colide(players[calcingPlayer].getX()+5, players[calcingPlayer].getY())&&!level_colide(players[calcingPlayer].getX()+10, players[calcingPlayer].getY()))) {//check if the player's position is in the ground
        players[calcingPlayer].setY(players[calcingPlayer].getY()-1);//move the player up
        players[calcingPlayer].verticalVelocity=0;//stop verticle veloicty
      }


      if (player1_jumping) {//jumping
        if (!(!level_colide(players[calcingPlayer].getX()-10, players[calcingPlayer].getY()+2)&&!level_colide(players[calcingPlayer].getX()-5, players[calcingPlayer].getY()+2)&&!level_colide(players[calcingPlayer].getX(), players[calcingPlayer].getY()+2)&&!level_colide(players[calcingPlayer].getX()+5, players[calcingPlayer].getY()+2)&&!level_colide(players[calcingPlayer].getX()+10, players[calcingPlayer].getY()+2))) {//check if the player is on the ground
          players[calcingPlayer].verticalVelocity=-0.75;  //if the player is on the ground and they are trying to jump then set thire verticle velocity
        }
      } else if (players[calcingPlayer].verticalVelocity<0) {//if the player stops pressing space bar before they stop riseing then start moving the player down
        players[calcingPlayer].verticalVelocity=0.01;
      }



      if (players[calcingPlayer].getX()-camPos>(1280-eadgeScroleDist)) {//move the camera if the player goes too close to the end of the screen
        camPos=(int)(players[calcingPlayer].getX()-(1280-eadgeScroleDist));
      }


      if (players[calcingPlayer].getX()-camPos<eadgeScroleDist&&camPos>0) {//move the camera if the player goes too close to the end of the screen
        camPos=(int)(players[calcingPlayer].getX()-eadgeScroleDist);
      }

      if (players[calcingPlayer].getY()+camPosY>720-eadgeScroleDistV&&camPosY>0) {//move the camera if the player goes too close to the end of the screen
        camPosY-=players[calcingPlayer].getY()+camPosY-(720-eadgeScroleDistV);
      }

      if (players[calcingPlayer].getY()+camPosY<eadgeScroleDistV+75) {//move the camera if the player goes too close to the end of the screen
        camPosY-=players[calcingPlayer].getY()+camPosY-(eadgeScroleDistV+75);
      }
      if (camPos<0)//prevent the camera from moving out of the valid areia
        camPos=0;
      if (camPosY<0)
        camPosY=0;
    }
    if (players[calcingPlayer].getY()>720) {//kill the player if they go below the stage
      dead=true;
      death_cool_down=0;
    }

    if (dead) {//if the player is dead
      currentStageIndex=respawnStage;//go back to the stage they last checkpointed on
      stageIndex=respawnStage;

      players[calcingPlayer].setX(respawnX);//move the player back to their spawnpoint
      players[calcingPlayer].setY(respawnY);
    }
    if (setPlayerPosTo) {//move the player to a position that is wanted
      players[calcingPlayer].setX(tpCords[0]).setY(tpCords[1]);
      players[calcingPlayer].z=tpCords[2];
      setPlayerPosTo=false;
      players[calcingPlayer].verticalVelocity=0;
    }
    //////////////////////////////
  }
  /**check if a point is inside of a solid object
   
   */
  boolean level_colide(float x, float y) {
    Stage stage=level.stages.get(currentStageIndex);
    for (int i=0; stageLoopCondishen(i, stage); i++) {
      if (stage.parts.get(i).colide(x, y, false)) {
        return true;
      }
    }



    return false;
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
  
  void fill(int r, int g, int b,int a) {
    parent.fill(r, g, b,a);
  }

  void rect(float x, float y, float width, float height) {
    parent.rect(this.x+x, this.y+y, width, height);
  }

  void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    parent.triangle(x+x1, y+y1, x+x2, y+y2, x+x3, y+y3);
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
  
  void glitchEffect() {
  int n=millis()/100%10;
  //n=9;
  strokeWeight(0);
  if (n==0) {
    fill(0, 255, 0, 120);
    rect(12*Scale, 30*Scale, 200*Scale, 80*Scale);
    rect(800*Scale, 300*Scale, 100*Scale, 300*Scale);
    rect(400*Scale, 240*Scale, 500*Scale, 20*Scale);
    fill(124, 0, 250, 120);
    rect(620*Scale, 530*Scale, 240*Scale, 50*Scale);
    rect(100*Scale, 400*Scale, 300*Scale, 40*Scale);
    rect(50*Scale, 600*Scale, 550*Scale, 20*Scale);
    fill(115, 0, 58, 120);
    rect(720*Scale, 90*Scale, 360*Scale, 112*Scale);
    rect(150*Scale, 619*Scale, 203*Scale, 90*Scale);
    rect(526*Scale, 306*Scale, 266*Scale, 165*Scale);
  }
  if (n==1) {
    fill(0, 255, 0, 120);
    rect(925*Scale, 60*Scale, 89*Scale, 96*Scale);
    rect(305*Scale, 522*Scale, 84*Scale, 140*Scale);
    rect(13*Scale, 332*Scale, 234*Scale, 313*Scale);
    fill(124, 0, 250, 120);
    rect(716*Scale, 527*Scale, 317*Scale, 111*Scale);
    rect(318*Scale, 539*Scale, 233*Scale, 118*Scale);
    rect(902*Scale, 3*Scale, 255*Scale, 42*Scale);
    fill(115, 0, 58, 120);
    rect(163*Scale, 150*Scale, 221*Scale, 127*Scale);
    rect(216*Scale, 142*Scale, 7*Scale, 49*Scale);
    rect(538*Scale, 224*Scale, 41*Scale, 48*Scale);
  }
  if (n==2) {
    fill(0, 255, 0, 120);
    rect(410*Scale, 335*Scale, 94*Scale, 74*Scale);
    rect(45*Scale, 222*Scale, 276*Scale, 90*Scale);
    rect(871*Scale, 287*Scale, 268*Scale, 174*Scale);
    fill(124, 0, 250, 120);
    rect(996*Scale, 535*Scale, 18*Scale, 28*Scale);
    rect(722*Scale, 523*Scale, 82*Scale, 107*Scale);
    rect(263*Scale, 201*Scale, 161*Scale, 88*Scale);
    fill(115, 0, 58, 120);
    rect(697*Scale, 436*Scale, 165*Scale, 44*Scale);
    rect(843*Scale, 486*Scale, 98*Scale, 105*Scale);
    rect(755*Scale, 20*Scale, 151*Scale, 51*Scale);
  }
  if (n==3) {
    fill(0, 255, 0, 120);
    rect(5*Scale, 228*Scale, 226*Scale, 131*Scale);
    rect(813*Scale, 428*Scale, 83*Scale, 60*Scale);
    rect(285*Scale, 452*Scale, 166*Scale, 135*Scale);
    fill(124, 0, 250, 120);
    rect(277*Scale, 514*Scale, 11*Scale, 87*Scale);
    rect(905*Scale, 152*Scale, 8*Scale, 160*Scale);
    rect(369*Scale, 80*Scale, 279*Scale, 153*Scale);
    fill(115, 0, 58, 120);
    rect(179*Scale, 96*Scale, 159*Scale, 65*Scale);
    rect(432*Scale, 296*Scale, 47*Scale, 12*Scale);
    rect(944*Scale, 412*Scale, 22*Scale, 50*Scale);
  }
  if (n==4) {
    fill(0, 255, 0, 120);
    rect(679*Scale, 159*Scale, 76*Scale, 168*Scale);
    rect(144*Scale, 58*Scale, 180*Scale, 61*Scale);
    rect(950*Scale, 89*Scale, 155*Scale, 13*Scale);
    fill(124, 0, 250, 120);
    rect(542*Scale, 463*Scale, 177*Scale, 156*Scale);
    rect(527*Scale, 70*Scale, 115*Scale, 28*Scale);
    rect(211*Scale, 151*Scale, 58*Scale, 164*Scale);
    fill(115, 0, 58, 120);
    rect(88*Scale, 440*Scale, 278*Scale, 23*Scale);
    rect(642*Scale, 440*Scale, 231*Scale, 91*Scale);
    rect(737*Scale, 524*Scale, 69*Scale, 71*Scale);
  }
  if (n==5) {
    fill(0, 255, 0, 120);
    rect(226*Scale, 71*Scale, 291*Scale, 37*Scale);
    rect(91*Scale, 436*Scale, 210*Scale, 8*Scale);
    rect(396*Scale, 72*Scale, 10*Scale, 136*Scale);
    fill(124, 0, 250, 120);
    rect(666*Scale, 274*Scale, 175*Scale, 171*Scale);
    rect(251*Scale, 513*Scale, 280*Scale, 13*Scale);
    rect(663*Scale, 141*Scale, 290*Scale, 33*Scale);
    fill(115, 0, 58, 120);
    rect(900*Scale, 47*Scale, 315*Scale, 125*Scale);
    rect(10*Scale, 156*Scale, 231*Scale, 73*Scale);
    rect(377*Scale, 253*Scale, 175*Scale, 22*Scale);
  }
  if (n==6) {
    fill(0, 255, 0, 120);
    rect(756*Scale, 447*Scale, 205*Scale, 161*Scale);
    rect(304*Scale, 341*Scale, 276*Scale, 144*Scale);
    rect(4*Scale, 141*Scale, 35*Scale, 176*Scale);
    fill(124, 0, 250, 120);
    rect(307*Scale, 98*Scale, 204*Scale, 89*Scale);
    rect(478*Scale, 476*Scale, 44*Scale, 52*Scale);
    rect(620*Scale, 57*Scale, 242*Scale, 144*Scale);
    fill(115, 0, 58, 120);
    rect(495*Scale, 374*Scale, 199*Scale, 62*Scale);
    rect(724*Scale, 71*Scale, 34*Scale, 2*Scale);
    rect(853*Scale, 88*Scale, 199*Scale, 114*Scale);
  }
  if (n==7) {
    fill(0, 255, 0, 120);
    rect(276*Scale, 181*Scale, 220*Scale, 38*Scale);
    rect(955*Scale, 514*Scale, 33*Scale, 51*Scale);
    rect(621*Scale, 135*Scale, 100*Scale, 74*Scale);
    fill(124, 0, 250, 120);
    rect(200*Scale, 333*Scale, 165*Scale, 99*Scale);
    rect(709*Scale, 503*Scale, 84*Scale, 117*Scale);
    rect(212*Scale, 275*Scale, 238*Scale, 27*Scale);
    fill(115, 0, 58, 120);
    rect(787*Scale, 477*Scale, 115*Scale, 9*Scale);
    rect(239*Scale, 443*Scale, 155*Scale, 149*Scale);
    rect(794*Scale, 267*Scale, 185*Scale, 80*Scale);
  }
  if (n==8) {
    fill(0, 255, 0, 120);
    rect(543*Scale, 498*Scale, 22*Scale, 125*Scale);
    rect(749*Scale, 151*Scale, 79*Scale, 174*Scale);
    rect(667*Scale, 380*Scale, 311*Scale, 45*Scale);
    fill(124, 0, 250, 120);
    rect(886*Scale, 193*Scale, 87*Scale, 50*Scale);
    rect(135*Scale, 128*Scale, 151*Scale, 83*Scale);
    rect(651*Scale, 128*Scale, 20*Scale, 85*Scale);
    fill(115, 0, 58, 120);
    rect(862*Scale, 374*Scale, 319*Scale, 136*Scale);
    rect(258*Scale, 149*Scale, 65*Scale, 143*Scale);
    rect(299*Scale, 63*Scale, 297*Scale, 152*Scale);
  }
  if (n==9) {
    fill(0, 255, 0, 120);
    rect(953*Scale, 386*Scale, 11*Scale, 30*Scale);
    rect(453*Scale, 104*Scale, 50*Scale, 95*Scale);
    rect(71*Scale, 157*Scale, 23*Scale, 49*Scale);
    fill(124, 0, 250, 120);
    rect(373*Scale, 447*Scale, 28*Scale, 136*Scale);
    rect(598*Scale, 321*Scale, 227*Scale, 19*Scale);
    rect(500*Scale, 314*Scale, 218*Scale, 113*Scale);
    fill(115, 0, 58, 120);
    rect(423*Scale, 512*Scale, 295*Scale, 30*Scale);
    rect(186*Scale, 489*Scale, 208*Scale, 76*Scale);
    rect(178*Scale, 269*Scale, 117*Scale, 133*Scale);
  }
}
}

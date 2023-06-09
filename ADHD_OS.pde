int ADHDMode=0,timerMin=5,timerSec=00,frame=0;
boolean introScreen=true,desktop=false,onDesktop=false,textEditor=false,initilizing=true,isFocused=true,timeAware=true,overdrive=false,credits=false,counterStarted=false,startScreen=true,mathComplete=false,typingComplete=false,drawingComplete=false,levelComplete=false,enteringEmail=false,gamePhysicsLoop,tasksComplete;
PImage desktopImage,ico0,ico1,ico2,recycleBin,textEditorICO,taskListBackground,mathProblemsICO,imageEdditorICO,smallBrush,mediumBrush,largeBrush,eraserICO,fillTool,isThisHelping,beesStuff,catLady,apple,car,skinnyMannIcon,minecrftIcon;
PImage[] icons;
String timerDisplay,email="";
PImage canvas=createImage(1518,761,RGB);
PImage[] rickRoll=new PImage[103];

boolean[] popupDraw=new boolean[70];;

int iconSize = 75;
int iconSpaceing=iconSize+20;

int[] iconRows,iconColums,taskbarSlots;
int[][] icoIDstorage;

int taskbarVPos=1005,numTaskbarSlots=10,taskbarHPos=300;
int writingFun;
int pixelsEddited=0;

Button start,websightLink,emailEnter;

Popup failedToLoad;
ArrayList<Window> windows=new ArrayList<>();
Popup[] popups=new Popup[9];
Popup[] sugestions=new Popup[20];
Button[][] desktopIcons=new Button[7][7];
Button[] taskbarButtons=new Button[numTaskbarSlots];
Taskbar taskbar;
Button[] AMScale=new Button[10],WGScale=new Button[10];
int scalex=210,AMSy=475,WGSy=670,scaleButtonSize=70;
int AMS=5,WGS=5;
CursorPos emailCursor=new CursorPos(-1);
String[] emailParse;



void settings(){
  if((displayHeight<=1080) && (displayWidth<=1920))
  {
    fullScreen();
  }
  else
  {
    size(1920,1080);
  }
}

void setup(){
  frameRate(60);
  ico0=loadImage("data/icons/icon0.png");
  ico0.resize(iconSize,iconSize);
  ico1=loadImage("data/icons/icon1.png");
  ico1.resize(iconSize,iconSize);
  ico2=loadImage("data/icons/icon2.png");
  ico2.resize(iconSize,iconSize);

  recycleBin=loadImage("data/icons/recycle.jpeg");
  recycleBin.resize(iconSize,iconSize);
  textEditorICO=loadImage("data/icons/text_edditor.png");
  textEditorICO.resize(iconSize,iconSize);
  taskListBackground=loadImage("data/taskListBackground.png");
  skinnyMannIcon=loadImage("data/assets/skinny mann face.PNG");
  skinnyMannIcon.resize(iconSize,iconSize);
  mathProblemsICO=loadImage("data/icons/math_problems.png");
  mathProblemsICO.resize(iconSize,iconSize);
  imageEdditorICO=loadImage("data/icons/image_edditor.jpg");
  imageEdditorICO.resize(iconSize,iconSize);
  smallBrush=loadImage("data/small_brush.png");
  mediumBrush=loadImage("data/medium_brush.png");
  largeBrush=loadImage("data/large_brush.png");
  fillTool=loadImage("data/fill_tool.png");
  eraserICO=loadImage("data/eraser.png");
  isThisHelping=loadImage("data/is_this_helping.png");
  beesStuff=loadImage("data/honey_comb.png");
  catLady=loadImage("data/cat_lady.jpg");
  catLady.resize(260,150);
  apple=loadImage("data/apple.png");
  car=loadImage("data/car.png");
  minecrftIcon=loadImage("data/icons/minecraft_icon.png");
  minecrftIcon.resize(iconSize,iconSize);
  for(int i=0;i<103;i++)
  {
    if(i<9)
    {
      rickRoll[i]=loadImage("/data/rr/000"+(i+1)+".png");
    }
    else if(i<99)
    {
      rickRoll[i]=loadImage("/data/rr/00"+(i+1)+".png");
    }
    else
    {
      rickRoll[i]=loadImage("/data/rr/0"+(i+1)+".png");
    }
    //rickRoll[i].resize(260,150);
  }

  for(int i=0;i<10;i++)
  {
    if(i!=4)
    {
      AMScale[i]=new Button(this,scalex+((scaleButtonSize+6)*i),AMSy,scaleButtonSize,scaleButtonSize,i+1+"",230,170);
      WGScale[i]=new Button(this,scalex+((scaleButtonSize+6)*i),WGSy,scaleButtonSize,scaleButtonSize,i+1+"",230,170);
    }
    else
    {
      AMScale[i]=new Button(this,scalex+((scaleButtonSize+6)*i),AMSy,scaleButtonSize,scaleButtonSize,i+1+"",230,0);
      WGScale[i]=new Button(this,scalex+((scaleButtonSize+6)*i),WGSy,scaleButtonSize,scaleButtonSize,i+1+"",230,0);
    }
  }

  canvas.loadPixels();
  for(int i=0;i<canvas.pixels.length;i++)
  {
    canvas.pixels[i]= #FFFFFF;
  }
  canvas.updatePixels();

  taskbar=new Taskbar(this,numTaskbarSlots,taskbarHPos,taskbarVPos,iconSpaceing);
  start=new Button(this,700,950,500,100,"start",#22FF22,0);
  websightLink=new Button(this,760,800,400,100);
  emailEnter=new Button(this,1150,550,750,75,"example@example.com",255,170).setTextColor(130);

  icons = new PImage[3];
  
  icons[0]=ico0;
  icons[1]=ico1;
  icons[2]=ico2;
  
  icoIDstorage = new int[7][7];

  iconRows   = new int[7];
  iconColums = new int[7];
  
  //-------------setting icon locations-------------//
  iconRows[0]=50;
  for(int i=1; i<iconRows.length; i++)
  {
    iconRows[i]=(iconRows[i-1]+iconSpaceing);
    //println(iconRows[i]);
  }
  iconColums[0]=50;
  for(int i=1; i<iconColums.length; i++)
  {
    iconColums[i]=(iconColums[i-1]+iconSpaceing);
    //println(iconColums[i]);
  }
  
  for(int i=0;i<desktopIcons.length;i++){
    for(int j=0;j<desktopIcons[i].length;j++){
      desktopIcons[i][j]=new Button(this,iconColums[i],iconRows[j],iconSize,iconSize,i+","+j);
    }
  }
  
  failedToLoad=new Popup(this,9,600,200,"Program Failed to load", "The program","failed to load!!!", "This is most likly","because it is fake.");
  
  popups[0]=new Popup(this,0,550,350,"Test?",isThisHelping,"This is a test.","Is this helping?");
  popups[1]=new Popup(this,1,300,300,"Bee Movie",beesStuff,"According to all known","laws of aviation,","there is no way a bee","should be able to fly.");
  popups[2]=new Popup(this,2,400,500,"Warranty?",car,"Hello, I am contacting","you about your car's","extended warranty");
  popups[3]=new Popup(this,3,800,200,"Rick Roll","Get Rick Rolled","LOL :P");
  popups[4]=new Popup(this,4,1000,300,"Dare",apple,"I dare you, to","hold your toungue ","and say: apple");
  popups[5]=new Popup(this,5,432,600,"Rice","I want to fill a","baloon with rice");
  popups[6]=new Popup(this,6,1300,600,"Seen my cat?",catLady,"Have you seen","My cat?");
  popups[7]=new Popup(this,7,1200,200,"Knock, Knock?","Knock, Knock.","Who's there?","Kanga     Kanga who?","No silly it's kangaroo");
  popups[8]=new Popup(this,8,300,300,"test","The power of christ","compells you");
  //test =
  desktopImage=loadImage("data/ADHDOS_desktop_rev2.png");
  desktopImage.resize(width,height);
}

//==========================================Draw==========================================//
void draw(){
  frame++;
  //----------------------------Credits----------------------------//
  if(credits)
  {
    background(#AAAAAA);
    
    fill(0);
    textSize(75);
    textAlign(CENTER,CENTER);
    text("Developers:",960,50);
    text("Textures:",960,250);
    text("Concept by:",960,450);
    text("Skinny Man:",960,650);
    
    textSize(50);
    text("Joseph Duffy",960,130);
    text("Stephen Duffy",960,180);
    text("Joseph Duffy",960,330);
    text("Kat B.",960,380);
    text("Kat B.",960,530);
    text("Developed by Stephen Duffy",960,730);
    text("Available at:",960,780);
    fill(#0000FF);
    text("cbi-games.org",960,830);
   
  }
  
  
  //----------------------------Start Screen----------------------------//
  if(startScreen)
  {
    background(#CBCBCB);
    textAlign(CENTER,CENTER);
    textSize(73);
    text("You will have about "+timerMin+" min to complete a series of tasks.",960,100);
    text("During that time you will experience a few 'Interesting' things.",960,200);
    text("Do your best and have fun.",960,300);
    
    textSize(40);
    text("What do find more fun?",580,400);
    text("Writing",130,500);
    text("Math",1060,500);

    text("Art",130,700);
    text("Gaming",1060,700);
    
    noStroke();
    for(int i=0;i<10;i++)
    {
      AMScale[i].draw();
      WGScale[i].draw();
    }
    if(!email.equals("") || enteringEmail)
    {
      emailEnter.setText(email);
      emailEnter.setTextColor(0);
    }

    emailEnter.draw();
    start.draw();
  }
  
  
  //----------------------------Desktop----------------------------//
  if(desktop)
  {
    background(desktopImage);
    taskbar.draw();
    if(timeAware)
    {
      if(timerMin!=0)
      {
        if(timerSec>=10)
          timerDisplay="   "+timerMin+":"+timerSec;
        else
          timerDisplay="   "+timerMin+":0"+timerSec;
        
      }
      else
        timerDisplay=""+timerSec;
    }
    else
    {
      int randomMin=(int)random(5,200)+timerMin;
      int randomSec=(int)random(60,134)+timerSec;
      if(randomMin>99)
      {
        timerDisplay=randomMin+":"+randomSec;
      }
      else if(randomMin>9)
      {
        timerDisplay=" "+randomMin+":"+randomSec; 
      }
      else
      {
        timerDisplay="  "+randomMin+":"+randomSec;
      }
      
    }
    
    
    //---------Todo list---------//
    fill(255);
    stroke(255);
    //rect(1500,0,420,350);
    image(taskListBackground,1500,0);
    stroke(0);
    fill(0);
    textSize(30);
    textAlign(CENTER,BOTTOM);
    text(timerDisplay,1710,35);
    text("Write a couple sentences",1715,85);
    text("Complete 3 math problems",1715,125);
    text("draw a house",1715,168);
    text("complete 1 level of a game",1715,202);
    checkBox(1515,60,typingComplete);
    checkBox(1515,100,mathComplete);
    checkBox(1515,143,drawingComplete);
    checkBox(1515,177,levelComplete);


    
    
    
    


    //----------icons and lables------------//
    fill(0);
    stroke(0);
    textSize(18);
    textAlign(CENTER,CENTER);
    image(recycleBin,iconColums[0],iconRows[0]);
    text("Recycleing Bin",iconColums[0]+(iconSize/2),iconRows[0+1]-10);
    image(textEditorICO,iconColums[0],iconRows[1]);
    text("conTEXTual",iconColums[0]+(iconSize/2),iconRows[1+1]-10);
    image(skinnyMannIcon,iconColums[0],iconRows[2]);
    text("skinny mann", iconColums[0]+(iconSize/2),iconRows[2+1]-10);
    image(mathProblemsICO,iconColums[0],iconRows[3]);
    text("Mo-Problems",iconColums[0]+(iconSize/2),iconRows[3+1]-10);
    image(imageEdditorICO,iconColums[1],iconRows[0]);
    text("Artist",iconColums[1]+(iconSize/2),iconRows[0+1]-10);
    image(minecrftIcon,iconColums[1],iconRows[1]);
    text("MineClone",iconColums[1]+(iconSize/2),iconRows[1+1]-10);
    
    for(int i=0;i<windows.size();i++){
      windows.get(i).draw();
    }
    for(int i=0;i<70;i++)
    {
      if(popupDraw[i])
      {
        if(i<9)
        {
          popups[i].draw();
        }
        if(i==9)
        {
          failedToLoad.draw();
        }
      }
    }
  }
  if(pixelsEddited>1000)
  {
    drawingComplete=true;
  }
  

  
  initilizing=false;
//-------------------------frame calculations
  //text(frame,960,540);
  //text(frame%60,960,590);
  if(frame%60==0&&counterStarted)
  {
    if((timerMin==0&&timerSec==0)||tasksComplete)
    {
      if(desktop)
      {
        if(new File(sketchPath()+"/email_list.txt").exists())
        {
          println("file Found");
          String[] list = loadStrings("email_list.txt");
          String[] appendedList=new String[list.length+1];
          for(int i=0;i<list.length;i++)
          {
            appendedList[i]=list[i];
          }
          appendedList[list.length]=email;
          saveStrings("email_list.txt",appendedList);
        }
        else
        {
          println("file NOT Found");
          saveStrings("email_list.txt",new String[]{email});
        }
      }
      credits=true;
      desktop=false;
      counterStarted=false;
    }
    else
    {
      timerSec--;
      if(timerSec==-1)
      {
        timerSec=59;
        timerMin-=1;
      }
    }
    if(timerSec%5==0)
    {
      int state;
      if(taskbar.slotsUsed()==0)
      {
        state=5;
      }

      else
      {
        state=windows.get(windows.size()-1).readFunScale();
      }
      stateCheck(state);
    }
  }
  
  tasksComplete=(levelComplete&&drawingComplete&&typingComplete&&mathComplete);
  
}


//====================================================Mouse Clicked====================================================//
void mouseClicked(){
  //println(mouseX+" "+mouseY);

  //---------------------------Desktop---------------------------------//
  if(desktop)
  {
    for(int i=0;i<windows.size();i++){
      windows.get(i).isFocused=false;
    }
    int winNum=windows.size();
    boolean onWindow=false;
    for(int i=windows.size()-1;i>=0&&windows.size()>0;i--){
      if(windows.get(i).mouseClicked(taskbar)){
        if(windows.size()==winNum && i!=windows.size()-1){
          windows.add(windows.remove(i));
        }
        onWindow=true;
        break;
      }
    }
    taskbar.mouseClicked();
    for(int i=0;i<9;i++)
    {
      if(popupDraw[i])
      {
        popups[i].mouseClicked(taskbar);
      }
    }
    failedToLoad.mouseClicked(taskbar);

    if(!onWindow){
      if(desktopIcons[0][0].isMouseOver()||desktopIcons[1][1].isMouseOver())
      {
        popupDraw[9]=true;
      }
      if(desktopIcons[0][1].isMouseOver()&&!isWindowAllreadyOpen(1))
      {
        //println(mouseX+" "+mouseY+" "+desktopIcons[0][1].isMouseOver()+" "+!isWindowAllreadyOpen(1));

        Window texteditor = new TextEditor(this,abs(AMS-11));
        //println(abs(AMS-11)+" Text Edditor Spawned");
        int slot=taskbar.addProcess(texteditor.processID(),texteditor);
        windows.add(texteditor);
      }


      if(desktopIcons[0][2].isMouseOver()&&!isWindowAllreadyOpen(2)){
        Window game = new skiny_mann(this,abs(WGS));
        int slot=taskbar.addProcess(game.processID(),game);
        windows.add(game);
      }



      if(desktopIcons[0][3].isMouseOver()&&!isWindowAllreadyOpen(3))
      {
        Window mathProblems=new Math(this,AMS);
        //println(AMS+" Mo-Problems Spawned");
        int slot=taskbar.addProcess(mathProblems.processID(),mathProblems);
        windows.add(mathProblems);
      }
      if(desktopIcons[1][0].isMouseOver()&&!isWindowAllreadyOpen(4))
      {
        Window imageditor=new Painter(this,abs(WGS-11));
        //println(abs(WGS-11)+" Painter Spawned");
        int slot=taskbar.addProcess(imageditor.processID(),imageditor);
        windows.add(imageditor);
      }
    }
  }

  //---------------------------------Start Screen------------------------------------//
  if(startScreen)
  {
    if(start.isMouseOver()&&!email.equals(""))
    {
      desktop=true;
      startScreen=false;
      counterStarted=true;
      emailParse=email.split("@");
      //test.setFunScale();
    }
    if(emailEnter.isMouseOver())
    {
      emailEnter.setColor(255,0);
      enteringEmail=true;
    }
    else
    {
      emailEnter.setColor(255,170);
      enteringEmail=false;
    }
    for(int i=0;i<10;i++)
    {
      if(AMScale[i].isMouseOver())
      {
        //println(i);
        AMScale[i].setColor(230,0);
        AMS=i+1;
        for(int j=0;j<10;j++)
        {
          if(j!=i)
          {
            AMScale[j].setColor(230,170);
          }
        }
      }
      if(WGScale[i].isMouseOver())
      {
        WGScale[i].setColor(230,0);
        WGS=i+1;
        for(int j=0;j<10;j++)
        {
          if(j!=i)
          {
            WGScale[j].setColor(230,170);
          }
        }
      }
    }
  }
  
  if(websightLink.isMouseOver()&&credits)
  {
    link("https://cbi-games.org");
  }
      
      
    
}
  
//====================================================Key Perssed====================================================//
void keyPressed(){
    for(int i=0;i<windows.size();i++){
      windows.get(i).keyPressed();
    }
    if(startScreen&&enteringEmail)
    {
      email=processKeyboardInput(email,key,keyCode,5,emailCursor);
    }
}

void keyReleased(){
    for(int i=0;i<windows.size();i++){
      windows.get(i).keyReleased();
    }

}

//====================================================Mouse Pressed====================================================//
void mousePressed(){
  for(int i=0;i<windows.size();i++){
    windows.get(i).isFocused=false;
  }
  for(int i=windows.size()-1;i>=0&&windows.size()>0;i--){
    if(windows.get(i).mousePressed()){
      if(i!=windows.size()-1){
        windows.add(windows.remove(i));
      }
      break;
    }
  }
}

//====================================================Mouse Released====================================================//
void mouseReleased(){
  for(int i=0;i<windows.size();i++){
      windows.get(i).mouseReleased();
  }
}



void stateCheck(int processType){//1=boring,10=fun
  //Focused
  int chance=0;
  switch (processType)
    {
      case 1: 
        chance+=10;
      case 2: 
        chance+=10;
      case 3: 
        chance+=10;
      case 4: 
        chance+=10;
      case 5: 
        chance+=10;
      case 6: 
        chance+=10;
      case 7: 
        chance+=10;
      case 8: 
        chance+=10;
      case 9: 
        chance+=10;
      case 10:
    }
  //println(chance);
  int randomNumber=(int)random(1,101);
  //println(randomNumber);
  if(randomNumber<chance)
  {
    int popDraw=(int)random(0,8);
    //int popDraw=7;
    //println("pop up spawned");
    popupDraw[popDraw]=true;
  }
  
  //time track
  int timeTrackTest=(int)random(0,2);
  //println(timeTrackTest);
  if(timeTrackTest==1)
  {
    if(timerMin!=0)
      timeAware=false;
    else
      timeAware=true;
  }
  else
    timeAware=true;
  
  //overdrive
  //gives advice that is not nessasarily useful
}

boolean isWindowAllreadyOpen(int PID){
  for(int i=0;i<windows.size();i++){
    if(windows.get(i).processID()==PID){
      return true;
    }
  }
  return false;
}

void gamePhysicsThread(){
  skiny_mann game=(skiny_mann)taskbar.getWindow(taskbar.slotLookUp(2));
  while(gamePhysicsLoop){
    game.physicsThread();
  }
}

void checkBox(float x, float y, boolean mark)
{
  stroke(0);
  noFill();
  strokeWeight(2);
  square(x,y,10);
  fill(0);
  stroke(#FF0000);
  strokeWeight(3);
  if(mark)
  {
    line(x,y+2,x+4,y+6);
    line(x+4,y+6,x+11,y-4);
  }

}

public void onTick()
  {
    while(true)
    {
      random(0,124);
      for(int i=0;i<windows.size();i++){
        windows.get(i).tick(mouseX,mouseY);
      }
    }
  }

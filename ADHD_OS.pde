int ADHDMode = 0,timerMin=5,timerSec=00,frame=0;
boolean introScreen=true,desktop=true,onDesktop=false,textEditor=false,initilizing=true,isFocused=true,timeAware=true,overdrive=false,credits=false,counterStarted=true;
PImage desktopImage,ico0,ico1,ico2;
PImage[] icons;
String timerDisplay;

int iconSize = 75;
int iconSpaceing=iconSize+20;

int[] iconRows,iconColums,taskbarSlots;
int[][] icoIDstorage;

int taskbarVPos=1005,numTaskbarSlots=10,taskbarHPos=300;

//ArrayList<Integer> taskbar=new ArrayList<>();

Window test,failedToLoad;
Window[] popups=new Popup[9];
Window[] sugestions=new Popup[20];
Button[][] desktopIcons=new Button[7][7];
Button[] taskbarButtons=new Button[numTaskbarSlots];
Taskbar taskbar;


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
  ico0=loadImage("icons/icon0.png");
  ico0.resize(iconSize,iconSize);
  ico1=loadImage("icons/icon1.png");
  ico1.resize(iconSize,iconSize);
  ico2=loadImage("icons/icon2.png");
  ico2.resize(iconSize,iconSize);
  
  taskbar=new Taskbar(numTaskbarSlots,taskbarHPos,taskbarVPos,iconSpaceing);
  
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
      desktopIcons[i][j]=new Button(this,iconColums[i],iconRows[j],iconSize,iconSize);
    }
  }
  
  
  
test = new TextEditor(this);
  desktopImage=loadImage("ADHDOS_desktop_rev1.png");
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
    text("concept by:",960,450);
    
    textSize(50);
    text("Joseph Duffy",960,130);
    text("Stephen Duffy",960,180);
    text("Joseph Duffy",960,330);
    text("Kat B.",960,380);
    text("Kat B.",960,530);
   
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
    rect(1600,0,320,350);
    stroke(0);
    fill(0);
    textSize(30);
    textAlign(CENTER,BOTTOM);
    text(timerDisplay,1760,35);
    
    
    
    
    //image(ico0,50,50);
    for(int i=0;i<iconRows.length; i++)
    {
      for(int j=0; j<iconColums.length; j++)
      {
        if(initilizing){icoIDstorage[j][i]=(int)random(0,3);}
        image(icons[icoIDstorage[j][i]],iconColums[j],iconRows[i]);
      }
    } 
  }
  
  
  
  initilizing=false;
//-------------------------frame calculations
  //text(frame,960,540);
  //text(frame%60,960,590);
  if(frame%60==0&&counterStarted)
  {
    if(timerMin==0&&timerSec==0)
    {
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
      stateCheck(5);
    }
  }
  
  

  test.draw();

}


//====================================================Mouse Clicked====================================================//
void mouseClicked(){
  test.mouseClicked();
  
  
      
      if(desktopIcons[0][0].isMouseOver())
      {
        int slot=taskbar.addProcess(icons[icoIDstorage[1][0]],test.processID());
        println(slot);
      }
      
    
}
  
//====================================================Key Perssed====================================================//
void keyPressed(){
    
    test.keyPressed();
    
}

//====================================================Mouse Pressed====================================================//
void mousePressed(){
test.mousePressed();
}

//====================================================Mouse Released====================================================//
void mouseReleased(){
test.mouseReleased();
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
    //println("pop up spawned");
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

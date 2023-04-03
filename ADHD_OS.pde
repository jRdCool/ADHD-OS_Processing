int ADHDMode = -1,timerMin,timerSec;
boolean introScreen=true,desktop=true,onDesktop=false,textEditor=false,initilizing=true;
PImage desktopImage,ico0,ico1,ico2;
PImage[] icons;

int iconSize = 75;
int iconSpaceing=iconSize+20;

int[] iconRows,iconColums;
int[][] icoIDstorage;

ArrayList<Integer> taskbar=new ArrayList<>();


Button[][] desktopIcons=new Button[7][7];


void settings(){
  if((displayHeight==1080) && (displayWidth==1920))
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
  
  icons = new PImage[3];
  
  icons[0]=ico0;
  icons[1]=ico1;
  icons[2]=ico2;
  
  icoIDstorage = new int[7][7];

  iconRows   = new int[7];
  iconColums = new int[7];
  
  iconRows[0]=50;
  for(int i=1; i<iconRows.length; i++)
  {
    iconRows[i]=(iconRows[i-1]+iconSpaceing);
    println(iconRows[i]);
  }
  iconColums[0]=50;
  for(int i=1; i<iconColums.length; i++)
  {
    iconColums[i]=(iconColums[i-1]+iconSpaceing);
    println(iconColums[i]);
  }
  
  for(int i=0;i<desktopIcons.length;i++){
    for(int j=0;j<desktopIcons[i].length;j++){
      desktopIcons[i][j]=new Button(this,iconColums[i],iconRows[j],iconSize,iconSize);
    }
  }
  

  desktopImage=loadImage("ADHDOS_desktop_rev1.png");
  desktopImage.resize(width,height);
}



void draw(){
  if(desktop)
  {
    background(desktopImage);
    
    
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
}



void mouseClicked(){
  
  
  
}
  
  
void keyPressed(){
    
    
    
    
    
}

void mousePressed(){

}

void mouseReleased(){

}



int stateCheck(int processType){
  int state=-1;
  
  
  
  return state;
}

int ADHDMode = -1,timerMin,timerSec;
boolean introScreen=true,desktop=true,onDesktop=false,textEditor=false;
PImage desktopImage,ico0,ico1,ico2;


int iconSize = 50;
int iconSpaceing=iconSize+10;

int[] iconRows,iconColums;


Button a1,a2,a3,a4,a5,a6,a7;
Button b1,b2,b3,b4,b5,b6,b7;
Button c1,c2,c3,c4,c5,c6,c7;
Button d1,d2,d3,d4,d5,d6,d7;
Button e1,e2,e3,e4,e5,e6,e7;
Button f1,f2,f3,f4,f5,f6,f7;
Button g1,g2,g3,g4,g5,g6,g7;


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

Window test;

void setup(){
  frameRate(60);
  ico0=loadImage("icons/icon0.png");
  ico0.resize(iconSize,iconSize);
  ico1=loadImage("icons/icon1.png");
  ico1.resize(iconSize,iconSize);
  ico2=loadImage("icons/icon2.png");
  ico2.resize(iconSize,iconSize);
  

  iconRows   = new int[7];
  iconColums = new int[14];
  
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
  
  
  
  
  
  
  
  

  desktopImage=loadImage("ADHDOS_desktop_rev1.png");
  desktopImage.resize(width,height);
}



void draw(){
  if(desktop)
  {
    background(desktopImage);
    test.draw();
    
    image(ico0,50,50);
  }
  
  
  
}



void mouseClicked(){
  test.mouseClicked();
  
  
  
}
  
  
void keyPressed(){
    
    
    
    
    
}



int stateCheck(int processType){
  int state=-1;
  
  
  
  return state;
}

int ADHDMode = -1;
boolean introScreen=true,desktop=true,onDesktop=false,textEditor=false;
PImage desktopImage,ico0,ico1,ico2;


int iconSize = 50;
int iconSpaceing=iconSize+10;

//--------------------------------desktop icon rows--------------------------------//
int iconRows [] = {50};

//--------------------------------desktop icon colloms--------------------------------//
int iconColum1=50;


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
  
  
  desktopImage=loadImage("ADHDOS_desktop_rev1.png");
  desktopImage.resize(width,height);
}



void draw(){
  if(desktop)
  {
    background(desktopImage);
    
    
    image(ico0,50,50);
  }
  
  
  
}



void mouseClicked(){
  
  
  
  
}
  
  
void keyPressed(){
    
    
    
    
    
}



int stateCheck(int processType){
  int state=-1;
  
  
  
  return state;
}

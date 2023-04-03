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
  
  //row a
  a1=new Button(this,iconColums[0],iconRows[0],iconSize,iconSize);
  a2=new Button(this,iconColums[1],iconRows[0],iconSize,iconSize);
  a3=new Button(this,iconColums[2],iconRows[0],iconSize,iconSize);
  a4=new Button(this,iconColums[3],iconRows[0],iconSize,iconSize);
  a5=new Button(this,iconColums[4],iconRows[0],iconSize,iconSize);
  a6=new Button(this,iconColums[5],iconRows[0],iconSize,iconSize);
  a7=new Button(this,iconColums[6],iconRows[0],iconSize,iconSize);
  
  //row b
  b1=new Button(this,iconColums[0],iconRows[1],iconSize,iconSize);
  b2=new Button(this,iconColums[1],iconRows[1],iconSize,iconSize);
  b3=new Button(this,iconColums[2],iconRows[1],iconSize,iconSize);
  b4=new Button(this,iconColums[3],iconRows[1],iconSize,iconSize);
  b5=new Button(this,iconColums[4],iconRows[1],iconSize,iconSize);
  b6=new Button(this,iconColums[5],iconRows[1],iconSize,iconSize);
  b7=new Button(this,iconColums[6],iconRows[1],iconSize,iconSize);
  
  //row c
  c1=new Button(this,iconColums[0],iconRows[2],iconSize,iconSize);
  c2=new Button(this,iconColums[1],iconRows[2],iconSize,iconSize);
  c3=new Button(this,iconColums[2],iconRows[2],iconSize,iconSize);
  c4=new Button(this,iconColums[3],iconRows[2],iconSize,iconSize);
  c5=new Button(this,iconColums[4],iconRows[2],iconSize,iconSize);
  c6=new Button(this,iconColums[5],iconRows[2],iconSize,iconSize);
  c7=new Button(this,iconColums[6],iconRows[2],iconSize,iconSize);
  
  //row d
  d1=new Button(this,iconColums[0],iconRows[3],iconSize,iconSize);
  d2=new Button(this,iconColums[1],iconRows[3],iconSize,iconSize);
  d3=new Button(this,iconColums[2],iconRows[3],iconSize,iconSize);
  d4=new Button(this,iconColums[3],iconRows[3],iconSize,iconSize);
  d5=new Button(this,iconColums[4],iconRows[3],iconSize,iconSize);
  d6=new Button(this,iconColums[5],iconRows[3],iconSize,iconSize);
  d7=new Button(this,iconColums[6],iconRows[3],iconSize,iconSize);
  
  //row e
  e1=new Button(this,iconColums[0],iconRows[4],iconSize,iconSize);
  e2=new Button(this,iconColums[1],iconRows[4],iconSize,iconSize);
  e3=new Button(this,iconColums[2],iconRows[4],iconSize,iconSize);
  e4=new Button(this,iconColums[3],iconRows[4],iconSize,iconSize);
  e5=new Button(this,iconColums[4],iconRows[4],iconSize,iconSize);
  e6=new Button(this,iconColums[5],iconRows[4],iconSize,iconSize);
  e7=new Button(this,iconColums[6],iconRows[4],iconSize,iconSize);
  
  //row f
  f1=new Button(this,iconColums[0],iconRows[5],iconSize,iconSize);
  f2=new Button(this,iconColums[1],iconRows[5],iconSize,iconSize);
  f3=new Button(this,iconColums[2],iconRows[5],iconSize,iconSize);
  f4=new Button(this,iconColums[3],iconRows[5],iconSize,iconSize);
  f5=new Button(this,iconColums[4],iconRows[5],iconSize,iconSize);
  f6=new Button(this,iconColums[5],iconRows[5],iconSize,iconSize);
  f7=new Button(this,iconColums[6],iconRows[5],iconSize,iconSize);
  
  //row g
  g1=new Button(this,iconColums[0],iconRows[6],iconSize,iconSize);
  g2=new Button(this,iconColums[1],iconRows[6],iconSize,iconSize);
  g3=new Button(this,iconColums[2],iconRows[6],iconSize,iconSize);
  g4=new Button(this,iconColums[3],iconRows[6],iconSize,iconSize);
  g5=new Button(this,iconColums[4],iconRows[6],iconSize,iconSize);
  g6=new Button(this,iconColums[5],iconRows[6],iconSize,iconSize);
  g7=new Button(this,iconColums[6],iconRows[6],iconSize,iconSize);
  
  
  
  

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

void mousePressed(){

}

void mouseReleased(){

}



int stateCheck(int processType){
  int state=-1;
  
  
  
  return state;
}

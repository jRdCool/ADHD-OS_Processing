class Painter extends Window
{
  Painter(PApplet parent)
  {
    super (parent, 200, 100, 1520, 880, "Artist",4,imageEdditorICO,true);
    
    int size=15;
    int spaceing=size+10;
    float startX=700,startY=800;
    
    for(int i=0;i<3;i++)
    {
      for(int j=0;j<5;j++)
      {
        colors[i][j]=new WindowButton(this,startX+(spaceing*j),startY+(spaceing*i),size,size);
      }
    }
    //----------row1----------//
    colors[0][0].setColor(red,170);
    colors[0][1].setColor(orange,170);
    colors[0][2].setColor(yellow,170);
    colors[0][3].setColor(green,170);
    colors[0][4].setColor(lime,170);
    //----------row1----------//
    colors[1][0].setColor(lightBlue,170);
    colors[1][1].setColor(blue,170);
    colors[1][2].setColor(purple,170);
    colors[1][3].setColor(pink,170);
    colors[1][4].setColor(magenta,170);
    //----------row1----------//
    colors[2][0].setColor(white,170);
    colors[2][1].setColor(lightGray,170);
    colors[2][2].setColor(gray,170);
    colors[2][3].setColor(black,170);
    colors[2][4].setColor(brown,170);
    
    for(int i=0;i<3;i++)
    {
      tools[i]=new WindowButton(this,toolG1+(toolSpace*i),toolY,toolSize,toolSize);
    }
    for(int i=3;i<5;i++)
    {
      tools[i]=new WindowButton(this,toolG2+(toolSpace*i),toolY,toolSize,toolSize);
    }
  }
  
  int toolG1=200,toolG2=800,toolY=800,toolSize=60,toolSpace=toolSize+30;
  
  color reD=#FF0000;
  int red=#FF0000,orange=#FF8800,yellow=#FFFF00,green=#00A100,lime=#00FF00,lightBlue=#00EAFF,blue=#0000FF,purple=#8A00D4;
  int pink=#F959FF,magenta=#FF00FF,white=#FFFFFF,lightGray=#AAAAAA,gray=#555555,black=#000000,brown=#472A09;
  
  int selectedColor;
  boolean drawing=false,eraseing=false;
  int brushType=1;
  
  //===========================================================total of 1,155,198 pixel in the painting===========================================================//
  
  
  WindowButton[][] colors=new WindowButton[3][5];
  WindowButton[] tools=new WindowButton[5];
  
  
  void drawWindow()
  {
    stroke(0);
    strokeWeight(2);
    fill(#F7FA57);
    rect(x+1,y+780,1518,100);
    for(int i=0;i<3;i++)
    {
      for(int j=0;j<5;j++)
      {
        //println(i+" "+j);
        colors[i][j].draw();
      }
    }
    
    for(int i=0;i<5;i++)
    {
      tools[i].draw();
    }
    //println(drawing);
    if(drawing)
    {
      tick(mouseX-(int)x-1,mouseY-(int)y-19,brushType,eraseing);
    }
    
    
    
    
    
    image(canvas,x+1,y+19);
    
    
  }
  
  
  
  //============================================mouse clicked============================================//
  void mouseClickedInWindow(int x,int y)
  {
    //----------------row 0---------------//
    if(colors[0][0].isMouseOver())
    {
      colors[0][0].setColor(reD,0);
      natColors(0,0);
      selectedColor=red;
    }
    if(colors[0][1].isMouseOver())
    {
      colors[0][1].setColor(orange,0);
      natColors(0,1);
      selectedColor=orange;
    }
    if(colors[0][2].isMouseOver())
    {
      colors[0][2].setColor(yellow,0);
      natColors(0,2);
      selectedColor=yellow;
    }
    if(colors[0][3].isMouseOver())
    {
      colors[0][3].setColor(green,0);
      natColors(0,3);
      selectedColor=green;
    }
    if(colors[0][4].isMouseOver())
    {
      colors[0][4].setColor(lime,0);
      natColors(0,4);
      selectedColor=lime;
    }
    
    //----------------row 1---------------//
    if(colors[1][0].isMouseOver())
    {
      colors[1][0].setColor(lightBlue,0);
      natColors(1,0);
      selectedColor=lightBlue;
    }
    if(colors[1][1].isMouseOver())
    {
      colors[1][1].setColor(blue,0);
      natColors(1,1);
      selectedColor=blue;
    }
    if(colors[1][2].isMouseOver())
    {
      colors[1][2].setColor(purple,0);
      natColors(1,2);
      selectedColor=purple;
    }
    if(colors[1][3].isMouseOver())
    {
      colors[1][3].setColor(pink,0);
      natColors(1,3);
      selectedColor=pink;
    }
    if(colors[1][4].isMouseOver())
    {
      colors[1][4].setColor(magenta,0);
      natColors(1,4);
      selectedColor=magenta;
    }
    
    //----------------row 2---------------//
    if(colors[2][0].isMouseOver())
    {
      colors[2][0].setColor(white,0);
      natColors(2,0);
      selectedColor=white;
    }
    if(colors[2][1].isMouseOver())
    {
      colors[2][1].setColor(lightGray,0);
      natColors(2,1);
      selectedColor=lightGray;
    }
    if(colors[2][2].isMouseOver())
    {
      colors[2][2].setColor(gray,0);
      natColors(2,2);
      selectedColor=gray;
    }
    if(colors[2][3].isMouseOver())
    {
      colors[2][3].setColor(black,0);
      natColors(2,3);
      selectedColor=black;
    }
    if(colors[2][4].isMouseOver())
    {
      colors[2][4].setColor(brown,0);
      natColors(2,4);
      selectedColor=brown;
    }
  }
  
  
  void mousePressedWindow(int x,int y)
  {
    if((x>1&&y>19)&&(x<1520&&y<779))
    {
      drawing=true;
    }
    
  }
  
  
  void mouseReleasedWindow(int x,int y)
  {
    drawing=false;
  }
  
  
  
  private void natColors(int row,int col)
  {
    //----------row1----------//
      if(!(col==0&&row==0)){colors[0][0].setColor(red,170);}
      if(!(col==1&&row==0)){colors[0][1].setColor(orange,170);}
      if(!(col==2&&row==0)){colors[0][2].setColor(yellow,170);}
      if(!(col==3&&row==0)){colors[0][3].setColor(green,170);}
      if(!(col==4&&row==0)){colors[0][4].setColor(lime,170);}
    //----------row1----------//
      if(!(col==0&&row==1)){colors[1][0].setColor(lightBlue,170);}
      if(!(col==1&&row==1)){colors[1][1].setColor(blue,170);}
      if(!(col==2&&row==1)){colors[1][2].setColor(purple,170);}
      if(!(col==3&&row==1)){colors[1][3].setColor(pink,170);}
      if(!(col==4&&row==1)){colors[1][4].setColor(magenta,170);}
    //----------row1----------//
      if(!(col==0&&row==2)){colors[2][0].setColor(white,170);}
      if(!(col==1&&row==2)){colors[2][1].setColor(lightGray,170);}
      if(!(col==2&&row==2)){colors[2][2].setColor(gray,170);}
      if(!(col==3&&row==2)){colors[2][3].setColor(black,170);}
      if(!(col==4&&row==2)){colors[2][4].setColor(brown,170);}
  }
  
  
  private void tick(int x, int y,int brush,boolean eraser)
  {
    println("running tick");
    canvas.loadPixels();
    int pixel = x * y;
    int sColor;
    if(eraser)
    {
      sColor=#FFFFFF;
    }
    else
    {
      sColor=selectedColor;
    }
    println(sColor);
    if(brush==0)//single pixel brush
    {
      println(pixel);
      canvas.pixels[pixel]=sColor;
    }
    if(brush==1)//5x5 pixel brush
    {
      for(int i=-2;i<=2;i++)
      {
        int locX=x+i;
        if(locX>=0&&locX<1518)
        {
          for(int j=-2;j<=2;j++)
          {
            int locY=y+j;
            if(locY>=0&&locY<761)
            {
              println(locX+" "+locY);
              pixel=locX+(locY*1518);
              canvas.pixels[pixel]=sColor;
            }
          }
        }
      }
    }
    if(brush==2)//11x11 pixel brush
    {
      
    }
    if(brush==3)
    {
      
    }
    if(brush==4)//Fill tool
    {
      
    }
    
    
    canvas.updatePixels();
  }
  
}

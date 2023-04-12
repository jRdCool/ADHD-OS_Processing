class Taskbar{
  public float[] HPos;
  private float x,y,iconScale;
  private int maxIcons,numTasks=0;
  private int[] processIDS;
  public PImage iconStore[];
  private Window[] windows;
  private Button[] barButtons;
  
  public Taskbar(PApplet parent,int maxIcons,float x, float y,float iconScale){
    this.x=x;
    this.y=y;
    this.iconScale=iconScale;
    this.maxIcons=maxIcons;
    barButtons=new Button[maxIcons];
    windows=new Window[maxIcons];
    iconStore=new PImage[maxIcons];
    processIDS=new int[maxIcons];
    HPos = new float[maxIcons];
    HPos[0]=x;
    for(int i=1;i<maxIcons;i++)
    {
      HPos[i]=HPos[i-1]+iconScale;
    }
    for(int i=0;i<maxIcons;i++)
    {
      barButtons[i]=new Button(parent,HPos[i],y,iconScale,iconScale);
    }
  }
  
  public int slotsUsed()
  {
    return numTasks;
  }
  
  public Taskbar draw()
  {
    //---------Taskbar---------//
    fill(0);
    stroke(0);
    rect(300,1000,1320,80);
    circle(300,1005,10);
    rect(295,1005,5,75);
    circle(1620,1005,10);
    rect(1620,1005,5,75);
    for(int i=0;i<numTasks;i++)
    {
      image(iconStore[i],HPos[i],y);
      //println(y);
    }
    
    return this;
  }
  
  public int addProcess(PImage icon, int processID,Window window)
  {
    if(processID==10)
    {
      return 10;
    }
    //println(numTasks);
    int slot=numTasks;
    processIDS[numTasks]=processID;
    iconStore[numTasks]=icon;
    windows[numTasks]=window;
    numTasks++;
    //println(numTasks);
    return slot;
  }
  
  public void removeProcess(int slot, int processID)
  {
    if(processID==10)
    {
      return;
    }
    if(processIDS[slot]==processID)
    {
      if(slot==(numTasks-1))
      {
        numTasks--;
        processIDS[slot]=-1;
        iconStore[slot]=null;
      }
      else
      {
        for(int i=0;i>numTasks-1;i++)
        {
          iconStore[slot]=iconStore[slot+1];
          processIDS[slot]=processIDS[slot+1];
        }
        processIDS[numTasks-1]=-1;
        iconStore[numTasks-1]=null;
        numTasks--;
      }
    }
    else
    {
      println("process id did not match slot number");
    } 
  }
  public int slotLookUp(int processID)
  {
    int slot;
    for(int i=0;i<numTasks;i++)
    {
      if(processID==processIDS[i])
      {
        return i;
      }
    }
    println("Process ID not found");
    return -1;
  }

  public boolean mouseClicked()
  {
    for(int i=0;i<numTasks;i++)
    {
      println(i);
      if(barButtons[i].isMouseOver())
      {
        windows[i].toggleMinimize(processIDS[i]);
        println("activated");
      }
    }
    
    return false;
  }
    
    
    
}

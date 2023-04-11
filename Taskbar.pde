class Taskbar{
  public float[] HPos;
  private float x,y,iconScale;
  private int maxIcons,numTasks;
  private int[] processIDS;
  public PImage iconStore[];
  
  public Taskbar(int maxIcons,float x, float y,float iconScale){
    this.x=x;
    this.y=y;
    this.iconScale=iconScale;
    this.maxIcons=maxIcons;
    iconStore=new PImage[maxIcons];
    processIDS=new int[maxIcons];
    HPos = new float[maxIcons];
    HPos[0]=x;
    for(int i=1;i<maxIcons;i++)
    {
      HPos[i]=HPos[i-1]+iconScale;
    }
  }
  
  public int slotsUsed()
  {
    return numTasks;
  }
  
  public Taskbar draw()
  {
    for(int i=0;i<numTasks;i++)
    {
      image(iconStore[i],HPos[i],y);
    }
  }
  
  public void addProcess(PImage icon, int slot, int processID)
  {
    
  }
  
  public int removeProcess(int slot, int processID)
  {
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
        
      }
    }
    else
    {
      println("process id did not match slot number");
    }
    
  }
  

    
    
    
    
}

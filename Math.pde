class Math extends Window{
  Math(PApplet parent,int funScale)
  {
    super(parent, 200, 100, 1520, 880, "Mo-Problems",3,mathProblemsICO,true,funScale);
    
    prob1=(int)random(0,problems.length);
    do
    {
      prob2=(int)random(0,problems.length);
    }
    while(prob1==prob2);
    do
    {
      prob3=(int)random(0,problems.length);
    }
    while((prob1==prob3)||(prob2==prob3)); 
    
    ansCursorPos[0] =new CursorPos(-1);
    ansCursorPos[1] =new CursorPos(-1);
    ansCursorPos[2] =new CursorPos(-1);
    
    parts1 = problems[prob1].split(" ");
    parts2 = problems[prob2].split(" ");
    parts3 = problems[prob3].split(" ");
    
    
  }
  
  WindowButton checkAnswers=new WindowButton(this,600,700,300,100,"Check Answers");
  WindowButton answer1=new WindowButton(this,30,200,300,50,255,155);
  WindowButton answer2=new WindowButton(this,30,400,300,50,255,155);
  WindowButton answer3=new WindowButton(this,30,600,300,50,255,155);
  
  boolean[] answerCursor={false,false,false};
  int answrSelected=-1;
  String[] answers={"","",""};
  CursorPos[] ansCursorPos=new CursorPos[3];
  int lastCursorChangeTime=0;
  
  String[] parts1; 
  String[] parts2; 
  String[] parts3;
  
  
  
  void drawWindow()
  {
    textSize(40);
    textAlign(LEFT,CENTER);
    text("Answer these 3 math problems, and where nessary solve for x",x+15,y+50);
    
    
    
    
    text(parts1[0],x+15,y+150);
    text(parts2[0],x+15,y+350);
    text(parts3[0],x+15,y+550);
    
    answer1.setText(answers[0]);
    answer2.setText(answers[1]);
    answer3.setText(answers[2]);
    
    
    answer1.draw();
    answer2.draw();
    answer3.draw();
    checkAnswers.draw();
    
    if(millis()-lastCursorChangeTime>250)
    {
      if(answrSelected!=-1)
      {
        answerCursor[answrSelected]=!answerCursor[answrSelected];
      }
      else
      {
        for(int i=0;i<3;i++)
        {
          answerCursor[i]=false;
        }
      }
      lastCursorChangeTime=millis();
    }
  }
  
  String[] problems=loadStrings("data/math.txt");
  
  
  int prob1,prob2,prob3;
  
  void mouseClickedInWindow(int x,int y)
  {
    if(answer1.isMouseOver())
    {
      //println("button1 hit");
      answrSelected=0;
      answer1.setColor(255,#FF00FF);
      answer2.setColor(255,155);
      answer3.setColor(255,155);
    }
    else if(answer2.isMouseOver())
    {
      //println("button2 hit");
      answrSelected=1;
      answer1.setColor(255,155);
      answer2.setColor(255,#FF00FF);
      answer3.setColor(255,155);
    }
    else if(answer3.isMouseOver())
    {
      //println("button3 hit");
      answrSelected=2;
      answer1.setColor(255,155);
      answer2.setColor(255,155);
      answer3.setColor(255,#FF00FF);
    }
    else
    {
      //println("no button hit");
      answrSelected=-1;
      answer1.setColor(255,155);
      answer2.setColor(255,155);
      answer3.setColor(255,155);
    }
    if(checkAnswers.isMouseOver())
    {
      if((answers[0].equals(parts1[1]))&&(answers[1].equals(parts2[1]))&&(answers[2].equals(parts3[1])))
      {
        mathComplete=true;
        answer1.setColor(255,#33FF33);
        answer2.setColor(255,#33FF33);
        answer3.setColor(255,#33FF33);
        checkAnswers.setColor(255,#33FF33);
      }
      else
      {
        text("Problems outlined in red are wrong",x+400,y+300);
        if(!(answers[0].equals(parts1[1])))
        {
          answer1.setColor(255,#FF0000);
        }
        if(!(answers[1].equals(parts2[1])))
        {
          answer2.setColor(255,#FF0000);
        }
        if(!(answers[2].equals(parts3[1])))
        {
          answer3.setColor(255,#FF0000);
        }
        
      }
    }
  }
  
  void keyPressedWindow(char key,int keyCode)
  {
    if(answrSelected!=-1)
    {
      answers[answrSelected]=processKeyboardInput(answers[answrSelected],key,keyCode,6,ansCursorPos[answrSelected]);
    }
  }  
}

/**used to easaly process keyboard inputs
 @param mode what charicter mode to use
 @param letter the char from the keyboard to be processed
 @returns a char that is compatbale with the selected mode
 */
char getCh(int mode, char leter) {
  if (mode==0) {
    if (Character.isLetter(leter)||leter==' ') {//mode 0 letters numbers and spcaes
      return leter;
    }
    if (leter==32) {
      return ' ';
    }

    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0')
      return leter;
  }
  if (mode==1) {//mode 1 number only
    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0')
      return leter;
  }
  if (mode==2) {//mode 2 ip mode(numbers and .)
    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0'||leter=='.')
      return leter;
  }
  if (mode==3) {//mode 3 mode 0 but also allows line returns and /
    if (Character.isLetter(leter)||leter==' ') {//mode 0 letters numbers and spcaes
      return leter;
    }
    if (leter==32) {
      return ' ';
    }

    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0'||leter=='\n'||leter=='/')
      return leter;
  }
  if (mode==4) {//mode 4 domain name mode. letter numbers and outher charicters found in domains
    if (Character.isLetter(leter)) {
      return leter;
    }
    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0'||leter=='.'||leter=='-'||leter=='_')
      return leter;
  }
  if(mode == 5){//mode 5 basically every printable char on a US keyboard
    if (Character.isLetter(leter)) {
      return leter;
    }
    String allowed="`~!@#$%^&*()_+-=[]{}\\|;:'\",./<>?1234567890\n\t ";
    for(int i=0;i<allowed.length();i++){
      if(leter==allowed.charAt(i))
      return leter;
    }
  }
  if (mode==6) {//mode 2 ip mode(numbers and .)
    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0'||leter=='.'||leter=='-')
      return leter;
  }

  return 0;
}

String processKeyboardInput(String in,char letter,int code,int restrictLVL,CursorPos cursorPos){
  if(cursorPos.pos==-1){
    cursorPos.pos=in.length();
    if(cursorPos.pos<0){
      cursorPos.pos=0;
    }
  }
  String out=in;
  if(getCh(restrictLVL,letter)==0){//if the pressed key is not an allowed char
    if(letter==BACKSPACE){
      if(cursorPos.pos!=0){
        if(cursorPos.pos==in.length()){
          out=in.substring(0,in.length()-1);
        }else{
          out=in.substring(0,cursorPos.pos-1) + in.substring(cursorPos.pos,in.length());
        }
        cursorPos.pos--;
      }
    }else if(code==LEFT){
      if(cursorPos.pos!=0)
        cursorPos.pos--;
    }else if(code==RIGHT){
      if(cursorPos.pos!=in.length())
        cursorPos.pos++;
    }
  }else{
    if(cursorPos.pos==in.length()){
      if(letter=='\t')
        out=in+"    ";
      else
        out=in+letter;
    }else{
      if(letter=='\t')
        out=in.substring(0,cursorPos.pos) + "    " + in.substring(cursorPos.pos,in.length());
      else
        out=in.substring(0,cursorPos.pos) + letter + in.substring(cursorPos.pos,in.length());
    }
    cursorPos.pos++;
    if(letter=='\t')
      cursorPos.pos+=3;
  }
  return out;
}

//an int that represent the position of the cursor in a string. this exsist so that the function and modify the value and it can be used later
class CursorPos{
 int pos; 
 CursorPos(int p){
  pos=p; 
 }
}

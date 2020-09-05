String input = "";
String num1="",num2="",op="";
Integer size = 1; //set original size
String textDisplay = "";

//array for create text on button
String[][] text_numbers =  { {"7","4","1"}, {"8","5","2"}, {"9","6","3"} };
String[][] text_others = { {"C","0"}, {"/","."} };
String[] text_operators = {"<-","*","-","+","="};
String[] text_resize = {"x1","x2"};

//set all color
color blue = color(15,76,129);
color white = color(255);
color black = color(0);
color blue_pastel = color(197,229,239);
color light_grey = color(244,239,239);

String StringGet(String text,int index){ // get text[index]
  if (text.length() > 0){
    char c = text.charAt(index);
    char[] d = {c};
    return new String(d);
  }
  else {
    return text;
  }
}

void setup()
{
    size(400,450); //window size : x1
    background(blue); //set color bg : dark blue
    drawElements();
}

void draw()
{
  drawElements();
}

void drawElements() //Draw all display io, text, buttons and image
{
    background(blue);
    scale(size);
    
    //Display input-output
    fill(white);
    rect(15,16,370,82,10); 
    noStroke();
    
    fill(black);
    textSize(22);
    text(textDisplay,18,57);

    //Buttons
    for (int i = 0; i < 5; i += 1 ){
       for (int k = 0; k < 5; k += 1) {
         if ( k < 2 && i < 2 ){
           fill(light_grey); // color : grey + white
           rect(15, 107+(244*k), 167, 58, 5); // Clear & Zero buttons 
           rect(185, 107+(244*k), 82, 58, 5); // Dot & Divide buttons
           noStroke();
         } 
         if ( k < 3 && i < 3 ){
           fill(white); // color : white
           rect(15+(85*i), 168+(61*k), 82, 58, 5); // number buttons 1-9
           noStroke();
         }
         if ( k < 4 && i < 4 ){
           fill(light_grey); // color : grey + white
           rect(270, 107+(61*k), 115, 58, 5); // backspace & operator buttons 
           noStroke();
         }
         if ( k == 4 ){
           fill(blue_pastel); // color : blue pastel
           rect(270, 107+(61*k), 115, 58, 5); // total buttons 
           noStroke();
         }
       }
       
    }
    
    //Text above buttons
    textSize(20);
    fill(blue); // color : blue same as bg
    for( int i=0 ; i < 5; i++ ){
      for (int k=0; k < 5; k++ ){
         if (i < 2 & k < 2){
           text(text_others[i][k], 93+(131*i), 140+(247*k)); // text Clear, Zero, Dot and Divide buttons
         }
         if (i < 3 & k < 3){
           text(text_numbers[i][k], 49+(84*i), 202+(61*k)); // text number 1-9
         }
         if (i < 5 & k < 5){
           text(text_operators[k], 322, 141+(61*k)); // text backspace , operators and total 
         }
      }
    }
    
    //choose size
    textSize(13);
    fill(white); // color : white
    text("Size : ",230,435);
    for (int i=0; i<2; i++){
        rect(282+(28*i)+i, 420, 21, 21, 5);
        noStroke();
    }
    fill(blue);
    for (int i=0; i<2; i++){
        text(text_resize[i], 286+(29*i), 435); //text size x1, x2
    }
}

void LEDprint(String text_display)
{
  textDisplay = text_display;
}



String click_opbtn(String input){ //case when click orepator buttons
  if (op == ""){
    op = input;
    return op;
  } else {
    if (num2 == ""){
      op = input;
      return op;
    } else {
      num1 = calculate(num1,op,num2).toString();
      num2 = "";
      op = input;
      return op;
      }
    }
}

String click_numbtn(String input){ //case when click number buttons
  if (num1 == ""){
    num1 = input;
    return num1;
  } else if (op == ""){
     num1 += input;
     return num1;  
    } else {
      num2 += input;
      return num2;
      }  
}

String click_dotbtn(String input){ //case when click dot button
  String num1_getStr = StringGet(num1,num1.length()-1);
  String num2_getStr = StringGet(num2,num2.length()-1);
  if (op == ""){
    if (num1_getStr.equals(".") == false){
      num1 += input;
      return num1;
    }
  } 
  else 
  {
     if (num2_getStr.equals(".") == false){
       num2 += input;
       return num2;
     }
  }
  return null;
}

String click_backspaceBtn(){ //case when click backspace button
  if (op == ""){
    num1 = num1.substring(0,num1.length()-1);
    return num1;
  }
  if (num2 == ""){
      op = "";
      return op;
  } 
  else {
      num2 = num2.substring(0,num2.length()-1);
      return num2;
  }
}

Float calculate(String num1, String op, String num2){
  Float num1_float = Float.parseFloat(num1);
  Float num2_float = Float.parseFloat(num2);
  Float total = -1.0;
  if (op.equals("+")){
    total = num1_float + num2_float;
  } else if (op.equals("-")){
    total = num1_float - num2_float;
  } else if (op.equals("*")){
    total = num1_float * num2_float;
  } else if (op.equals("/")){
    total = num1_float / num2_float;
  }
  return total;
}

void mouseClicked()
{
 if (15*size <= mouseX && mouseX <= (15+167)*size  &&  107*size <= mouseY && mouseY <= (107+58)*size) // C
  {
    input = "";
    num1 = ""; num2 = ""; op = "";
    LEDprint(input);
  }
  else if ( 15*size <= mouseX && mouseX <= (15+82)*size  &&  168*size <= mouseY && mouseY <= (168+58)*size) // 7
  {
    input = "7";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 100*size <= mouseX && mouseX <= (100+82)*size  &&  168*size <= mouseY && mouseY <= (168+58)*size) // 8
  {
    input = "8";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 185*size <= mouseX && mouseX <= (185+82)*size  &&  168*size <= mouseY && mouseY <= (168+58)*size) // 9
  {
    input = "9";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 15*size <= mouseX && mouseX <= (15+82)*size  &&  229*size <= mouseY && mouseY <= (229+58)*size) // 4
  {
    input = "4";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 100*size <= mouseX && mouseX <= (100+82)*size  &&  229*size <= mouseY && mouseY <= (229+58)*size) // 5
  {
    input = "5";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 185*size <= mouseX && mouseX <= (185+82)*size  &&  229*size <= mouseY && mouseY <= (229+58)*size) // 6
  {
    input = "6";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 15*size <= mouseX && mouseX <= (15+82)*size  &&  290*size <= mouseY && mouseY <= (290+58)*size) // 1
  {
    input = "1";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 100*size <= mouseX && mouseX <= (100+82)*size  &&  290*size <= mouseY && mouseY <= (290+58)*size) // 2  
  {
    input = "2";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 185*size <= mouseX && mouseX <= (185+82)*size  &&  290*size <= mouseY && mouseY <= (290+58)*size) // 3
  {
    input = "3";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 15*size <= mouseX && mouseX <= (15+167)*size   &&  351*size <= mouseY && mouseY <= (351+58)*size) // 0
  {
    input = "0";
    LEDprint(click_numbtn(input));
    input = "";
  }
  else if ( 185*size <= mouseX && mouseX <= (185+82)*size  &&  351*size <= mouseY && mouseY <= (351+58)*size) // "." dot
  {
    input = ".";
    LEDprint(click_dotbtn(input));
    input = "";
  }
  else if ( 270*size <= mouseX && mouseX <= (270+115)*size  &&  351*size <= mouseY && mouseY <= (351+58)*size) // total
  {
    input = "";
    num1 = calculate(num1,op,num2).toString();
    LEDprint(num1);
    num2 = ""; op = "";
  }
  else if ( 270*size <= mouseX && mouseX <= (270+115)*size  &&  107*size <= mouseY && mouseY <= (107+58)*size) // backspace
  {
    LEDprint(click_backspaceBtn());
  }
  else if ( 185*size <= mouseX && mouseX <= (185+107)*size  &&  107*size <= mouseY && mouseY <= (107+58)*size) // divide
  {
    input = "/";
    LEDprint(click_opbtn(input));
    input = "";
  }
  else if ( 270*size <= mouseX && mouseX <= (270+115)*size  &&  168*size <= mouseY && mouseY <= (168+58)*size) // multiply
  {
    input = "*";
    LEDprint(click_opbtn(input));
    input = "";
  }
  else if ( 270*size <= mouseX && mouseX <= (270+115)*size  &&  229*size <= mouseY && mouseY <= (229+58)*size) // minus 
  {
    input = "-";
    LEDprint(click_opbtn(input));
    input = "";
  }
  else if ( 270*size <= mouseX && mouseX <= (270+115)*size  &&  290*size <= mouseY && mouseY <= (290+58)*size) // add
  {
    input = "+";
    LEDprint(click_opbtn(input));
    input = "";
  }
  else if ( 282*size <= mouseX && mouseX <= (282+21)*size && 420*size <= mouseY && mouseY <= (420+21)*size) // choose size x1
  {
    size = 1;
    surface.setResizable(true);
    surface.setSize(400*size, 450*size);
    surface.setResizable(false);
  }
  else if ( 311*size <= mouseX && mouseX <= (311+21)*size && 420*size <= mouseY && mouseY <= (420+21)*size) // choose size x2
  {
    size = 2;
    surface.setResizable(true);
    surface.setSize(400*size, 450*size);
    surface.setResizable(false);
  }
}

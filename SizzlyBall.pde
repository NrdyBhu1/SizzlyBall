PFont font;
PImage button;
PImage buttonHovered;
PImage buttonToShowOne;
PImage buttonToShowTwo;

//Text
public String header = "Sizzly Ball";
public String byline = "Choose your difficulty";
public String buttonOneText = "2-minutes";
public String buttonTwoText = "5-minutes";
public float bylineX = 91;

//Mode
public int mode = 2;
public int menuMode = 0;
public int gameMode = 1;
public int endMode = 2;

//Buttons
public int twoMinButX = 136;
public int twoMinButY = 240;
public int twoMinButW = 240;
public int twoMinButH = 60;

public int fiveMinButX = 126;
public int fiveMinButY = 340;
public int fiveMinButW = 260;
public int fiveMinButH = 60;

//Time
public int timeMin = 0;
public int timeSec = 0;
public int timeMil = 0;

//Other
public int score = 0;
public int cWidth, cHeight = 0;

void setup(){
  size(500,550);
  font = loadFont("data/AgencyFB-Reg.vlw");
  textFont(font);
  button = loadImage("data/button.png");
  buttonHovered = loadImage("data/button-hover.png");
  buttonToShowOne = button;
  buttonToShowTwo = button;
  setRandomCWH();
}

void draw(){
  update();
  if (mode == gameMode){
    background(255, 190, 118);
    noFill();
    strokeWeight(10);
    stroke(32, 191, 107);
    ellipse(250,250,cWidth,cHeight);
    stroke(75, 101, 132,100);
    ellipse(250,250,mouseX,mouseY);
    text("Score:"+score,21,529);
    text("Time:"+timeMin+":"+timeSec,302,529);
  }else{
    noStroke();
    background(155, 89, 182);
    textSize(77);
    fill(26, 188, 156);
    text(header, 136, 85);
    textSize(50);
    fill(241, 196, 15);
    text(byline, bylineX, 156);
    textSize(45);
    fill(0);
    image(buttonToShowOne, twoMinButX, twoMinButY, twoMinButW, twoMinButH);
    image(buttonToShowTwo, fiveMinButX, fiveMinButY, fiveMinButW, fiveMinButH);
    text(buttonOneText, 182, 286);
    text(buttonTwoText, 182, 383);
  }
}

void update(){
  if(mode == menuMode){
    bylineX = 91;
    header = "Sizzly Ball";
    byline = "Choose your difficulty";
    buttonOneText = "2-minutes";
    buttonTwoText = "5-minutes";
  }else if (mode == endMode){
    bylineX = 173;
    header = "Time Up!";
    byline = "Score:"+score;
    buttonOneText = "Exit";
    buttonTwoText = "Try Again";
  }
  
  if(mode == gameMode){
    if(mouseX == cWidth && mouseY == cHeight){
        setRandomCWH();
        score++;
    }
    
    if(timeMin > 0 && timeSec == 0 && timeMil == 0){
      timeMin -= 1;
      timeSec += 60;
    }
    if(timeSec > 0 && timeMil == 0){
      timeSec -= 1;
      timeMil += 60;
    }
    if(timeMil != 0){
      timeMil--;
    }
    
    if(timeMin == 0 && timeSec == 0 && timeMil == 0){
       mode = endMode;
    }
    
  }
  
  if ( overRect(twoMinButX, twoMinButY, twoMinButW, twoMinButH) ) {
    buttonToShowOne = buttonHovered;
  } else {
    buttonToShowOne = button;
  }
  
  if ( overRect(fiveMinButX, fiveMinButY, fiveMinButW, fiveMinButH) ) {
    buttonToShowTwo = buttonHovered;
  } else {
    buttonToShowTwo = button;
  }
}

void mousePressed() {
  if(mode == menuMode){
    if ( overRect(twoMinButX, twoMinButY, twoMinButW, twoMinButH) ) {
      timeMin = 2;
      mode = gameMode;
    }
    
    if ( overRect(fiveMinButX, fiveMinButY, fiveMinButW, fiveMinButH) ) {
      timeMin = 5;
      mode = gameMode;
    }
  }else if (mode == endMode){
    if ( overRect(twoMinButX, twoMinButY, twoMinButW, twoMinButH) ) {
      exit();
    }
    
    if ( overRect(fiveMinButX, fiveMinButY, fiveMinButW, fiveMinButH) ) {
      score = 0;
      mode = menuMode;
    }
  }
}

void keyPressed(){
  if(key == 27){
      return;
  }
}

void setRandomCWH(){
  cWidth = (int)random(10,480);
  cHeight = (int)random(10,480);
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

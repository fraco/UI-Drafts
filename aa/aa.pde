/*
ui draft 09/14 by fraco
clock, hover-filling
*/
float arcMov;  
int dirMov = 1;
float theColor;


AnalogClock analogClock;

void setup() 
{
  size(displayWidth/3, displayHeight);
  analogClock = new AnalogClock(width/2, height/2);
  cursor(CROSS);
}

void draw() {
  background (27);
  smooth();
  float circleR = width/2.8;


  fill(255, 38);
  ellipse(width/2, height/1.2, circleR, circleR);  
  //hover
  if ((dist(width/2, height/1.2, mouseX, mouseY) < circleR/2)) {
    arcMov += radians(4)*dirMov;
  } else {
    arcMov = arcMov;
  }
  //arc movement  
  if (arcMov>radians(415) || arcMov<radians(-30)) {
    dirMov = dirMov*-1;
  }
  theColor = map(arcMov, 1, 5.75, 255, 0);
  fill(theColor, 255, theColor, 222);
  noStroke();
  arc(width/2, height/6, circleR, circleR, 0, arcMov);
  println(arcMov);
  
  analogClock.getTime();
  analogClock.display();
}

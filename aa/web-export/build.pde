
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
//excerpt from mathatelle, http://www.openprocessing.org/sketch/16038
//assignment sept 17 (third class): for "hour lines", second feedback
class AnalogClock extends Clock {
  float x, y;

  AnalogClock(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void getTime() {
    super.getTime();
  }

  void display() {
    float clockFrame = width/1.5;    
    noFill();
    stroke(255);    
    strokeWeight(.5);
    ellipse (x, y, clockFrame, clockFrame);
    //hour reference lines
    float radInner = width/3.6;
    float radOuter = width/3.2;
    
    //rayas referencia hora
    for(int ang = -90; ang < 360; ang+= 60){
      line(radInner * cos(radians(ang)) + x, radInner* sin(radians(ang)) + y, 
    radOuter * cos(radians(ang)) + x, radOuter* sin(radians(ang)) + y);
    }
    
    noStroke();
    strokeWeight(.75);
    
    //minutes    
    fill(255, 18);
    float arcMnt = map(m, 0,59, -90,270);
    arc(width/2, height/2, clockFrame-width/21, clockFrame-width/21, -HALF_PI, radians(arcMnt));
    
    //secs
    float movSec = map(s, 0,59, -90,270);
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(movSec));
    triangle((0-width/28), (-(width/4.5)-width/28), 0, -(width/3.6),  (0+width/28), 
    (-(width/4.5)-width/28));    
    popMatrix();
    
    //hour    
    fill(245, 0, 0);
    float radius = width/5;
    ellipse(radius * cos((h + m/60.0) % 12 * TWO_PI/12 - HALF_PI) + x, 
    radius * sin((h + m/60.0) % 12 * TWO_PI/12 - HALF_PI) + y, width/21, width/21);

////////////////////////////    
    //minutes
//    line(x, y, 
//    80 * cos((m + s/60.0) * TWO_PI/60 - HALF_PI) + x, 
//    80 * sin((m + s/60.0) * TWO_PI/60 - HALF_PI) + y);
//    println(s+", arcM="+arcMnt+", mnts="+m);
////////////////////////////

    //seconds
//    ellipse(90 * cos(s * TWO_PI/60 - HALF_PI) + x, 
//            90 * sin(s * TWO_PI/60 - HALF_PI) + y,
//            5,5);
//    strokeWeight(1);
//    line(x, y, 
//    90 * cos(s * TWO_PI/60 - HALF_PI) + x, 
//    90 * sin(s * TWO_PI/60 - HALF_PI) + y);
//    println(posHoraX+","+posHoraY);
  }
}

class Clock {
  int h, m, s;
  Clock() {
  }

  void getTime() {
    h = hour();
    m = minute();
    s = second();
    println("sec"+s+" min"+m+" h"+h);
  }
}                               



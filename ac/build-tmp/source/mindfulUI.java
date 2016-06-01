import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class mindfulUI extends PApplet {

Wireframe Wirefr;

PFont font;

public void setup() {
  size(displayWidth, displayHeight);
  //text
  font = createFont("Verdana", 24);
  textFont(font);
  //GUI class
  Wirefr = new Wireframe();  
}

public void draw() {
  background(0, 0, 0, 50);
  smooth();  
  Wirefr.timer();
  Wirefr.attention();
  Wirefr.actuator();
}
boolean stopped = false;
boolean continued = false;

public void keyPressed() { // pause
  if (key=='s') {
    stopped = true;
  }
  if (key=='r') { // reset
    stopped = false;
    continued = false;
    timerStart = millis();
  }
  if (key=='c') { // continue
    stopped = false;
    continued = true;
    timerStart = millis();

    offset = mill;
  }
}


float ang;
float easing = .05f;

//float arm;

int timerStart = 0;
int offset;
int mill;
int minutes;
int seconds;
int hundredths;

class Wireframe {
  
    ////////////////\u2014\u2014\u2014SKETCH\u2014\u2014\u2014////////////////
  ///\u2014WIREFRAME
  
  float testAng;
  
  public void attention() {
    ///\u2014Mindwave Signal (0-100) 
    //working with MOUSE-Y    
    stroke(21);
    strokeWeight(3);
    line(width/2, 0, width/2, height);
    noStroke();
    fill(255, 56);    
    arc(width/4, height/1.35f, height/1.45f, height/1.45f, radians(-180), radians(0));
    arc(width/1.33f, height/1.35f, height/1.45f, height/1.45f, radians(-180), radians(0));

    ///\u2014Interactive Overlay
    float testAtt = map(mouseY, height, 0, -180, 0);//interactive variable
    arc(width/4, height/1.35f, height/1.45f, height/1.45f, radians(-180), radians(testAtt));//"mindwaveSignal"
    ///\u2014Easing
    float testAttent = testAtt - testAng;
    if (abs(testAttent) > 1.5f) {
      testAng += testAttent*easing;
    }
  }
    public void actuator(){
    ///\u2014Representation model of physical actuator    
    stroke(255, 120);
    float theRadius = height/3.2f;
    float r = theRadius;
    float testCircVect = radians(testAng);
    line(width/1.33f, height/1.35f, (width/1.33f)+cos(radians(testAng))*r, (height/1.35f)+sin(radians(testAng))*r);
    //[SYNTAX]line(x1,y1, x1+cos(vble)*radio, y1+sin(vble)*radio); 
    //    ellipse(width/1.33+cos(radians(testAng))*r, height/1.35+sin(radians(testAng))*r, height/12,height/12);
    //triangle
    noStroke();
    float movTri = map(testAng, -180, 0, -90, 90);
    pushMatrix();
    translate(width/1.33f, height/1.35f);    
    rotate(radians(movTri));
    triangle((0-width/32), (-(width/7.8f)-width/12), 
    0, -(width/5.2f), 
    0+width/21, (-(width/7.8f)-width/12));  
    popMatrix();
  }
  
    public void timer() {
    if (!stopped) {
      mill=(millis()-timerStart);
      if (continued) mill += offset;
      seconds = mill / 1000;
      minutes = seconds / 60;
      seconds = seconds % 60;
      hundredths = mill / 10 % 100;
    }    
    noStroke();
    fill(255, 56);
    textAlign(CENTER);
    text(nf(seconds, 2, 0), width/2, height/6);
    text("R(Restart)\u2014S(Stop)\u2014C(Continue)", width/2, height/10);
    float circMov = radians(map(seconds, 12, 0, -90, 270));
    //    float circMovEased = map(circMov,-90,270, 0,1080);
    if (seconds>=12) {
      stopped = true;
      timerStart = millis();
    }
    //    println(circMov);
    arc(width/2, height/3.5f, height/5, height/5, radians(-90), circMov);
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "mindfulUI" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

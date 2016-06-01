float ang;
float easing = .05;

//float arm;

int timerStart = 0;
int offset;
int mill;
int minutes;
int seconds;
int hundredths;

class Wireframe {
  
    ////////////////———SKETCH———////////////////
  ///—WIREFRAME
  
  float testAng;
  
  void attention() {
    ///—Mindwave Signal (0-100) 
    //working with MOUSE-Y    
    stroke(21);
    strokeWeight(3);
    line(width/2, 0, width/2, height);
    noStroke();
    fill(255, 56);    
    arc(width/4, height/1.35, height/1.45, height/1.45, radians(-180), radians(0));
    arc(width/1.33, height/1.35, height/1.45, height/1.45, radians(-180), radians(0));

    ///—Interactive Overlay
    float testAtt = map(mouseY, height, 0, -180, 0);//interactive variable
    arc(width/4, height/1.35, height/1.45, height/1.45, radians(-180), radians(testAtt));//"mindwaveSignal"
    ///—Easing
    float testAttent = testAtt - testAng;
    if (abs(testAttent) > 1.5) {
      testAng += testAttent*easing;
    }
  }
    void actuator(){
    ///—Representation model of physical actuator    
    stroke(255, 120);
    float theRadius = height/3.2;
    float r = theRadius;
    float testCircVect = radians(testAng);
    line(width/1.33, height/1.35, (width/1.33)+cos(radians(testAng))*r, (height/1.35)+sin(radians(testAng))*r);
    //[SYNTAX]line(x1,y1, x1+cos(vble)*radio, y1+sin(vble)*radio); 
    //    ellipse(width/1.33+cos(radians(testAng))*r, height/1.35+sin(radians(testAng))*r, height/12,height/12);
    //triangle
    noStroke();
    float movTri = map(testAng, -180, 0, -90, 90);
    pushMatrix();
    translate(width/1.33, height/1.35);    
    rotate(radians(movTri));
    triangle((0-width/32), (-(width/7.8)-width/12), 
    0, -(width/5.2), 
    0+width/21, (-(width/7.8)-width/12));  
    popMatrix();
  }
  
    void timer() {
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
    text("R(Restart)—S(Stop)—C(Continue)", width/2, height/10);
    float circMov = radians(map(seconds, 12, 0, -90, 270));
    //    float circMovEased = map(circMov,-90,270, 0,1080);
    if (seconds>=12) {
      stopped = true;
      timerStart = millis();
    }
    //    println(circMov);
    arc(width/2, height/3.5, height/5, height/5, radians(-90), circMov);
  }
  
}

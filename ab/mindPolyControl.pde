/*
ui draft 09/14 by Fraco
eeg neurosky – concentration signal mapped to sides of polygon 
use of Neurosky's Mindwave, library info below
*/

/* 
 Info on this library
 http://crea.tion.to/processing/thinkgear-java-socket 
 Info on ThinkGear 
 http://developer.neurosky.com/ 
 Info on Cardoso's API
 http://jorgecardoso.eu/processing/MindSetProcessing/
 */

import neurosky.*;
import org.json.*;

ThinkGearSocket neuroSocket;

int attention = 3;
int meditation= 3;
int blink     = 3;
PFont font;

int numSides = 3;

color[] colP1 = {#D7E612,#F0FF1F,#D2FFC0,#6AFF2D};
color[] colP2 = {#27C2FF,#6F91E8,#4BB7FF,#0087FF};

void setup() {
  size(screenWidth/2, screenHeight);

  ThinkGearSocket neuroSocket = new ThinkGearSocket(this);
  try {
    neuroSocket.start();
  } 
  catch (ConnectException e) {
    //println("Is ThinkGear running??");
  }

  //noFill();
  font = createFont("Verdana", 10);
  textFont(font);
}

void draw() {
  //background(0,0,0,50);
  smooth();
  fill(0, 111);
  noStroke();
  rect(0, 0, width, height);
  ////////////////////////////////////  

  // polygon algorithm mapped to attention level, color selection mapped to blink
  numSides = int(map(attention, 0, 100, 3, 12));
  float[] xPos = new float[numSides];
  float[] yPos = new float[numSides];

  //divide the circle in num of sides
  float angle = 2*PI / numSides;

  //create a circle, through consecutive points
  for (int i = 0; i < numSides; i++) {
    //nCoord[]=coord + circleSize * trigF( 
    xPos[i] = (width/2) + (height/2.75) * sin(angle*i);
    yPos[i] = (height/2) + (height/2.75) * cos(angle*i);
  }
  
  int c = 0;
  if(blink>80){
    c++;
  } else if(c>3){
   c = 0; 
  }

  //draw the interactive polygon Attention 
  fill(colP1[c],150);
  beginShape(POLYGON);
  for (int i = 0; i < numSides; i++)
    vertex(xPos[i], yPos[i]);
  endShape(CLOSE);
  
  text("Attention: "+attention, 30,30);
  
  fill(#00DBFF);
  text("Meditation: "+meditation, 30,50);
  
  fill(222);
  text("Blink: "+blink, 30, 70);
}

void poorSignalEvent(int sig) {
  println("SignalEvent "+sig);
}

public void attentionEvent(int attentionLevel) {
  println("Attention Level: " + attentionLevel);
  attention = attentionLevel;
}

void meditationEvent(int meditationLevel) {
  println("Meditation Level: " + meditationLevel);
  meditation = meditationLevel;
}

void blinkEvent(int blinkStrength) {
  println("blinkStrength: " + blinkStrength);
  blink = blinkStrength;
}

public void eegEvent( int low_alpha, int high_alpha, 
int low_beta, int high_beta, 
int low_gamma, int mid_gamma, 
int delta, int theta) {
}

void rawEvent(int[] raw) {
  //println("rawEvent Level: " + raw);
}	

void stop() {
  neuroSocket.stop();
  super.stop();
}

/*
ui draft 10/14 by fraco
eeg neurosky – first interactive wireframe of "Mind the Needle"
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
Wireframe Wirefr;

PFont font;

void setup() {
  size(displayWidth, displayHeight);
  //text
  font = createFont("Verdana", 24);
  textFont(font);
  //GUI class
  Wirefr = new Wireframe();  
}

void draw() {
  background(0, 0, 0, 50);
  smooth();  
  Wirefr.timer();
  Wirefr.attention();
  Wirefr.actuator();
}

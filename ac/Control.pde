boolean stopped = false;
boolean continued = false;

void keyPressed() { // pause
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



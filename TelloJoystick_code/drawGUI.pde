void initializeTelloData() {  
  telloData.put("roll", 0.0);
  telloData.put("pitch", 0.0);
  telloData.put("yaw", 0.0);

  telloData.put("h", 0.0);
  telloData.put("bat", 0.0);
  telloData.put("time", 0.0);
  telloData.put("temph", 0.0);
}

void initializeFont() {
  if (osType() == "linux") {
    font8 = createFont("Ubuntu", 8, false);
    font9 = createFont("Ubuntu", 9, false);
    font12 = createFont("Ubuntu", 12, false);
    font15 = createFont("Ubuntu", 15, false);
    font30 = createFont("Ubuntu", 30, false);
    font50 = createFont("Ubuntu", 50, false);
  } else if (osType() == "win") {
    font8 = createFont("Arial bold", 8, false);
    font9 = createFont("Arial bold", 9, false);
    font12 = createFont("Arial bold", 12, false);
    font15 = createFont("Arial bold", 15, false);
    font30 = createFont("Arial bold", 30, false);
    font50 = createFont("Arial bold", 50, false);
  }
}

void drawGUI() {
  drawBattery(int(telloData.get("bat")));
  drawTemperature(int((telloData.get("temph")-32)*5/9));
  drawIMU(int(telloData.get("roll")), int(telloData.get("pitch")), int(telloData.get("yaw")));
  drawFlightTime(int(telloData.get("time")));
  drawAltitude(int(telloData.get("h"))/10);
}

void drawBattery(int batt) {
  fill(23, 116, 186);
  textAlign(CENTER);
  textFont(font30);
  text(batt, 660, 140);
  rectMode(CORNERS);
  for (int i = 0; i < batt; i+=20) {
    int batteryHeight = 146;
    int batteryUnit = 0;
    if ((batt - i) > 20) {
      batteryUnit = 5;
    } else {
      batteryUnit = (batt - i)/5;
    }    
    batteryHeight -= (i/20)*7;
    rect(605, batteryHeight, 605+16, batteryHeight-batteryUnit);
  }
}

void drawTemperature(int temp) {
  text(temp, 761, 140);
  rectMode(CORNER);
  int map_temp = int(map(temp, -10, 50, 0, -30));
  rect(704, 140, 4, map_temp);
}

void drawIMU(int roll, int pitch, int yaw) {  
  textAlign(CENTER);
  fill(23, 116, 186);
  textFont(font30);
  text(int(roll), 623, 445);
  text(int(pitch), 692, 445);
  text(int(yaw), 764, 445);
}

void drawFlightTime(int time) {  
  fill(23, 116, 186);
  textFont(font15);
  textAlign(CENTER);
  text(int(time/60)+":"+time%60, 698, 206);
}

void drawAltitude(int altitude) {  
  fill(23, 116, 186);
  textFont(font50);
  textAlign(CENTER);
  text(altitude, 698, 530);
}

void drawCompass(int compass_data){
  pushMatrix();  
  translate(777, 244);
  imageMode(CENTER);
  rotate(radians(compass_data));
  image(compass, 0, 0); 
  popMatrix();
}

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
  
  float j;
  float horizonInstrSize;
  float angyLevelControl;

  float angy =-1*float(pitch);
  float a =-radians(float(roll));

  // Visualize IMU
  horizonInstrSize=68;
  angyLevelControl=((angy<-horizonInstrSize) ? -horizonInstrSize : (angy>horizonInstrSize) ? horizonInstrSize : angy);
  pushMatrix();
  translate(694, 308);
  noStroke();
  // instrument background
  fill(50, 50, 50);
  ellipse(0, 0, 150, 150);
  // full instrument
  rotate(-a);
  rectMode(CORNER);
  // outer border
  strokeWeight(1);
  stroke(90, 90, 90);
  //border ext
  arc(0, 0, 140, 140, 0, TWO_PI);
  stroke(190, 190, 190);
  //border int
  arc(0, 0, 138, 138, 0, TWO_PI);
  // inner quadrant
  strokeWeight(1);
  stroke(255, 255, 255);
  fill(124, 73, 31);
  //earth
  float angle = acos(angyLevelControl/horizonInstrSize);
  arc(0, 0, 136, 136, 0, TWO_PI);
  fill(38, 139, 224); 
  //sky 

  arc(0, 0, 136, 136, HALF_PI-angle+PI, HALF_PI+angle+PI);
  float x = sin(angle)*horizonInstrSize;
  if (angy>0) 
    fill(124, 73, 31);
  noStroke();   
  triangle(0, 0, x, -angyLevelControl, -x, -angyLevelControl);
  // inner lines
  strokeWeight(1);
  for (int i=0; i<8; i++) {
    j=i*15;
    if (angy<=(35-j) && angy>=(-65-j)) {
      stroke(255, 255, 255); 
      line(-30, -15-j-angy, 30, -15-j-angy); // up line
      fill(255, 255, 255);
      textFont(font9);
      text("+" + (i+1) + "0", 34, -12-j-angy); //  up value
      text("+" + (i+1) + "0", -48, -12-j-angy); //  up value
    }
    if (angy<=(42-j) && angy>=(-58-j)) {
      stroke(167, 167, 167); 
      line(-20, -7-j-angy, 20, -7-j-angy); // up semi-line
    }
    if (angy<=(65+j) && angy>=(-35+j)) {
      stroke(255, 255, 255); 
      line(-30, 15+j-angy, 30, 15+j-angy); // down line
      fill(255, 255, 255);
      textFont(font9);
      text("-" + (i+1) + "0", 34, 17+j-angy); //  down value
      text("-" + (i+1) + "0", -48, 17+j-angy); //  down value
    }
    if (angy<=(58+j) && angy>=(-42+j)) {
      stroke(127, 127, 127); 
      line(-20, 7+j-angy, 20, 7+j-angy); // down semi-line
    }
  }
  strokeWeight(2);
  stroke(255, 255, 255);
  if (angy<=50 && angy>=-50) {
    line(-40, -angy, 40, -angy); //center line
    fill(255, 255, 255);
    textFont(font9);
    text("0", 34, 4-angy); // center
    text("0", -39, 4-angy); // center
  }

  // lateral arrows
  strokeWeight(1);
  // down fixed triangle
  stroke(60, 60, 60);
  fill(180, 180, 180, 255);

  triangle(-horizonInstrSize, -8, -horizonInstrSize, 8, -55, 0);
  triangle(horizonInstrSize, -8, horizonInstrSize, 8, 55, 0);

  // center
  strokeWeight(1);
  stroke(255, 0, 0);
  line(-20, 0, -5, 0); 
  line(-5, 0, -5, 5);
  line(5, 0, 20, 0); 
  line(5, 0, 5, 5);
  line(0, -5, 0, 5);
  popMatrix();
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

void drawCompass(int compass_data) {
  pushMatrix();  
  translate(777, 244);
  imageMode(CENTER);
  rotate(radians(compass_data));
  image(compass, 0, 0); 
  popMatrix();
}

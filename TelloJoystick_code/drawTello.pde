void drawTello(int roll, int pitch, int yaw)
{  
  pushMatrix(); // Start Stack #1
  smooth();
  lights();
  noStroke();

  translate(288,384); // Centering to the GUI
  scale(0.04);

  rotateX(0.9200007);
  rotateY(-0.019999873); 
  
  // Draw Tello Base body
  translate(0, 0, 0);
  fill(BLACK);
  rotateX(radians(pitch));
  rotateY(radians(-roll));
  rotateZ(radians(yaw));
  shape(base);

  // Draw Tello Top body
  pushMatrix(); // Start Stack #2
  fill(WHITE);
  translate(0, 0, 90);
  scale(25);
  shape(top);

  // Draw Tello Motor
  drawMotor(43, 43, 3, true);
  drawMotor(-2159, 5, 3, false);
  drawMotor(-8, -2160, 3, false);
  drawMotor(2170, -15, 3, false);
  
  // Draw Tello Propeller
  drawPropeller(0, 2175, 230, 0);
  drawPropeller(15, 0, 240, 0);
  drawPropeller(-2175, 0, 240, 0);
  drawPropeller(-2175, 2175, 240, 0);  
  popMatrix(); // End Stack #2

  popMatrix(); // End Stack #1
}

void drawMotor(int x, int y, int z, boolean scale){
  fill(WHITE, 245);
  translate(x, y, z);
  if(scale){
    scale(0.04);
  }  
  shape(motor);  
}

void drawPropeller(int x, int y, int z, float angle){
  pushMatrix();
  fill(BLACK);
  translate(x, y, z);
  scale(4);
  rotateX(89.5);
  rotateZ(89.6);
  rotateX(angle);
  shape(propeller);
  popMatrix();
}

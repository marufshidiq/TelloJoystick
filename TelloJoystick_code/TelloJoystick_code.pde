import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;
import hypermedia.net.*;
import gohai.glvideo.*;

UDP udp;
ControlIO control;
ControlDevice stick;
ControlHat hat;
GLVideo video;

PImage bg, compass;
PShape base, top, motor, propeller;
PFont font8, font9, font12, font15, font30, font50;

color WHITE = color(255, 255, 255), BLACK = color(0, 0, 0), RED = color(255, 0, 0);

HashMap<String, Float> telloData = new HashMap<String, Float>(17);

int pX, pY, pZ;
int yaw;

// Mode
int KEYBOARD = 0;
int JOYSTICK = 1;
int mode; // 0 = Keyboard | 1 = Joystick

// View Mode
int VIEW_3D = 0;
int VIEW_CAMERA = 1;
int view_mode; // 0 = 3D | 1 = Camera

int last_pX, last_pY, last_pZ;
int last_yaw;
int last_video_data = 0;

void setup(){
  size(800, 600, P3D);
  control = ControlIO.getInstance(this);
  stick = control.filter(GCP.STICK).getMatchedDevice("tello-v1");
  if (stick == null) {
    println("########## Keyboard Mode ##########");
    mode = KEYBOARD;
  }
  else {
    println("########## Joystick Mode ##########");
    mode = JOYSTICK;
    hat = stick.getHat("HAT");
    stick.getButton("BASE2").plug(this, "takeOff", ControlIO.ON_PRESS);
    stick.getButton("BASE").plug(this, "landing", ControlIO.ON_PRESS);
  }
    
  bg = loadImage("bg.png");
  compass = loadImage("compass.png");
  
  base = loadShape("cad/base.obj");
  top = loadShape("cad/top.obj");
  motor = loadShape("cad/motor.obj");
  propeller = loadShape("cad/propeller.obj");

  base.disableStyle();
  top.disableStyle();
  motor.disableStyle();
  propeller.disableStyle();

  udp = new UDP(this, 8890);
  udp.listen(true);
  //udp.log(true);
  udp.setReceiveHandler("receiveFromTello");
  video = new GLVideo(this, "udpsrc port=11111 ! decodebin", GLVideo.NO_SYNC);
  video.play();
  frameRate(20);

  sendCommand("command"); // Initialize Tello's SDK mode [Remark 2]
  initializeTelloData();
  initializeFont();
}

void draw(){
  background(bg);
  if(view_mode == VIEW_3D){
    drawTello(int(telloData.get("roll")), int(telloData.get("pitch")), int(telloData.get("yaw")));
  }
  else if(view_mode == VIEW_CAMERA){
    drawCamera();
  }
  drawGUI();  
  drawLink();
 
  if(mode == JOYSTICK){
    pX = int(map(stick.getSlider("X").getValue(), -1, 1, -100, 100));     // Position X
    pY = int(map(stick.getSlider("Y").getValue(), -1, 1, 100, -100));     // Position Y
    pZ = int(map(hat.getY(), -1, 1, 100, -100));                          // Position Z
    yaw = int(map(stick.getSlider("RZ").getValue(), -1, 1, -100, 100));   // Yaw

    sendRC(pX, pY, pZ, yaw);
  }
}

void sendRC(int _x, int _y, int _z, int _yaw){
  boolean _update = false;
  if(_x != last_pX){
    last_pX = _x;
    _update = true;
  }

  if(_y != last_pY){
    last_pY = _y;
    _update = true;
  }

  if(_z != last_pZ){
    last_pZ = _z;
    _update = true;
  }

  if(_yaw != last_yaw){
    last_yaw = _yaw;
    _update = true;
  }

  if(_update){
    sendCommand("rc " + _x + " " + _y + " " + _z + " " + _yaw);
  }
}

void takeOff(){
  println("Take Off");
  sendCommand("takeoff");
}

void landing(){
  println("Landing");
  sendCommand("land");
}

void sendCommand(String input){
  println(input);
  byte[] byteBuffer = input.getBytes();
  udp.send(byteBuffer, "192.168.10.1", 8889);
}

void receiveFromTello( byte[] data ) {
  String received = "";
  for (int i=0; i < data.length; i++) {
    received+=char(data[i]);
  }
  //println(received);
  String[] allData = split(received, ';');
  for (int i = 0; i < allData.length - 1; i++) {
    String[] singleData = split(allData[i], ':');
    telloData.put(singleData[0], float(singleData[1]));
  }
}

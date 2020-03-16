import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;
import hypermedia.net.*;

UDP udp;
ControlIO control;
ControlDevice stick;
ControlHat hat;

int pX, pY, pZ;
int yaw;

// Mode
int KEYBOARD = 0;
int JOYSTICK = 1;
int mode; // 0 = Keyboard | 1 = Joystick

int last_pX, last_pY, last_pZ;
int last_yaw;

void setup(){
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

  udp = new UDP(this, 8890);
  udp.listen(true);
  udp.setReceiveHandler("receiveFromTello");

  sendCommand("command"); // Initialize Tello's SDK mode [Remark 2]
}

void draw(){
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
}

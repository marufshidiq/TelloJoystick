void keyPressed(){
  char formatedKey = Character.toLowerCase(key);
  // Takeoff and Landing
  if     (formatedKey == 'x'){ takeOff(); }
  else if(formatedKey == 'z'){ landing(); }
  else if(formatedKey == 'v'){ sendCommand("streamon"); }
  else if(formatedKey == 'b'){ sendCommand("streamoff"); }
  
  else if(formatedKey == '1'){ view_mode = VIEW_3D; }
  else if(formatedKey == '2'){ view_mode = VIEW_CAMERA; }

  else if(formatedKey == 'w'){ sendCommand("forward 30"); }
  else if(formatedKey == 'a'){ sendCommand("left 30"); }
  else if(formatedKey == 's'){ sendCommand("back 30"); }
  else if(formatedKey == 'd'){ sendCommand("right 30"); }

  else if(formatedKey == 'u'){ sendCommand("up 30"); }
  else if(formatedKey == 'h'){ sendCommand("ccw 30"); }
  else if(formatedKey == 'j'){ sendCommand("down 30"); }
  else if(formatedKey == 'k'){ sendCommand("cw 30"); }
}

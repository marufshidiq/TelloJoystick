String osType() {
  String os = System.getProperty("os.name");
  if (os.contains("Windows")) {
    // os-specific setup and config here
    return "win";
  } else if (os.contains("Mac")) {
    // ...
    return "mac";
  } else if (os.contains("Linux")) {
    // ...
    return "linux";
  } else {
    // ...
    return "other";
  }
}

void drawLink(){
  if(hoverLink() == 1){
    rectMode(CORNERS);
    strokeWeight(4);
    stroke(BLACK);
    noFill();
    rect(25, 563, 255, 598);
  }
  else if(hoverLink() == 2){
    rectMode(CORNERS);
    strokeWeight(4);
    stroke(BLACK);
    noFill();
    rect(540, 563, 770, 598);
  }
}

int hoverLink(){
  if(mouseX > 25 && mouseX < 255 && mouseY > 560){
    return 1;
  }
  
  if(mouseX > 540 && mouseX < 770 && mouseY > 560){
    return 2;
  }
  return 0;
}

void mousePressed(){
  switch(hoverLink()){
    case 1:
      link("https://otomasi.sv.ugm.ac.id");
      break;
    case 2:
      link("https://fahmizal.staff.ugm.ac.id");
      break;
  }
}

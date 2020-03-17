void drawCamera(){
  boolean available = false;
  if (video.available()) {
    video.read();
    available = true;
    last_video_data = millis();
  }  
  image(video, 25, 170, 525, 375);
  if(!available && (millis() - last_video_data) > 100){
    rectMode(CENTER);
    noStroke();
    fill(0, 50);
    rect(25+(525/2), 170+(375/2), 525, 100);
    textAlign(CENTER, BOTTOM);
    fill(RED);
    textFont(font30);
    text("No Video Available", 25+(525/2), 170+(375/2)+10);
    textAlign(CENTER, TOP);    
    textFont(font15);
    text("Press V to Activate Stream and B to Deactivate", 25+(525/2), 170+(375/2)+10);
  }
}

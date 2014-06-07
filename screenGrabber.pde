import com.onformative.screencapturer.*;

class ScreenGrabber extends Routine {

  ScreenCapturer capturer;
  
  void setup(PApplet parent) {
    
    capturer = new ScreenCapturer(width, height,0,20,30);
  }
  
  void draw() {
    pushMatrix();
//    scale(.23,.23);
    image(capturer.getImage(), 0, 0);
    popMatrix();
  }
}


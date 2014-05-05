import com.onformative.screencapturer.*;

class ScreenGrabber extends Routine {

  ScreenCapturer capturer;
  
  void setup(PApplet parent) {
    
    capturer = new ScreenCapturer(width, height, 100,200,30);
  }
  
  void draw() {
    pushMatrix();
//    scale(.23,.23);
    image(capturer.getImage(), 0, 0);
    popMatrix();
  }
}


import com.onformative.screencapturer.*;

class ScreenGrabber extends Routine {

  ScreenCapturer capturer;
  
  void setup(PApplet parent, int width_, int height_) {
    
    capturer = new ScreenCapturer(width_, height_, 1200, 200,255);
  }
  
  void draw() {
    image(capturer.getImage(), 0, 0);
  }
}


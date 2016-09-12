//import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

String transmit_address = "ft.noise";
int transmit_port       = 1337;

// Output size
int displayWidth =  45;
int displayHeight = 35;

// Capture size
int captureWidth = displayWidth*1;
int captureHeight = displayHeight*1;

ScreenGrabber grabber = new ScreenGrabber();
FlaschenTaschen sign;

void setup() {
  size(displayWidth, displayHeight);
  frameRate(60);

  sign = new FlaschenTaschen(this, displayWidth, displayHeight, transmit_address, transmit_port);
  sign.setEnableGammaCorrection(false);

  grabber.setup(this,captureWidth,captureHeight);
}

void draw() {
  pushMatrix();
    scale(float(displayWidth)/captureWidth, float(displayHeight)/captureHeight);
    grabber.draw();
  popMatrix();
    
  sign.sendData();
}
import processing.opengl.*;
import java.lang.reflect.Method;
import hypermedia.net.*;
import java.io.*;

// This should be 127.0.0.1, 58802
String transmit_address = "ledscape.local";
int transmit_port       = 9999;

// Display configuration
int displayWidth =  16*32;
int displayHeight = 32*2;

ScreenGrabber grabber = new ScreenGrabber();
LEDDisplay sign;

void setup() {
  size(displayWidth, displayHeight);

  sign = new LEDDisplay(this, displayWidth, displayHeight, 2, true, transmit_address, transmit_port);
  sign.setAddressingMode(LEDDisplay.ADDRESSING_HORIZONTAL_NORMAL);  
  sign.setEnableGammaCorrection(false);

  grabber.setup(this);
}

void draw() {
  grabber.draw();
  sign.sendData();
}


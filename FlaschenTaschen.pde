import hypermedia.net.*;

/**
 * This class can be added to your sketches to make them compatible with an LED display.
 * Use Sketch..Add File and choose this file to copy it into your sketch.
 *
 * void setup() {
 *   // Constructor takes this, width, height.
 *   FlaschenTaschen display = new FlaschenTaschen(this, 45, 35);
 * }
 *
 * void draw() {
 *   doStuff();
 *
 *   // Call this in your draw loop to send data to the sign.
 *   display.sendData();
 * }
 *
 **/

public class FlaschenTaschen {
  PApplet parent;
  UDP udp;
  String address;
  int port;
  int w;
  int h;
  byte pixelBuffer[];
  float gammaValue = 2.5;
  boolean enableGammaCorrection = false;

  public FlaschenTaschen(PApplet parent, int w, int h, String address, int port) {
    this.parent = parent;
    this.udp = new UDP(parent);
    this.address = address;
    this.port = port;
    this.w = w;
    this.h = h;
    int bufferSize = 3*w*h;
    
    pixelBuffer = new byte[bufferSize];
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public void setPort(int port) {
    this.port = port;
  }

  public void setGammaValue(float gammaValue) {
    this.gammaValue = gammaValue;
  }

  public void setEnableGammaCorrection(boolean enableGammaCorrection) {
    this.enableGammaCorrection = enableGammaCorrection;
  }

  private int getAddress(int x, int y) {
    return (y * w + x);
  }

  public void sendData() {
    PImage image = get();

    //    if (image.width != w || image.height != h) {
    //      image.resize(w,h);
    //    }

    image.loadPixels();
    loadPixels();

    int r;
    int g;
    int b;
    int pixelsPerPacket = (w*h);
    
    for (int offset = 0; offset<pixelsPerPacket; offset++) {

      r = int(red(image.pixels[offset]));
      g = int(green(image.pixels[offset]));
      b = int(blue(image.pixels[offset]));
        
      if (enableGammaCorrection) {
        r = (int)(Math.pow(r/256.0,this.gammaValue)*256);
        g = (int)(Math.pow(g/256.0,this.gammaValue)*256);
        b = (int)(Math.pow(b/256.0,this.gammaValue)*256);
      }

      pixelBuffer[(offset*3)+0] = byte(r);
      pixelBuffer[(offset*3)+1] = byte(g);
      pixelBuffer[(offset*3)+2] = byte(b);
    }

    String header =
        "P6\n"    // Magic number 
      + w +" "+ h + "\n" // width height (decimal, number in ASCII)
      + "255\n"   // values per color (fixed)
      ;
      
    String footer = 
      "\n0 "     // optional x offset
      + "0 "     // optional y offset
      + "12\n"     // optional z offset
      ;

    try {
      ByteArrayOutputStream outputStream = new ByteArrayOutputStream( );
      outputStream.write( header.getBytes() );
      outputStream.write( pixelBuffer );
      outputStream.write( footer.getBytes() );
    
      udp.send(outputStream.toByteArray( ), address, port);
    }
    catch (IOException e) {
    }

    updatePixels();
  }
}


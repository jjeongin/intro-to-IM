import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.serial.*;

Kinect kinect;
Serial myPort;
float sensorValue = 0;
PImage img;

// GLOBAL VARIABLES
int step = 5; // how often dots are displayed
float angle = 0; // angle for rotation
float scale = 1500; // scale for graphic
float[] depthLookUp = new float[2048]; // contains depth value
int[] depth;
PImage rgb_img;

void setup() {
  fullScreen(P3D); // for final output, use full screen
  //size(1280, 960, P3D); // kinect camera size: 640 x 480
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
  
  String portname = Serial.list()[3]; // adjust port to arduino's serial port
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  // Look up table for all possible depth values (0 - 2047)
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
  
  
  frameRate(2);
}

void draw() {
  background(0);
  
  depth = kinect.getRawDepth(); // get raw depth from kinect
  rgb_img = kinect.getVideoImage();
  
  // image rotation code from Point Cloud example by Daniel Shiffman (https://github.com/shiffman/OpenKinect-for-Processing/blob/master/OpenKinect-Processing/examples/Kinect_v1/PointCloud/PointCloud.pde)
  translate(width/2, 0, -50);
  rotateY(angle);
  
  image_to_3d(rgb_img); // convert kinect image to 3d graphic
  
  angle += 0.125f; // increase angle
}

void image_to_3d(PImage img) {
  noFill();
  beginShape(POINTS);
  for (int x = 0; x < kinect.width; x += step) {
    for (int y = 0; y < kinect.height; y += step) {
      int loc = x + y * kinect.width;
      color c = img.pixels[loc];
      stroke(c);
      strokeWeight(4);
      
      int d = depth[loc];
      PVector v = depthToWorld(x, y, d);
      scatter_points();
      vertex(width - (v.x*scale + width/2), v.y*scale + height/2, scale - v.z*scale);
      //vertex(x*width/kinect.width, y*height/kinect.height, scale-v.z*scale); // other version
    }
  }
  endShape();
}

void scatter_points() {
  scale = sensorValue;
  println(scale);
}

void serialEvent(Serial myPort) {
  String s = myPort.readStringUntil('\n'); // get the string from port
  if (s != null) { // if string is not empty
    s = trim(s); // trim off the whitespace
    sensorValue = float(s); // convert it to float
    sensorValue = map(sensorValue, 400, 1000, -100, 100);
    sensorValue = sensorValue * 2.2;
    sensorValue = map(sensorValue, -100, 100, 0, 1500);
  }
}

// Kinect Depth -> Real World Depth computation 
// original functions from: http://graphics.stanford.edu/~mdfisher/Kinect.html
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {
  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}

//import processing.video.*;
import processing.serial.*;

PImage img;
PImage img2;
//Capture cam;

Serial myPort;
float sensorValue = 0;

// GLOBAL VARIABLES
int step = 8; // how often dots are displayed
float a = 0.0;

void setup() {
  //fullScreen(); // for final output, use full screen
  background(0);
  size(1280, 720, P3D); // Mac FaceTime camera size: 1280 x 720

  String portname = Serial.list()[3]; // adjust port to arduino's serial port
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
  
  img = loadImage("ss1.png");
  img.resize(width, height); // resize the image file to window size
  img2 = loadImage("ss3.png");
  img2.resize(width, height); // resize the image file to window size
  filter(GRAY);
  
  frameRate(4); // refresh 4 times a second

  //// video capture code from Processing Reference (https://processing.org/reference/libraries/video/Capture.html)
  //String[] cameras = Capture.list();

  //if (cameras.length == 0) {
  //  println("There are no cameras available for capture.");
  //  exit();
  //} else {
  //  println("Available cameras:");
  //  for (int i = 0; i < cameras.length; i++) {
  //    println(cameras[i]);
  //  }
  //  cam = new Capture(this, 1280, 720, cameras[0]); // initialize capture
  //  cam.start();
  //}

}

void serialEvent(Serial myPort) {
  String s = myPort.readStringUntil('\n'); // get the string from port
  if (s != null) { // if string is not empty
    s = trim(s); // trim off the whitespace
    sensorValue = float(s); // convert it to float
    sensorValue = map(sensorValue, 200, 700, 1, 500);
    println(sensorValue);
  }
}

void image_to_3d(PImage img) {
  //canvas3D.beginDraw(); // for PGraphic
  //canvas3D.background(0);
  noFill();
  beginShape(POINTS);
  for (int x = 0; x < width; x += step) {
    for (int y = 0; y < height; y += step) {
      int loc = x + y*width;
      color c = img.pixels[loc];
      stroke(c);
      vertex(x, y, random(0, sensorValue));
    }
  }
  endShape();
  //canvas3D.endDraw();
  //image(canvas3D, 0, 0);
}

void draw() {
  background(0);
  // when using raw video image
  //scale(-1, 1); // flip the image
  //image(cam, -width, 0);
  //filter(GRAY);
  //filter(THRESHOLD, sensorValue);
  //filter(POSTERIZE, 6);
  
  // rotate the shape
  translate(width/2, height/2);
  rotateX(mouseY * 0.01); // rotate the img
  rotateY(mouseX * 0.01);
  //rotateY(a * 1.1);
  //shapeMode(CENTER);
  image_to_3d(img);
  
}

// for testing purpose
void mousePressed() {
  
  //image_to_3d(img);
  //img = loadImage("ss2.png");
  //img.resize(width, height); // resize the image file to window size
  ////image(img, 0, 0);
  //filter(POSTERIZE, 2);
  //image_to_3d(img);
  
  //if(cam.available()) {
  //  cam.read();
  //  PImage img = cam;
  //  image_to_3d(img);
  //}
  
}

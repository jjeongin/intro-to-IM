import processing.video.*;
import processing.serial.*;


PImage img;
Capture cam;

Serial myPort;
float sensorValue = 0;

// GLOBAL VARIABLES
int step = 10; // how often dots are displayed

void setup() {
  //fullScreen();
  background(0);
  size(1280, 720); // Mac FaceTime camera size: 1280 x 720

  String portname = Serial.list()[3]; // adjust port to arduino's serial port
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
  
  
  frameRate(4); // refresh 4 times a second

  // video capture code from Processing Reference (https://processing.org/reference/libraries/video/Capture.html)
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, 1280, 720, cameras[0]); // initialize capture
    cam.start();
  }

}

void serialEvent(Serial myPort) {
  String s = myPort.readStringUntil('\n'); // get the string from port
  if (s != null) { // if string is not empty
    s = trim(s); // trim off the whitespace
    sensorValue = float(s); // convert it to float
    sensorValue = map(sensorValue, 200, 700, 0, 255);
    println(sensorValue);
  }
}

void image_to_3d(PImage img) {
  noFill();
  beginShape(POINTS);
  for (int x = 0; x < width; x += step) {
    for (int y = 0; y < height; y += step) {
      int loc = x + y*width;
      color c = img.pixels[loc];
      stroke(c);
      strokeWeight(sensorValue);
      vertex(x, y);
    }
  }
  endShape();
}

void draw() {
  //scale(-1, 1); // flip the image
  //image(cam, -width, 0);
  //filter(GRAY);
  //video_to_3d(cam);
  //filter(THRESHOLD, sensorValue);
  //filter(POSTERIZE, 6);
  
  //translate(width/2, height/2);
  //rotateX(mouseY * 0.01); // rotate the img
  //rotateY(mouseX * 0.01);
  //rotateY(a * 1.1);
  //shapeMode(CENTER);
  //image_to_3d(img);
  if(cam.available()) {
    background(0);
    cam.read();
    filter(GRAY);
    PImage img = cam;
    image_to_3d(img);
  }
  
}

void mousePressed() {
  //image_to_3d(img);
  //img = loadImage("ss2.png");
  //img.resize(width, height); // resize the image file to window size
  ////image(img, 0, 0);
  //filter(POSTERIZE, 2);
  //image_to_3d(img);
  
  //if(cam.available()) {
  //  background(0);
  //  cam.read();
  //  filter(GRAY);
  //  PImage img = cam;
  //  image_to_3d(img);
  //}
  
}

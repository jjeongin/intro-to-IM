/* 
   Program Description: Move ellipse with Arduino potentiometer
   Creator Name: Jeongin Lee
   Created Date: Nov 19, 2021
*/

const int potPin = A0;

void setup() {
  Serial.begin(9600);

  // Since both sides wait for each other before they send anything,
  // someone needs to start the conversation
  Serial.println("0");
}

void loop() {
  int sensorValue = analogRead(potPin); // read angle from potentiometer
  Serial.println(sensorValue);
}

/*
   Processing Code
// Program Description: Move ellipse with Arduino potentiometer
// Creator Name: Jeongin Lee
// Created Date: Nov 19, 2021

import processing.serial.*;
Serial myPort;
float sensorValue = 0;

void setup() {
  size(400, 400);
  fill(172, 254, 43); // background color
  String portname = Serial.list()[3]; // adjust port to arduino's serial port
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw() {
  background(172, 254, 43); // background color
  noStroke();
  fill(254, 18, 149); // neon pink
  ellipse(sensorValue, height/2, 50, 50); // draw ellipse
}

void serialEvent(Serial myPort) {
  String s = myPort.readStringUntil('\n'); // get the string from port
  if (s != null) { // if string is not empty
    s = trim(s); // trim off the whitespace
    sensorValue = float(s); // convert it to float
    sensorValue = map(sensorValue, 0, 1023, 0, width); // map input value to the width range
    println(sensorValue);
  }
}
*/

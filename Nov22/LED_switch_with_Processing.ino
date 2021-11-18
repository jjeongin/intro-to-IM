/*
Program Description: LED switch that controls LED on Arduino Uno
Creator Name: Jeongin Lee
Created Date: Nov 18, 2021
*/

/*
   Arduino code by Aaron Sherwood
   Flash an LED when we receive a message from Processing.
   Because Processing is so much faster, we use handshaking
   to avoid overwhelming the Arduino
   Based on
   https://github.com/aaronsherwood/introduction_interactive_media/blob/master/arduinoExamples/serialExamples/buildOffThisOne/buildOffThisOne.ino
*/

const int LEDPIN = 3;

const int flashDuration = 100; // milliseconds
unsigned long turnedLEDOnAt = 0;

void setup() {
  Serial.begin(9600);

  // Since both sides wait for each other before they send anything,
  // someone needs to start the conversation
  Serial.println("0");

  pinMode(LEDPIN, OUTPUT);
}

void loop() {
  
  while (Serial.available()) {
    int valueFromProcessing = Serial.parseInt();

    // Only proceed if we have the end of line
    if (Serial.read() == '\n') {

      if (valueFromProcessing == 1) {
        //  turn on LED
        digitalWrite(LEDPIN, HIGH);
        // and note the time
        turnedLEDOnAt = millis();
      }

      // Tell Processing we're ready for another
      Serial.println(0); // the value doesn't matter
    }
  }

  if (millis() - turnedLEDOnAt >= flashDuration) {
    // turn off LED
    digitalWrite(LEDPIN, LOW);
  }
}

/*
   Processing Code
// LED switch that controls LED on Arduino Uno

import processing.serial.*;
Serial myPort;
boolean arduinoIsReady = false; // check if arduino is ready
boolean lightLED = false; // check if LED should be lighted
int COUNTER = 0; // check if the switch reached to the end

void setup() {
  size(200, 200);
  fill(53, 69, 93); // default, turn led off 
  String portname = Serial.list()[3]; // adjust port to arduino's serial port
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');
}

void draw() {
  background(53, 69, 93); // background color
  noStroke();
  fill(255, 246, 204);
  rect(0, 0, COUNTER, height); // visualize switch
  
  if (arduinoIsReady && COUNTER == width) { // if counter reached end
    lightLED = true; // turn on LED is true
    arduinoIsReady = false;
  }
  else if (arduinoIsReady && COUNTER == 0) {
    lightLED = false; // turn on LED is false
    arduinoIsReady = false;
  }
  
  if (lightLED == true) {
    myPort.write(1 + "\n"); // turn on LED on arduino
  }
  else {
    myPort.write(0 + "\n"); // turn off LED on arduino
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    if (COUNTER < width)
      COUNTER += 10; // increase the counter with right arrow
  }
  else if (keyCode == LEFT) {
    if (COUNTER > 0)
      COUNTER -= 10; // decrease the counter with right arrow
  }
}
*/

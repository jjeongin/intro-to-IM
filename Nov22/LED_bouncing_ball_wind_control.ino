// Wind control with Arduino analog sensor
// by Jeongin Lee

// Original Project:
// Bounce a ball, and each time the ball hits the floor
// flash an LED on Arduino. Whenver Arduino receives a message,
// read an analog port and send it to Processing, to blow the
// ball to the left or right.
// Demonstrates adding serial communication to an existing project.

// Based on 
// https://github.com/aaronsherwood/introduction_interactive_media/blob/master/processingExamples/gravityExamples/gravityWind/gravityWind.pde
// by Aaron Sherwood

const int LEDPIN = 3;
const int potPIN = A0;

const int flashDuration = 50; // milliseconds
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

      float sensorValue = analogRead(potPIN); // read angle from potentiometer
      Serial.println(sensorValue);
    }
  }

  if (millis() - turnedLEDOnAt >= flashDuration) {
    // turn off LED
    digitalWrite(LEDPIN, LOW);
  }
}

/*
   Processing Code:
PVector velocity;
PVector gravity;
PVector position;
PVector acceleration;
PVector wind;
float drag = 0.99;
float mass = 50;
float hDampening;
import processing.serial.*;
Serial myPort;
boolean arduinoIsReady = false;
float sensorValue = 0; // to read analog input from Arduino

void setup() {
  size(640, 700);
  noFill();
  String portname = Serial.list()[3]; // adjust port to arduino's serial port
  myPort = new Serial(this, portname, 9600);
  myPort.clear();
  myPort.bufferUntil('\n');

  position = new PVector(width/2, 0);
  velocity = new PVector(0, 0);
  acceleration = new PVector(0, 0);
  gravity = new PVector(0, 0.5*mass);
  wind = new PVector(0, 0);
  hDampening=map(mass, 15, 80, .98, .96);
}

void draw() {
  background(255);
  velocity.x*=hDampening;
  applyForce(wind);
  applyForce(gravity);
  velocity.add(acceleration);
  velocity.mult(drag);
  position.add(velocity);
  acceleration.mult(0);
  ellipse(position.x, position.y, mass, mass);
  if (position.y > height-mass/2) {
    velocity.y *= -0.9;  // A little dampening when hitting the bottom
    position.y = height-mass/2;
    // send message to Arduio
    if (arduinoIsReady && velocity.mag() > 1) {
      myPort.write(1 + "\n"); // light up LED
      arduinoIsReady = false;
    }
  }
}

void applyForce(PVector force) {
  // Newton's 2nd law: F = M * A
  // or A = F / M
  PVector f = PVector.div(force, mass);
  acceleration.add(f);
}

void serialEvent(Serial myPort) {
  String s = myPort.readStringUntil('\n'); // get the string from port
  arduinoIsReady = true;
  if (s != null) { // if string is not empty
    s = trim(s); // trim off the whitespace
    sensorValue = float(s); // convert it to float
    sensorValue = map(sensorValue, 0, 1023, -100, 100); // map input value to the width range
    wind.x = sensorValue; // change wind based on the analog sensor value
  }
}
 */

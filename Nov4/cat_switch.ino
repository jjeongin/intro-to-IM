const int catSwitch = A0; // cat switch pin
const int redLEDPin = 5;
const int greenLEDPin = 3;

void setup() {
  Serial.begin(9600); // to make sure it's 9600 baud
  pinMode(redLEDPin, OUTPUT);
  pinMode(greenLEDPin, OUTPUT);
}

void loop() {
  int switchState = digitalRead(catSwitch); // read the switch state
  
  if (switchState == HIGH) { // if the switch is on, turn on the red LED and turn off the green LED
    digitalWrite(redLEDPin, HIGH);
    digitalWrite(greenLEDPin, LOW);
  }
  else if (switchState == LOW) { // if the switch is off, turn on the green LED and turn off the red LED
    digitalWrite(greenLEDPin, HIGH);
    digitalWrite(redLEDPin, LOW);
  }
}

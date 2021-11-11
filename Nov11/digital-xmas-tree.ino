const int ldrPin = A0;
const int pushButton = 12;
const int redLEDPin = 6;
const int greenLEDPin = 11;

void setup() {
  pinMode(redLEDPin, OUTPUT);
  pinMode(greenLEDPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int buttonState = digitalRead(pushButton); // check if button is clicked
  int ldrValue = analogRead(ldrPin); // lightness
  if (buttonState == HIGH) { // if button is on, turn on and off each light
    digitalWrite(redLEDPin, HIGH);
    digitalWrite(greenLEDPin, LOW);
    delay(ldrValue); // delay longer when the room is brighter
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, HIGH);
    delay(ldrValue);
  }
  else { // if button is not on, turn off all LEDs
    digitalWrite(redLEDPin, LOW);
    digitalWrite(greenLEDPin, LOW);
  }
}

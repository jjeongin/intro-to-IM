const int ldrPin = A0;

void setup() {
  Serial.begin(9600);

  // Since both sides wait for each other before they send anything,
  // someone needs to start the conversation
  Serial.println("0");
}

void loop() {
  int ldrValue = analogRead(ldrPin); // brightness
  Serial.println(ldrValue);
}

#include "pitch.h"

const int spkrPin = 6; // output
const int switchPin = 13; // digital input (switch)
const int potPin = A2; // analog input (potentiometer)

// Music 1: TOTORO
// melody array referring to <pitch.h>
int totoro_melody[] = {
  NOTE_D5, NOTE_B4, NOTE_G4, NOTE_D5, NOTE_C5, NOTE_A4, 0, 0, 0
};

// note durations: 4 = quarter note, 8 = eighth note, etc.
int totoro_durations[] = {
  2, 4, 2, 2, 2, 1, 4, 4, 4
};

// Music 2: SPIRITED AWAY
int spirited_away_melody[] = {
  NOTE_E4, NOTE_E4, NOTE_E4, NOTE_E4, NOTE_D4, NOTE_E4, NOTE_A4, NOTE_E4, NOTE_D4, NOTE_D4, 0, 0, 0, 0,
  NOTE_D4, NOTE_D4, NOTE_D4, NOTE_D4, NOTE_C4, NOTE_D4, NOTE_G4, NOTE_D4, NOTE_C4, NOTE_B3, NOTE_C4, 0, 0
};

int spirited_away_durations[] = {
  4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4,
  4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 0, 0
};


void setup() {
  pinMode(spkrPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int angle = analogRead(potPin); // read angle from potentiometer
//  angle = map(angle, 0, 1023, 0, 180);
  Serial.println(angle);
  delay(1);
  
  if (digitalRead(switchPin) == HIGH) { // if the switch is pushed
    if (angle <= 90) { // if potentiometer angle is smaller than 90, play totoro
      for (int i = 0; i < sizeof(totoro_melody) / sizeof(totoro_melody[0]); i++) {
        int duration = 1000 / totoro_durations[i]; // calculate the note duration, 1000 millisec = 1 sec (reference: Melody example in Arduino)
        tone(spkrPin, totoro_melody[i], duration); // play each note in the melody
        delay(duration * 1.30); // delay whole program to make sure each note has enough time before playing the next note (reference: Melody example in Arduino)
      }
    }
    else { // if potentiometer angle is bigger than 90, play spirited away
      for (int i = 0; i < sizeof(spirited_away_melody) / sizeof(spirited_away_melody[0]); i++) {
        int duration = 1000 / spirited_away_durations[i]; // calculate the note duration, 1000 millisec = 1 sec (reference: Melody example in Arduino)
        tone(spkrPin, spirited_away_melody[i], duration); // play each note in the melody
        delay(duration * 1.30); // delay whole program to make sure each note has enough time before playing the next note (reference: Melody example in Arduino)
      }
    }
  }


}

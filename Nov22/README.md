## Task 1. Move ellipse in Processing with Arduino analog sensor

https://user-images.githubusercontent.com/68997923/142624146-4dfbef7d-ceae-4b14-9937-0a0fec7a6d08.MOV

Description: Move an ellipse horizontally in Processing according to Potentiometer in Arduino circuit

- Schematics
<img src="Pot_move_circle_schematics.jpg" width=400px/>

- Work Process
  - Built a simple circuit in Arduino with a potentiometer
  - Wrote Processing program that changes ellipse x position according to the sensor value from Arduino
  - Wrote Arduino program that sends potentiometer value to the serial port

## Task 2. LED switch in Processing that controls LED in Arduino circuit


https://user-images.githubusercontent.com/68997923/142625406-e7d21871-8377-4053-bec6-cc26bac0cb42.MOV


Description: LED switch in Processing that controls LED in Arduino circuit

- Schematics
<img src="LED_switch_schematics.jpg" width=400px/>

- Work Process
  - Built a simple circuit in Arduino with a LED
  - Wrote Processing program with a switch that can control the LED
  - Wrote Arduino program that turns on and off LED according to values from Processing



## Task 3. Turn on & off LED and Wind control with Arduino analog sensor


https://user-images.githubusercontent.com/68997923/142625531-08967faa-cc98-452c-8b02-eeb05c0b2761.mov


Description: Turn on & off LED every time the bouncing ball hits the floor. Wind can be controlled with Arduino analog sensor.

- Schematics
<img src="LED_wind_control_schematics.jpg" width=400px/>

- Work Process
  - Built a simple circuit in Arduino with a potentiometer and an LED
  - Revised the Processing code to change the wind value according to an Arduino sensor
  - Revised the Arduino code to turn off the LED after it has been turned on for a certain time

- Difficulties & Experiments
  -  Figuring out how to turn off the LED after certain time was the hardest task among three. I added an condition to the if statement to make sure it only sets the turnLEDOnAt value to the current time if it was previously turned off.
  -  Mapping the wind to right value was also tricky. I chose to map the wind between -100 and 100 so that the bouncing ball can also fly to left if the wind is negative.

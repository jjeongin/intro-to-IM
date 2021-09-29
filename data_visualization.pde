// Artist: Jeongin Lee
// Created date: Sept 29, 2021
// Description: Data visualization of meteorites landed on Earth throught the history
// Data sets:
// Meteorite landing history (https://www.kaggle.com/nasa/meteorite-landings)
// Country coordinates (https://www.kaggle.com/parulpandey/world-coordinates)

// global variables
int WIDTH = 500;
int HEIGHT = 500;
int R = 200;

// country class
//class Country {
//  float lat, lon;
//  String name;
  
//  Country(String _name, float _lat, float _lon) {
//    name = _name;
//    lat = _lat;
//    lon = _lon;
//  }
  
//  void draw_country(float size) {
//    // convert lat, lon to Cartesian coordinates (reference : https://stackoverflow.com/questions/1185408/converting-from-longitude-latitude-to-cartesian-coordinates)
//    float x = R * cos(lat) * cos(lon);
//    float y = R * cos(lat) * sin(lon);
//    float z = R * sin(lat);
//    stroke(255, 50);
//    strokeWeight(5);
//    point(x, y, z);
//  }
//}

// meteor class
class Meteor {
  float lat, lon, mass;
  
  Meteor(float _lat, float _lon, float _mass) {
    lat = _lat;
    lon = _lon;
    mass = _mass;
  }
  
  void draw_meteor() {
    // convert lat, lon to Cartesian coordinates (reference : https://stackoverflow.com/questions/1185408/converting-from-longitude-latitude-to-cartesian-coordinates)
    float x = R * cos(lat) * cos(lon);
    float y = R * cos(lat) * sin(lon);
    float z = R * sin(lat);
    stroke(255, 100);
    point(x*1.2, y*1.2, z*1.2);
  }
}

// helper method to visualize sphere shape
void draw_earth() {
  noStroke();
  noFill();
  lights();
  sphere(200);
}

String[] strings;
//Country[] countries = new Country[244];
ArrayList<Meteor> meteors = new ArrayList<Meteor>(); // defined as dynamic array as there are some invalid data missing one or two necessary parameters

void setup() {
  background(20); // settings
  size(800, 800, P3D);
  
  // load country coordinates data
  strings = loadStrings("data/world_coordinates.csv");
  String[] c_row; // a single row
  for(int i = 1; i < strings.length; i++) {
    c_row = split(strings[i], ',');
    
    // parse each row
    String name = c_row[1];
    float lat = Float.parseFloat(c_row[2]);
    float lon = Float.parseFloat(c_row[3]);
    //countries[i-1] = new Country(name, lat, lon);
  }
  
  
  // load meteorites data
  strings = loadStrings("data/meteorite_landings.csv");
  String[] m_row;
  for(int i = 1; i < strings.length; i++) {
    m_row = split(strings[i], ',');
    
    try {
      float mass = Float.parseFloat(m_row[4]);
      float lat = Float.parseFloat(m_row[7]);
      float lon = Float.parseFloat(m_row[8]);
      meteors.add(new Meteor(lat, lon, mass));
    } catch (Exception e) {
      continue;
    }
    
  }
}

void draw() {
  background(20); // reset background
  
  translate(width/2, height/2, 0); // translate to the center of the canvas
  rotateX(mouseY * 0.05); // rotate the earth
  rotateY(mouseX * 0.05);
  
  //draw_earth(); // draw earth sphere
  //for(int i = 0; i < countries.length; i++) {
  //  countries[i].draw_country(0);
  //}
  
  for(int i = 0; i < meteors.size(); i++) {
    Meteor meteor = meteors.get(i);
    meteor.draw_meteor();
  }
}

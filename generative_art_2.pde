// Color palette 1
color rd = color(205, 30, 45);
color bl = color(55, 92, 166);
color yl = color(232, 136, 36);
color[] palette1 = {rd, bl, yl};

// Color palette 2
color yg = color(128, 195, 98);
color cy = color(18, 146, 145);
color mg = color(191, 31, 135);
color or = color(238, 63, 34);
color[] palette2 = {rd, bl, yl, yg, cy, mg, or};

class Star {
  float x, y, size;
  int spikes;
  color star_color;
  float[] points; // store points
  
  Star(float _x, float _y, float _size) {
    x = _x; // center x, y
    y = _y;
    size = _size; // max size of the star
    
    spikes = int(random(5, 7));
    
    // randomly choose color from the palette
    int rand_color = int(random(palette1.length));
    star_color = palette1[rand_color];
    
    // store points
    points = new float[spikes*4]; // spike & inner bump, x & y
  }
  
  void draw_star() {
    noStroke();
    fill(star_color);
    
    float d, angle; // distance & angle of a spike from the center
    pushMatrix();
    translate(x, y);
    for(int i = 0; i < spikes; i++) {
      d = random(size/2, size);
      angle = 360/spikes;
      points[i] = cos(radians(angle))*d;
      points[i+1] = sin(radians(angle))*d;
      rotate(radians(360/spikes)); // rotate the canvas evenly
      
      d = random(0, size/2);
      angle = 360/(spikes*2);
      points[i+2] = cos(radians(angle))*d;
      points[i+3] = sin(radians(angle))*d;
      rotate(radians(360/(spikes*2))); // rotate the canvas evenly
    }
    popMatrix();
    
    // draw a star
    beginShape();
    for(int i = 0; i < (points.length/2); i++) {
      vertex(points[i]+x, points[i+1]+y);
    }
    endShape(CLOSE);
  }
}

// Global variables
int WIDTH = 500;
int HEIGHT = 700;
int STAR_NUM = int(random(10, 80));
int MAX_SIZE = 400;
int MIN_SIZE = 10;
Star[] myStars = new Star[STAR_NUM];

void setup() {
  int rand = int(random(palette2.length));
  background(palette2[rand]);
  size(500, 700);
  
    for (int i = 0; i < myStars.length; i++) {
    float size = random(MIN_SIZE, MAX_SIZE);
    float x = random(WIDTH);
    float y = random(HEIGHT);
    myStars[i] = new Star(x, y, size);
  }
  
  for (int i = 0; i < myStars.length; i++) {
    myStars[i].draw_star();
  }
}

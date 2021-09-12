// Artist: Jeongin Lee
// Date: September 14, 2021
// Generative artwork using loop
// Inspired by Tyler Hobbs' Flow Fields tutorial (https://tylerxhobbs.com/essays/2020/flow-fields)

// Color palette 1
color pi = color(217, 115, 134);
color bl = color(38, 49, 115);
color gr = color(104, 166, 166);
color yl = color(242, 176, 94);
color rd = color(140, 24, 24);
color bw = color(115, 52, 38);
color gy = color(184, 191, 190);
color[] palette1 = {pi, bl, gr, yl, rd, bw, gy};

// Global variables
int WIDTH = 900;
int HEIGHT = 700;

int step = int(WIDTH * 0.02);

int num_cols = WIDTH / step;
int num_rows = HEIGHT / step;

float line_len = step * 0.5;

// Randomly pick color
void random_color() {
  int rand_color = int(random(palette1.length));
  noFill();
  strokeWeight(1);
  stroke(palette1[rand_color]);
}

// Draw grid
void grid(float rotate) {
  float angle;
  for (int i = 0; i <= num_cols; i++) {
    for (int j = 0; j <= num_rows; j++) {
      angle = j/float(num_rows) * PI + rotate; // by Tyler Hobbs' flow fields tutorial (https://tylerxhobbs.com/essays/2020/flow-fields)
      random_color();
      line(i*step, j*step, i*step + line_len*cos(angle), j*step + line_len*sin(angle));
    }
  }
}

void setup() {
  background(0, 0, 0);
  size(900, 700);
  frameRate(1);
}

float rotate = 0;
void draw() {
  background(0, 0, 0);
  grid(rotate);
  rotate = rotate + 0.5; // rotate per eachiteration
  
  // save each frame
  //saveFrame("loop-art-######.png");
}

// Creator: Jeongin Lee
// Created date: Oct 14, 2021
// Description: PAC-MAN Clone Game

// SETTINGS
// window_w = 492, window_h = 300
// 30 pixel gap on both top & bottom to display game info
import processing.sound.*; // import sound file library
int BOARD_W = 492;
int BOARD_H = 240;
int GRID_SIZE = 12;
int ROW = BOARD_H/GRID_SIZE; // 41
int COL = BOARD_W/GRID_SIZE; // 20

int LIFE = 2;
float SPEED = 2;

//void grid() { // helper method
//  pushMatrix();
//  translate(0, 30);
//  stroke(150);
//  for (int i = 0; i<=COL; i++) // vertical
//    line(0 + GRID_SIZE*i, 0, 0 + GRID_SIZE*i, BOARD_H);
//  for (int j = 0; j<=ROW; j++) // horizontal
//    line(0, 0 + GRID_SIZE*j, BOARD_W, 0 + GRID_SIZE*j);
//  popMatrix();
//}

class PacMan {
  int size = GRID_SIZE*2;
  int row, col;
  String direction = null; // up, down, left, right
  ArrayList<String> available_direction; // array of possible directions in current position
  PImage image;
  int image_step = 0;

  PacMan(int starting_row, int starting_col) {
    this.row = starting_row;
    this.col = starting_col;
    this.available_direction = new ArrayList<String>();
    this.image = sprites[0][9];
  }

  void display() {
    pushMatrix();
    translate(0, 30);
    image(this.image, this.col * GRID_SIZE - GRID_SIZE/2, this.row * GRID_SIZE - GRID_SIZE/2, this.size, this.size);
    popMatrix();
  }

  void move() {
    // move pacman to the other side of pacman reaches a warp tunnel
    if (this.col == 0) { // left end to right end
      this.col = COL-1;
    } else if (this.col == COL-1) { // right end to left end
      this.col = 0;
    }

    if (this.direction == "up" && this.available_direction.contains("up")) {
      this.image = sprites[3+image_step][9];
      this.row -= 1;
    } else if (this.direction == "down" && this.available_direction.contains("down")) {
      this.image = sprites[3+image_step][10];
      this.row += 1;
    } else if (this.direction == "left" && this.available_direction.contains("left")) {
      this.image = sprites[0+image_step][9];
      this.col -= 1;
    } else if (this.direction == "right" && this.available_direction.contains("right")) {
      this.image = sprites[0+image_step][10];
      this.col += 1;
    }
    
    this.image_step = (this.image_step+1) % 3;
  }
}

class Ghost {
  int size = GRID_SIZE*2;
  int row, col;
  String name; // Blinky (red), Pinky (pink), Inky (blue), Clyde (orange)
  String direction; // up, down, left, right
  ArrayList<String> available_direction; // array of possible directions in current position
  boolean in_ghost_house; // true if the ghost is still inside the ghost house
  PImage image;
  int image_col;
  int image_step = 0;

  Ghost(String _name, int starting_row, int starting_col) {
    this.name = _name;
    this.row = starting_row;
    this.col = starting_col;
    this.available_direction = new ArrayList<String>();
    if(this.name == "Blinky") {
      this.image = sprites[0][15];
      this.image_col = 15;
    }
    else if(this.name == "Pinky") {
      this.image = sprites[0][13];
      this.image_col = 13;
    }
    else if(this.name == "Inky") {
      this.image = sprites[0][14];
      this.image_col = 14;
    }
    else if(this.name == "Clyde") {
      this.image = sprites[0][12];
      this.image_col = 12;
    }
  }

  void display() {
    pushMatrix();
    translate(0, 30);
    image(this.image, this.col * GRID_SIZE - GRID_SIZE/2, this.row * GRID_SIZE - GRID_SIZE/2, this.size, this.size);
    popMatrix();
  }

  void move() {
    // move ghost to the other side of ghost reaches a warp tunnel
    if (this.col == 0) { // left end to right end
      this.col = COL-1;
    } else if (this.col == COL-1) { // right end to left end
      this.col = 0;
    }

    if (this.direction == "up" && this.available_direction.contains("up")) {
      this.image = sprites[6][this.image_col];
      this.row -= 1;
    } else if (this.direction == "down" && this.available_direction.contains("down")) {
      this.image = sprites[2][this.image_col];
      this.row += 1;
    } else if (this.direction == "left" && this.available_direction.contains("left")) {
      this.image = sprites[4][this.image_col];
      this.col -= 1;
    } else if (this.direction == "right" && this.available_direction.contains("right")) {
      this.image = sprites[0][this.image_col];
      this.col += 1;
    }
    
    this.image_step = (this.image_step+1) % 2;
  }

  void change_direction() {
    if (this.available_direction.size() == 0) // error handling
      this.direction = null;
    else {
      int random_direction = (int) random(0, this.available_direction.size());
      this.direction = this.available_direction.get(random_direction);
    }
  }
}

class PacDot {
  int row, col;
  PacDot(int _row, int _col) {
    this.row = _row;
    this.col = _col;
  }
  void display() {
    pushMatrix();
    translate(0, 30);
    noStroke();
    fill(255, 183, 174); // color of pac-dots
    square(this.col * GRID_SIZE + GRID_SIZE/2, this.row * GRID_SIZE + GRID_SIZE/2, 2);
    popMatrix();
  }
}

// class to represent each area of the maze
class Area {
  int row, col;
  Area(int _row, int _col) {
    this.row = _row;
    this.col = _col;
  }
}

class Maze {
  ArrayList<Area> valid_area; // areas that pacman and ghosts can move around
  ArrayList<PacDot> pacdots;
  ArrayList<Area> ghost_house;
  Area ghost_house_exit;
  Area PacMan_initial_pos;
  Area Blinky_initial_pos;
  Area Pinky_initial_pos;
  Area Inky_initial_pos;
  Area Clyde_initial_pos;
  PImage bg;

  Maze() {
    this.bg = loadImage(path + "/images/bg_f.png"); // load background image

    this.PacMan_initial_pos = new Area(18, 25);
    this.Blinky_initial_pos = new Area(5, 23);
    this.Pinky_initial_pos = new Area(7, 23);
    this.Inky_initial_pos = new Area(8, 22);
    this.Clyde_initial_pos = new Area(8, 24);

    this.ghost_house = new ArrayList<Area>();
    this.ghost_house.add( new Area(7, 22) );
    this.ghost_house.add( new Area(7, 23) );
    this.ghost_house.add( new Area(7, 24) );
    this.ghost_house.add( new Area(8, 22) );
    this.ghost_house.add( new Area(8, 23) );
    this.ghost_house.add( new Area(8, 24) );
    this.ghost_house_exit = new Area(6, 23);

    // add valid area
    this.valid_area = new ArrayList<Area>();
    for (int i = 1; i < 40; i++) { // 1st row
      this.valid_area.add( new Area(1, i) );
    }
    this.valid_area.add( new Area(2, 1) );
    this.valid_area.add( new Area(2, 7) );
    this.valid_area.add( new Area(2, 19) );
    this.valid_area.add( new Area(2, 31) );
    this.valid_area.add( new Area(2, 36) );
    this.valid_area.add( new Area(2, 39) );
    this.valid_area.add( new Area(3, 1) );
    this.valid_area.add( new Area(3, 7) );
    this.valid_area.add( new Area(3, 19) );
    this.valid_area.add( new Area(3, 31) );
    this.valid_area.add( new Area(3, 36) );
    this.valid_area.add( new Area(3, 39) );
    this.valid_area.add( new Area(4, 1) );
    this.valid_area.add( new Area(4, 7) );
    this.valid_area.add( new Area(4, 19) );
    this.valid_area.add( new Area(4, 31) );
    this.valid_area.add( new Area(4, 36) );
    this.valid_area.add( new Area(4, 39) );
    this.valid_area.add( new Area(5, 1) );
    this.valid_area.add( new Area(5, 7) );
    for (int i = 19; i < 37; i++)
      this.valid_area.add( new Area(5, i) );
    this.valid_area.add( new Area(5, 39) );
    this.valid_area.add( new Area(6, 1) );
    this.valid_area.add( new Area(6, 2) );
    this.valid_area.add( new Area(6, 3) );
    this.valid_area.add( new Area(6, 7) );
    this.valid_area.add( new Area(6, 11) );
    this.valid_area.add( new Area(6, 15) );
    this.valid_area.add( new Area(6, 19) );
    this.valid_area.add( new Area(6, 27) );
    this.valid_area.add( new Area(6, 31) );
    this.valid_area.add( new Area(6, 36) );
    this.valid_area.add( new Area(6, 37) );
    this.valid_area.add( new Area(6, 38) );
    this.valid_area.add( new Area(6, 39) );
    this.valid_area.add( new Area(7, 3) );
    this.valid_area.add( new Area(7, 7) );
    this.valid_area.add( new Area(7, 11) );
    this.valid_area.add( new Area(7, 15) );
    this.valid_area.add( new Area(7, 19) );
    this.valid_area.add( new Area(7, 27) );
    this.valid_area.add( new Area(7, 31) );
    this.valid_area.add( new Area(7, 36) );
    this.valid_area.add( new Area(8, 3) );
    this.valid_area.add( new Area(8, 7) );
    this.valid_area.add( new Area(8, 11) );
    this.valid_area.add( new Area(8, 15) );
    this.valid_area.add( new Area(8, 19) );
    this.valid_area.add( new Area(8, 27) );
    this.valid_area.add( new Area(8, 31) );
    this.valid_area.add( new Area(8, 36) );
    this.valid_area.add( new Area(9, 3) );
    this.valid_area.add( new Area(9, 7) );
    this.valid_area.add( new Area(9, 11) );
    this.valid_area.add( new Area(9, 15) );
    this.valid_area.add( new Area(9, 19) );
    this.valid_area.add( new Area(9, 27) );
    this.valid_area.add( new Area(9, 31) );
    this.valid_area.add( new Area(9, 36) );
    this.valid_area.add( new Area(10, 0) );
    this.valid_area.add( new Area(10, 1) );
    this.valid_area.add( new Area(10, 2) );
    this.valid_area.add( new Area(10, 3) );
    this.valid_area.add( new Area(10, 7) );
    this.valid_area.add( new Area(10, 11) );
    this.valid_area.add( new Area(10, 15) );
    for (int i = 19; i < 32; i++)
      this.valid_area.add( new Area(10, i) );
    for (int i = 34; i < 41; i++)
      this.valid_area.add( new Area(10, i) );
    this.valid_area.add( new Area(11, 3) );
    this.valid_area.add( new Area(11, 7) );
    this.valid_area.add( new Area(11, 11) );
    this.valid_area.add( new Area(11, 15) );
    this.valid_area.add( new Area(11, 19) );
    this.valid_area.add( new Area(11, 31) );
    this.valid_area.add( new Area(11, 36) );
    this.valid_area.add( new Area(12, 3) );
    this.valid_area.add( new Area(12, 7) );
    this.valid_area.add( new Area(12, 11) );
    this.valid_area.add( new Area(12, 15) );
    this.valid_area.add( new Area(12, 19) );
    this.valid_area.add( new Area(12, 31) );
    this.valid_area.add( new Area(12, 36) );
    this.valid_area.add( new Area(13, 3) );
    this.valid_area.add( new Area(13, 7) );
    this.valid_area.add( new Area(13, 11) );
    this.valid_area.add( new Area(13, 15) );
    this.valid_area.add( new Area(13, 19) );
    this.valid_area.add( new Area(13, 31) );
    this.valid_area.add( new Area(13, 36) );
    for (int i = 1; i < 24; i++)
      this.valid_area.add( new Area(14, i) );
    for (int i = 27; i < 40; i++)
      this.valid_area.add( new Area(14, i) );
    this.valid_area.add( new Area(15, 1) );
    this.valid_area.add( new Area(15, 7) );
    this.valid_area.add( new Area(15, 19) );
    this.valid_area.add( new Area(15, 23) );
    this.valid_area.add( new Area(15, 27) );
    this.valid_area.add( new Area(15, 31) );
    this.valid_area.add( new Area(15, 39) );
    this.valid_area.add( new Area(16, 1) );
    this.valid_area.add( new Area(16, 7) );
    this.valid_area.add( new Area(16, 19) );
    this.valid_area.add( new Area(16, 23) );
    this.valid_area.add( new Area(16, 27) );
    this.valid_area.add( new Area(16, 31) );
    this.valid_area.add( new Area(16, 39) );
    this.valid_area.add( new Area(17, 1) );
    this.valid_area.add( new Area(17, 7) );
    this.valid_area.add( new Area(17, 19) );
    this.valid_area.add( new Area(17, 23) );
    this.valid_area.add( new Area(17, 27) );
    this.valid_area.add( new Area(17, 31) );
    this.valid_area.add( new Area(17, 39) );
    for (int i = 1; i < 20; i++)
      this.valid_area.add( new Area(18, i) );
    for (int i = 23; i < 28; i++)
      this.valid_area.add( new Area(18, i) );
    for (int i = 31; i < 40; i++)
      this.valid_area.add( new Area(18, i) );

    // add pacdots
    this.pacdots = new ArrayList<PacDot>();
    for (int i = 0; i < this.valid_area.size(); i++) {  // add pac-dot in the middle of each valid area
      Area ith_valid_area = this.valid_area.get(i);
      if (ith_valid_area.row == 10 && ith_valid_area.col <= 2) // no pacdot on the warp tunnel (left)
        continue;
      else if (ith_valid_area.row == 10 && ith_valid_area.col >= 37) // no pacdot on the the warp tunnel (right)
        continue;
      else if (ith_valid_area.row == 5 && ith_valid_area.col >= 19 && ith_valid_area.col <= 30) // no pacdot around the ghost house (top)
        continue;
      else if (ith_valid_area.row == 10 && ith_valid_area.col >= 19 && ith_valid_area.col <= 30) // no pacdot around the ghost house (bottom)
        continue;
      else if (ith_valid_area.col == 19 && ith_valid_area.row >= 2 && ith_valid_area.row <= 13) // no pacdot around the ghost house (left)
        continue;
      else if (ith_valid_area.col == 27 && ith_valid_area.row >= 6 && ith_valid_area.row <= 9) // no pacdot around the ghost house (right)
        continue;
      this.pacdots.add(new PacDot(ith_valid_area.row, ith_valid_area.col)); // add pacdot to the valid area
    }
  }

  void display() {
    image(this.bg, 0, 0, width, height); // display background
    for (int i = 0; i < this.pacdots.size(); i++) { // display pacdots
      this.pacdots.get(i).display();
    }
  }
}

class Game {
  int life;
  Maze maze;
  PacMan pacman;
  Ghost[] ghosts;
  PImage life_icon;

  Game() {
    this.life = LIFE;
    this.maze = new Maze();
    this.pacman = new PacMan(this.maze.PacMan_initial_pos.row, this.maze.PacMan_initial_pos.col);
    this.ghosts = new Ghost[4];
    this.ghosts[0] = new Ghost("Blinky", this.maze.Blinky_initial_pos.row, this.maze.Blinky_initial_pos.col); // initialize ghosts
    this.ghosts[1] = new Ghost("Pinky", this.maze.Pinky_initial_pos.row, this.maze.Pinky_initial_pos.col);
    this.ghosts[2] = new Ghost("Inky", this.maze.Inky_initial_pos.row, this.maze.Inky_initial_pos.col);
    this.ghosts[3] = new Ghost("Clyde", this.maze.Clyde_initial_pos.row, this.maze.Clyde_initial_pos.col);
    this.life_icon = sprites[5][7]; // icon to display the number of life left
  }

  void display() {
    // move pacman and ghosts
    this.pacman.move();
    for (int i = 0; i < this.ghosts.length; i++) {
      this.ghosts[i].move();
    }
    
    // display elements
    this.maze.display();
    this.pacman.display();
    for (int i = 0; i < this.ghosts.length; i++) {
      ghosts[i].display();
    }
    for (int i = 0; i < this.life; i++) { // display life
      image(this.life_icon, 10 + i*this.pacman.size, 35 + BOARD_H, this.pacman.size, this.pacman.size);
    }

    this.update();

    this.check_available_direction_for_pacman();
    for (int i = 0; i < this.ghosts.length; i++) {
      this.check_available_direction_for_ghosts(ghosts[i]);
      if (!(this.ghosts[i].available_direction.contains(this.ghosts[i].direction))) {
        this.ghosts[i].change_direction();
      }
    }
  }

  void check_available_direction_for_pacman() {
    this.pacman.available_direction.clear(); // clear info from the previous position

    // check possible direction of pacman
    for (int i = 0; i < this.maze.valid_area.size(); i++) {
      Area ith_valid_area = this.maze.valid_area.get(i);
      // warp tunnel
      if ( this.pacman.row == 10 && this.pacman.col == 0 )
        this.pacman.available_direction.add("left");
      if ( this.pacman.row == 10 && this.pacman.col == 40 )
        this.pacman.available_direction.add("right");
      // other valid area
      if ( this.pacman.row == ith_valid_area.row && this.pacman.col - 1 == ith_valid_area.col ) {
        this.pacman.available_direction.add("left");
      }
      if ( this.pacman.row == ith_valid_area.row && this.pacman.col + 1 == ith_valid_area.col ) {
        this.pacman.available_direction.add("right");
      }
      if ( this.pacman.col == ith_valid_area.col && this.pacman.row - 1 == ith_valid_area.row ) {
        this.pacman.available_direction.add("up");
      }
      if ( this.pacman.col == ith_valid_area.col && this.pacman.row + 1 == ith_valid_area.row ) {
        this.pacman.available_direction.add("down");
      }
    }
  }

  void check_available_direction_for_ghosts(Ghost ghost) {
    // check possible direction of each ghost
    ghost.available_direction.clear(); // clear info from the previous position
    
    // if ghost in on the ghost house exit, only choice is to go up
    if ( ghost.row == this.maze.ghost_house_exit.row && ghost.col == this.maze.ghost_house_exit.col ) {
      ghost.available_direction.add("up");
      return;
    }
    else if ( ghost.row - 1 == this.maze.ghost_house_exit.row && ghost.col == this.maze.ghost_house_exit.col ) {
      ghost.available_direction.add("up");
      return;
    }
    
    // otherwise, if ghost in in the ghost house, move around the house
    for (int i = 0; i < this.maze.ghost_house.size(); i++) {
      Area ghost_house_area = this.maze.ghost_house.get(i);
      if ( ghost.row == ghost_house_area.row && ghost.col - 1 == ghost_house_area.col ) {
        ghost.available_direction.add("left");
      }
      if ( ghost.row == ghost_house_area.row && ghost.col + 1 == ghost_house_area.col ) {
        ghost.available_direction.add("right");
      }
      if ( ghost.col == ghost_house_area.col && ghost.row - 1 == ghost_house_area.row ) {
        ghost.available_direction.add("up");
      }
      if ( ghost.col == ghost_house_area.col && ghost.row + 1 == ghost_house_area.row ) {
        ghost.available_direction.add("down");
      }
    }

    // move around the valid area
    for (int i = 0; i < this.maze.valid_area.size(); i++) {
      Area ith_valid_area = this.maze.valid_area.get(i);
      if ( ghost.row == 10 && ghost.col == 0 )  // warp tunnel
        ghost.available_direction.add("left");
      if ( ghost.row == 10 && ghost.col == 40 )
        ghost.available_direction.add("right");
      if ( ghost.row == ith_valid_area.row && ghost.col - 1 == ith_valid_area.col ) { // other valid area
        ghost.available_direction.add("left");
      }
      if ( ghost.row == ith_valid_area.row && ghost.col + 1 == ith_valid_area.col ) {
        ghost.available_direction.add("right");
      }
      if ( ghost.col == ith_valid_area.col && ghost.row - 1 == ith_valid_area.row ) {
        ghost.available_direction.add("up");
      }
      if ( ghost.col == ith_valid_area.col && ghost.row + 1 == ith_valid_area.row ) {
        ghost.available_direction.add("down");
      }
    }
  }

  void update() {
    // remove pacdots if pacman ate it
    for (int i = 0; i < this.maze.pacdots.size(); i++) {
      PacDot ith_pacdot = this.maze.pacdots.get(i);
      if ( this.pacman.row == ith_pacdot.row && this.pacman.col == ith_pacdot.col) {
        this.maze.pacdots.remove(i);
      }
    }
    
    int count = 0;
    // when pacman meets the ghost, decrement the life and start a new round
    while( count < this.ghosts.length ) {
      if( (pow(this.pacman.row - this.ghosts[count].row, 2) + pow(this.pacman.col - this.ghosts[count].col, 2)) <= 1 ) {
        death_sound.play();
        this.life--;
        this.start_new_round();
      }
      count++;
    }
  }
 
  void start_new_round() {
    background(0);
    PacMan new_pacman = new PacMan(this.maze.PacMan_initial_pos.row, this.maze.PacMan_initial_pos.col);
    Ghost new_Blinky = new Ghost("Blinky", this.maze.Blinky_initial_pos.row, this.maze.Blinky_initial_pos.col);
    Ghost new_Pinky = new Ghost("Pinky", this.maze.Pinky_initial_pos.row, this.maze.Pinky_initial_pos.col);
    Ghost new_Inky = new Ghost("Inky", this.maze.Inky_initial_pos.row, this.maze.Inky_initial_pos.col);
    Ghost new_Clyde = new Ghost("Clyde", this.maze.Clyde_initial_pos.row, this.maze.Clyde_initial_pos.col);
    
    this.pacman = new_pacman;
    this.ghosts[0] = new_Blinky;
    this.ghosts[1] = new_Pinky;
    this.ghosts[2] = new_Inky;
    this.ghosts[3] = new_Clyde;
  }

  boolean check_end() {
    if( this.life == 0 ) {
      background(0);
      fill(255,255,255);
      textSize(30);
      text("GAME   OVER", width/2, height/2);
      textSize(20);
      text("PRESS   ANY   KEY   TO   RESTART", width/2, height/3*2);
      return true;
    }
    else if( this.maze.pacdots.size() == 0 ) {
      background(0);
      fill(255,255,255);
      textSize(30);
      text("GAME   CLEAR!", width/2, height/2);
      textSize(20);
      text("PRESS   ANY   KEY   TO   RESTART", width/2, height/3*2);
      return true;
    }
    else {
      return false;
    }
  }
}

// global variables
String path;
PImage spritesheet;
PImage[][] sprites;
int sprites_w;
int sprites_h;
SoundFile beginning_sound;
SoundFile death_sound;
PFont ArcadeClassic;
PShape logo;
int current_frame;

boolean start;
Game game;

void setup() {
  path = sketchPath(); // to get the current path
  background(10);
  size(492, 300);
  ArcadeClassic = createFont(path + "/font/ArcadeClassic.TTF", 20);
  textFont(ArcadeClassic);
  textAlign(CENTER); // align every text to center
  
  // load image files
  spritesheet = loadImage(path + "/images/sprites.png");
  sprites_w = spritesheet.width/16;
  sprites_h = spritesheet.height/16;
  sprites = new PImage[16][16]; // 16 images across, 16 down
  for (int r = 0; r < 16; r++) {
    for (int c = 0; c < 16; c++) {
      sprites[r][c] = spritesheet.get(c*sprites_w, r*sprites_h, sprites_w, sprites_h);
    }
  }
  
  // load logo img
  logo = loadShape(path + "/images/logo.svg");
  
  // load sound files
  beginning_sound = new SoundFile(this, path + "/sound/intro.aiff");
  death_sound = new SoundFile(this, path + "/sound/death.aiff");
  
  start = false; // initialize start as false, until the user clicks the key
  game = new Game();
}

void draw() {
  if (start == true) {
    if (frameCount % 10 == 0) { // slow down everything, including pacman & ghost speed
      game.display();
    }
    if (game.check_end() == true) { // if game ended, stop draw function and set start as false
      noLoop();
      start = false;
    }
  }
  else {
    background(10);
    //text("IM   PAC-MAN  (<", width/2, height/2); // tried text logo
    shape(logo, width/2 - width/10*4, 50, width/5*4, height/5*2); // display logo image
    textSize(30);
    text("IM", width/8*6, height/5*3);
    textSize(20);
    text("PRESS   ANY   KEY   TO   START\n ARROW   KEY   TO   MOVE", width/2, height/5*4);
  }
}

void keyPressed() {
  if (game.check_end() == true) { // if game ended, user can restart by pressing any key
    game = new Game();
    start = true;
    beginning_sound.play();
    loop();
  }
  
  if (start == false) { // press any button to start
    start = true;
    beginning_sound.play();
  } else if (start == true) {
    // Change direction of PacMan using arrow keys
    if (keyCode == UP && game.pacman.available_direction.contains("up")) {
      game.pacman.direction = "up";
    } else if (keyCode == DOWN && game.pacman.available_direction.contains("down")) {
      game.pacman.direction = "down";
    } else if (keyCode == LEFT && game.pacman.available_direction.contains("left")) {
      game.pacman.direction = "left";
    } else if (keyCode == RIGHT && game.pacman.available_direction.contains("right")) {
      game.pacman.direction = "right";;
    }
  }
}

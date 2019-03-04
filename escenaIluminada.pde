PImage rubik;
PImage basketball;

PShape cube;
PShape ball;

float desp;
float angle;
float r,g,b;
float px;
float orbitRadius = 30;
boolean bright = false;
boolean moveRight,moveLeft;
boolean directionalLight = false;

void setup() {
  size(700, 700, P3D);
  noStroke();
  desp = 80;
  r =  7;
  g = 65;
  b = 180;
  rubik = loadImage("rubiks-cube.png");
  basketball = loadImage("basketball.jpg");
  
  cube = createShape(BOX, 80);
  cube.setTexture(rubik);
  ball = createShape(SPHERE,100);
  ball.setTexture(basketball);
  
}

void draw() {
  background(0);
  ambientLight(r,g,b);
  
  if(!bright) {
    stroke(255);
    text("Press SPACE to turn the lights ON",width/2,30);
  } else {
    stroke(255);
    text("Press SPACE to turn the lights OFF\nUse the ARROW KEYS (<-, ->) to move the camera\nPress D to use Directional Light",width/2,30);
  }
  
  if(directionalLight) directionalLight(50, 200, 50, 50, 0, 0);
  
  moveCamera();
  camera(width/2 + px, height/2.0,(height/2.0)/tan(PI*30.0/180.0),width/2.0, height/2.0, 0, 0, 1, 0);
  
  createRubik();
  createBasketball();

  moveShapes();
}

void moveShapes() {
  // Control the rotation of the planet
  angle = angle + 0.5;
  if(angle > 360) {
    angle = 0;
  }
}

void createRubik() {
  pushMatrix();
  translate(width/2 - desp, height/2 - desp, 0);
  rotateX(radians(-30));
  rotateY(radians(angle));
  shape(cube);
  popMatrix();
}

void createBasketball() {
  pushMatrix();
  noStroke();
  translate(width/2 + desp, height/2 + desp, 0);
  rotateY(radians(-angle));
  shape(ball);
  popMatrix();
}

void moveCamera() {
  if(moveRight) px += 2;
  if(moveLeft) px -= 2;
}

void keyPressed() {
  if(keyCode == 'D') directionalLight = !directionalLight;
  if(keyCode==RIGHT) moveRight = true;
  if(keyCode==LEFT) moveLeft = true;
  
  if(keyCode == ' ' && !bright) {
    bright = true;
    r=g=b=255;
    
  } else if(keyCode == ' ' && bright) {
    bright = false;
    r =  7;
    g = 65;
    b = 180;
  }
}

void keyReleased() {
  if(keyCode==RIGHT) moveRight = false;
  if(keyCode==LEFT) moveLeft = false;
}

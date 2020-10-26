// AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH end

float xPos=0f, yPos=0f;
float xVel=0f, yVel=0f;
final float friction=0.995f;
final float elasticity=0.8f;
final int radius = 32;
final float xGravity = 0f, yGravity=-0.05f;
final float thrust = 0.2f;

boolean pressKeys[] = new boolean[256];

float angle=0;
final float rotationSpeed=0.1f;
PImage img;
void setup() {
  size(900, 850);
  frameRate(60);

  img = loadImage("testSprite.png");

  xPos=width/2;
  yPos=height/2;
}

void draw() {
  int xDist = mouseX - (width/2);
  int yDist = mouseY - (height/2);
  clear();
  background(100);
  stroke(255, 0, 0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  //line(width/2, height/2, mouseX, mouseY);
  xVel += xGravity;
  yVel += yGravity;

  stroke(255, 0, 0);
  line(200, 200+radius, 100+radius, 100+radius);
  if (keyPressed==true) {
    //System.out.println(keyCode); 
    if (pressKeys[' ']) {
      yVel -= thrust*Math.sin(angle-Math.PI/2);
      xVel += thrust*Math.cos(angle-Math.PI/2);
    }
    if (pressKeys['a']) {
      angle-=rotationSpeed;
    }
    if (pressKeys['d']) {
      angle+= rotationSpeed;
    }
  }

  xVel *= friction;
  yVel *= friction;

  xPos += xVel;
  yPos -= yVel;

  if (xPos>width-radius) {
    //xVel *= -elasticity;
    xPos = radius;
  }
  if (xPos<radius) {
    //xVel *= -elasticity;
    xPos = width-radius;
  }
  if (yPos>height-radius) {
    //yVel *= -elasticity;
    yVel=0;
    yPos = height-radius;
  }
  if (yPos<radius) {
    //yVel *= -elasticity;
    yVel=0;
    yPos = radius;
  }

  if (isColliding(200, 200+radius, 100+radius, 100+radius)) {
    System.out.println("AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH");
    exit();
  }

  fill(0, 0, 255);
  stroke(0, 0, 255);

  translate(xPos, yPos);
  rotate(angle);
  imageMode(CENTER);
  image(img, 0, 0);
}

void keyPressed() {
  if (key<256) {
    pressKeys[key]=true;
  }
}

void keyReleased() {
  if (key<256) {
    pressKeys[key]=false;
  }
}

public boolean isColliding( float x1, float y1, float x2, float y2) {
  if (Math.sqrt(Math.pow((xPos-x1), 2)+Math.pow((yPos-y1), 2))<=radius) {
    return true;
  }
  if (Math.sqrt(Math.pow((xPos-x2), 2)+Math.pow((yPos-y2), 2))<=radius) {
    return true;
  }
  float dot = ((xPos-x1)*(x2-x1)) + ((yPos-y1)*(y2-y1));
  float uLength = (float)Math.sqrt(Math.pow(xPos-x1, 2)+Math.pow(yPos-y1, 2));
  float vLength = (float)Math.sqrt(Math.pow(x2-x1, 2)+Math.pow(y2-y1, 2));
  float d = (float)Math.acos(dot/(uLength*vLength));

  if (d>Math.PI/2) {
    return false;
  }
  dot = ((xPos-x2)*(x1-x2)) + ((yPos-y2)*(y1-y2));
  uLength = (float)Math.sqrt(Math.pow(xPos-x2, 2)+Math.pow(yPos-y2, 2));
  vLength = (float)Math.sqrt(Math.pow(x1-x2, 2)+Math.pow(y1-y2, 2));
  d = (float)Math.acos(dot/(uLength*vLength));
  
  if (d>Math.PI/2) {
    return false;
  }
  float headingX=(x2-x1)/dist(x1, y1, x2, y2), headingY=(y2-y1)/dist(x1, y1, x2, y2);
  dot = (xPos-x1)*headingX + (yPos-y1)*headingY;
  float closestX = x1 + (dot * headingX);
  float closestY = y1 + (dot * headingY);

  fill(255);
  circle(closestX, closestY, 30);
  float totDist = dist(xPos, yPos, closestX, closestY);
  if (totDist<=radius) {
    return true;
  }

  return false;
}

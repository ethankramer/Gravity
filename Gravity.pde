// AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH end

float xPos=0f, yPos=0f;
float xVel=0f, yVel=0f;
final float friction=0.995f;
final float elasticity=0.8f;
final int radius = 50;
final float xGravity = 0f, yGravity=-0.05f;
final float thrust = 0.2f;

float angle=0;
final float rotationSpeed=0.1f;

void setup() {
  size(900, 850);
  frameRate(60);

  xPos=width/2;
  yPos=height/2;
}

void draw() {
  int xDist = mouseX - (width/2);
  int yDist = mouseY - (height/2);
  clear();
  background(50);
  stroke(255, 0, 0);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  //line(width/2, height/2, mouseX, mouseY);
  xVel += xGravity;
  yVel += yGravity;

  if (keyPressed==true) {
    //System.out.println(keyCode);
    if (key == ' ') {
      yVel -= thrust*Math.sin(angle-Math.PI/2);
      xVel += thrust*Math.cos(angle-Math.PI/2);
    }
    if(key == 'a'){
       angle-=rotationSpeed; 
    }
    if(key =='d'){
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

  fill(0, 0, 255);
  stroke(0,0,255);
  translate(xPos,yPos);
  rotate(angle);
  triangle(0, 0, -radius/2,radius, radius/2,radius);
}

void keyPressed() {
  //System.out.println(keyCode); 
  // if(keyCode==32){
  //    yVel += thrust;
  //}
}

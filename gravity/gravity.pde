float k = 10000;
int numBodies = 200;
float vbound = 1.5;

Body [] bodies = new Body[numBodies];

void setup() {
  size(1000, 1000);
  for (int i=0; i<bodies.length; i++) {
    bodies[i] = new Body(cube(random(5)));
  }
  frameRate(60);
}

void draw() {
  translate(width/2, height/2);
  background(255);
  for (int i=0; i<bodies.length; i++) {
    bodies[i].getaccel();
    bodies[i].update();
    bodies[i].display();
    bodies[i].drawpath();
    for (int j =0; j<bodies.length; j++) {
      if (j!=i) {
        bodies[i].collide(bodies[j]);
      }
    }
  }
}

float square(float f) {
  return f*f;
}

float cube(float f) {
  return f*f*f;
}

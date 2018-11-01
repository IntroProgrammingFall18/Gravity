float k = 10000;
int numBodies = 200;
float vbound = 1.5;

//Body [] bodies = new Body[numBodies];

// our intention to fill this ArrayList with Body objects
ArrayList <Body> bodies = new ArrayList<Body>();



void setup() {
  size(1000, 1000);
  for (int i=0; i<numBodies; i++) {
    // Objects can be added to an ArrayList with add()
    bodies.add(new Body(cube(random(5))));
  }
  frameRate(60);
}

void draw() {
  translate(width/2, height/2);
  background(255);
  //remove defunct bodies
  for (int i = bodies.size() - 1; i >= 0; i--) {
    Body body = bodies.get(i);
    if (body.remove) {
      bodies.remove(i);
    }
  }
  for (Body body : bodies) {
    body.getaccel();
    body.update();
    body.display();
    body.drawpath();
    for (Body otherbody : bodies) {
      if (body != otherbody && !body.remove && !otherbody.remove) {
        body.collide(otherbody);
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

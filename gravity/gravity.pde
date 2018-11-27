float k = 10000;
int numBodies = 200;
float vbound = 1.5;
float zoomFactor = 1.0;
float xDrag =0;
float yDrag =0;
Table saveData;

// our intention to fill this ArrayList with Body objects
ArrayList <Body> bodies = new ArrayList<Body>();



void setup() {
  size(1000, 1000);
  initializeTable();
  
  for (int i=0; i<numBodies; i++) {
    // Objects can be added to an ArrayList with add()
    bodies.add(new Body(cube(random(5))));
  }
  frameRate(60);

  saveTable(saveData, "saveData.csv");
}

void draw() {
  translate(width/2+xDrag*zoomFactor, height/2+ yDrag*zoomFactor);
  //translate(width/2+(mouseX-width/2)*zoomFactor, height/2+ (mouseY-height/2)*zoomFactor);
  scale(zoomFactor);
  background(255);
  //remove defunct bodies
  for (int i = bodies.size() - 1; i >= 0; i--) {
    Body body = bodies.get(i);
    if (body.remove) {
      bodies.remove(i);
    }
  }
  //updates and displays all bodies
  for (Body body : bodies) {
    body.getaccel();
  }
  for (Body body : bodies) {
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

void mouseWheel(MouseEvent event) {
  zoomFactor *= pow(.5, event.getCount());
}

void mouseDragged() 
{
  xDrag += (mouseX-pmouseX)/zoomFactor;
  yDrag += (mouseY-pmouseY)/zoomFactor;
}

float square(float f) {
  return f*f;
}

float cube(float f) {
  return f*f*f;
}

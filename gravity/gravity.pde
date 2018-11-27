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
  xDrag = width/2;
  yDrag = height/2;
  initializeTable();
  
  for (int i=0; i<numBodies; i++) {
    // Objects can be added to an ArrayList with add()
    bodies.add(new Body(cube(random(5))));
  }
  frameRate(60);

  //If this kicks a null Pointer Exception, check to make sure you don't have the csv open in excel...
  saveTable(saveData, "saveData.csv");
}

void draw() {
  pushMatrix();

  translate(xDrag, yDrag);
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
  
  popMatrix();
}

void mouseWheel(MouseEvent e) {
  xDrag -= mouseX;
  yDrag -= mouseY;
  //float delta = e.getCount() > 0 ? 1.05 : e.getCount() < 0 ? 1.0/1.05 : 1.0;
  float delta =1.0;
  //zoomFactor *= pow(.5,e.getCount()); 
  delta = pow(.7,e.getCount()); 
  //if (e.getCount() > 0) { 
  //  delta = 1.05;
  //} else if (e.getCount() < 0) { 
  //  delta  = 1.0/1.05;
  //}

  zoomFactor *= delta;
  xDrag *= delta;
  yDrag *= delta;
  xDrag += mouseX;
  yDrag += mouseY;
}

void mouseDragged() 
{
  xDrag += (mouseX-pmouseX);
  yDrag += (mouseY-pmouseY);
}

void keyPressed() {
  if (key == 'r') {
    zoomFactor = 1;
    xDrag = 0.0;
    yDrag = 0.0;
  }
}

float square(float f) {
  return f*f;
}

float cube(float f) {
  return f*f*f;
}

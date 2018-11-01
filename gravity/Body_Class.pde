class Body {
  float mass = 1;
  float radius;
  float lx;
  float ly;
  float vx;
  float vy;
  float ax;
  float ay;
  float[] pathx = {};
  float[] pathy = {};
  color bodyColor;
  boolean remove = false;

  Body(float tempmass) {
    mass = tempmass;
    radius = sqrt(tempmass);
    bodyColor = color(int(random(50, 254)), int(random(50, 254)), int(random(50, 254)));
    lx = random(-width/2, width/2);
    ly = random(-height/2, height/2);
    ax = 0;
    ay = 0;
    vx = random(-vbound, vbound);
    vy = random(-vbound, vbound);
    pathx = append(pathx, lx);
    pathy = append(pathy, ly);
  }

  void display() {
    fill(bodyColor);
    ellipse(lx, ly, 2*radius, 2*radius);
  }

  void update() {
    vx = vx + ax;
    vy = vy + ay;
    lx = lx + vx;
    ly = ly + vy;
    pathx = append(pathx, lx);
    pathy = append(pathy, ly);
  }

  void drawpath() {
    stroke(bodyColor);
    //if (drawpath) {
      for (int j =0; j<pathx.length-1; j++) {
        line(pathx[j], pathy[j], pathx[j+1], pathy[j+1]);
      }
    //}
  }

  void getaccel() {
    ax =0;
    ay = 0;
    for (Body body : bodies) {
      if (body.lx-lx != 0 && body.ly-ly != 0) {
        ax = ax + (body.lx-lx)*body.mass/(cube(sqrt(square(body.lx-lx)+square(body.ly-ly))));
        ay = ay + (body.ly-ly)*body.mass/(cube(sqrt(square(body.lx-lx)+square(body.ly-ly))));
      }
    }
  }
  void collide(Body other) {
    float distance = sqrt(square(other.lx -lx) + square(other.ly -ly));
    if (distance <= radius + other.radius) {
      if (mass >= other.mass) {
        if (mass +other.mass !=0) {
          vx = (vx*mass +other.vx*other.mass)/(mass+other.mass);
          vy = (vy*mass +other.vy*other.mass)/(mass+other.mass);
        }
        mass += other.mass;
        radius = sqrt(mass);
        other.mass =0;
        other.radius =0;
        other.vx =0;
        other.vy=0;
        other.ax =0;
        other.ay =0;
        other.lx =0;
        other.ly =0;
        other.remove =true;
        //other.pathx = {};
        //other.pathy = {};
      } else {
        if (mass +other.mass !=0) {
          other.vx = (vx*mass +other.vx*other.mass)/(mass+other.mass);
          other.vy = (vy*mass +other.vy*other.mass)/(mass+other.mass);
        }
        other.mass = mass +other.mass;
        other.radius = sqrt(other.mass);
        radius = 0;
        mass =0;
        vx = 0;
        vy =0;
        ax=0;
        ay=0;
        lx=0;
        ly=0;
        remove=true;
      }
    }
  }
}

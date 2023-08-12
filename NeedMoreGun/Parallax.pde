

enum Layer {
  BACK,
    MID,
    FRONT
}
class Star implements Drawable {
  Layer layer;
  PVector location, velocity;
  int radius;
  color colour;
  float mod;
  int num;
  Star() {
    location = new PVector((int)random(0, width*1.5), (int)random(0, height*1.5));
    this.velocity = new PVector(0,0);
    num = (int)random(1, 4);
    switch(this.num) {
    case 1:
      this.layer = Layer.BACK;
      this.colour = #AA9D39;
      this.mod = -.4;
      this.radius = 4;
      break;
    case 2:
      this.layer = Layer.MID;
      this.colour = #F2E367;
      this.mod = -.6;
      this.radius = 8;
      break;
    case 3:
      this.layer = Layer.FRONT;
      this.colour = #FFF183;
      this.mod = -.8;
      this.radius = 12;
      break;
    }
  }
    void newPos() { //<>//
      if (battleScreen.myShip != null) {
        this.velocity.x = battleScreen.myShip.velocity.x * this.mod;
        this.velocity.y = battleScreen.myShip.velocity.y * this.mod;
        this.location.x += this.velocity.x;
        this.location.y += this.velocity.y;
      }
    }
  
  void drawStar(float x, float y) {
    for (int i=0; i<this.radius; i++) {
      line(x-this.radius+i, y, x, y-i);
      line(x-this.radius+i, y, x, y+i);
      line(x+this.radius-i, y, x, y-i);
      line(x+this.radius-i, y, x, y+i);
    }
  }

  void draw() {
    newPos();
    stroke(this.colour);
    drawStar(this.location.x, this.location.y);
    println(this.colour);
    println(this.layer);
    println(this.mod);
  }
}

void drawParallax() {
  for (int i=0; i<stars.length; i++) {
    Star star = stars[i];
    star.draw();
  }
}

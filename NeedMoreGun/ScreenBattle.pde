class Ship implements Drawable {
  float eWidth, eHeight;
  PVector location = new PVector(0, 0);
  PVector velocity = new PVector(0, 0);
  int healthPoints;

  Ship(int eWidth, int eHeight) {
    this.eWidth = eWidth;
    this.eHeight = eHeight;
  }
  void genLocation() {
    //to be overwritten
  }
  void newPos() {
    //to be overwritten
  }
  void healthState() {
    //to be overwritten
  }
  void draw() {
    //to be overwritten
  }
}

class Enemy extends Ship {
  Component target;
  Enemy() {
    super(30, 30);
  }
  void genLocation() {//Generates Random location for spawn
    this.location = new PVector(0, 0);
    this.location.x = (int)random(0-eWidth, width+eWidth);
    if (this.location.x>width+eWidth || this.location.x<0-eWidth) {
      this.location.y = (int)random(0, height*75);
    } else {
      this.location.y = 0-this.eHeight;
    }
  }
  void healthState() {
    if (this.healthPoints<=0) {
      money+=5;
    }
  }
  void draw() {
    //if (this.status==Status.ACTIVE) {
    ellipse(this.location.x, this.location.y, this.eWidth, this.eHeight);
    //}
  }
  

  void findTarget(ShipDesign design) {
    this.target = design.components.get(0);
    for (Component component : design.components) {
      if (dist(this.location.x, this.location.y, component.location.x, component.location.y)<dist(this.location.x, this.location.y, target.location.x, target.location.y)) {
        this.target = component;
      }
    }
  }
}



class Ally extends Ship {
  boolean forward, backward, left, right;

  ShipDesign design;
  Ally() {
    super(20, 20);

    this.design = new ShipDesign();
  }

  void genLocation() {
    //to be overwritten
  }
  void healthState() {
    //to be overwritten
  }
  void newPos() {//checks for arrowkeys
    //puts cap on speed
    if (this.velocity.x>=4) {
      this.velocity.x = 4;
    }
    if (this.velocity.x<=-4) {
      this.velocity.x = -4;
    }
    if (this.velocity.y>=4) {
      this.velocity.y = 4;
    }
    if (this.velocity.y<=-4) {
      this.velocity.y = -4;
    }

    //adds speed
    if (((BattleScreen)battleScreen).keys[37]) {//left arrow
      this.velocity.add(-.2, 0);
    }
    if (((BattleScreen)battleScreen).keys[40]) {//up arrow
      this.velocity.add(0, .2);
    }

    if (((BattleScreen)battleScreen).keys[39]) {//right arrow
      this.velocity.add(.2, 0);
    }
    if (((BattleScreen)battleScreen).keys[38]) {//down arrow
      this.velocity.add(0, -.2);
    }
  }
  void wallColision(Component c) {//checks for colisions
    if (c.location.x >= width - c.cWidth/2) {//right wall check
      if (this.velocity.x>0) {
        this.velocity.x=0;
      }
    }
    if (c.location.x <= 0 + c.cWidth/2) {//left wall check
      if (this.velocity.x<0) {
        this.velocity.x=0;
      }
    }

    if (c.location.y >= height - c.cHeight/2) {//bottom wall check
      if (this.velocity.y>0) {
        this.velocity.y=0;
      }
    }
    if (c.location.y <= 0 + c.cHeight/2) {//top wall check
      if (this.velocity.y<0) {
        this.velocity.y=0;
      }
    }
  }
  void draw() {
    newPos();

    for (Drawable component : this.design.components) {
      if (component instanceof Component) {
        Component c = (Component) component;
        c.location.x += this.velocity.x;
        c.location.y += this.velocity.y;
        wallColision(c);
        c.draw();
        
      }
    }
    
    drawParallax();
  }
}

class BattleScreen extends Screen {
  boolean []keys = new boolean[222];//boolean array of keyboard keys
  int seconds, secondsSince, ramp;
  Ally myShip;
  ArrayList<Enemy> enemies = new ArrayList();

  BattleScreen() {

    myShip = new Ally();
    for (int i=0; i<10+waves*waves; ++i) {
      Enemy enemy = new Enemy();
      enemy.genLocation();
      enemies.add(enemy);
    }
  }

  void setShipDesign(ShipDesign design) {
    this.myShip.design = design;
  }

  void show() {
    println("battle is shown");
    seconds = millis()/1000;
    //can move ships here
  }

  void keyPressed() {
    keys[keyCode]=true;
  }
  void keyReleased() {
    keys[keyCode]=false;
  }
  void mouseClicked() {
  }
  void mouseReleased() {
  }
  //void waveBegin() {//determines amount of enemies per wave
  //  float secondsSince=millis()/1000;
  //  int totalEnemies = (int)random(5+waves, 10+waves);
  //  int enemiesPerSecond = totalEnemies/lengthWave;
  //}
  void generate() {//generates enemies
    secondsSince = millis()/1000 - seconds;
      if (secondsSince % 2 ==0) {
      ramp ++;
      for (int i=0; i<ramp; i++) {
        Enemy c = new Enemy();
        c.genLocation();
        this.enemies.add(c);
      }
    }
  }
  void draw() {
    //println("battle");
    background(0);
    super.draw();

    myShip.draw();

    for (Enemy enemy : enemies) {
      enemy.findTarget(battleScreen.myShip.design);
      enemy.draw();
    }
  }
}

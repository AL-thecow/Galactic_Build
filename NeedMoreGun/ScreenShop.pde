class ShopScreen extends Screen {
  ShipDesign currentDesign;
  Component buying;
  boolean bought, canBuy, attempting;

  ShopScreen() {
    currentDesign = battleScreen.myShip.design;
    this.elements.add(new shopButton(width/2, height-175, 150, 150, "Option 3", 200) );
    this.elements.add(new shopButton(width/2-200, height-175, 150, 150, "Option 2", 200) );
    this.elements.add(new shopButton(width/2-400, height-175, 150, 150, "Option 1", 200) );
    this.elements.add(new Button(width/2+200, height-175, 150, 150, "Ready", 200) {
      void click() {
        //println("ready");
        //battleScreen.setShipDesign(currentDesign);
        switchScreen(ScreenType.BATTLE);
      }
    }
    );
  }

  void show() {
    for (Drawable element : this.elements) {
      if (element instanceof shopButton) {
        shopButton c = (shopButton) element;
        c.populate();
      }
    }
  }
  void draw() {
    background(150);
    if (this.buying != null && this.attempting) {
      this.buying.location.x = mouseX;
      this.buying.location.y = mouseY;
      this.buying.draw();
    }
    fill(100);
    rect(0, height*.75, width, height/4);
    super.draw();
    text("wave " + waves, 0, 50);
    text("$" + money, 0, 100);

    for (Drawable component : this.currentDesign.components) {
      if (component instanceof Component) {
        Component c = (Component) component;
        c.draw();
      }
    }
  }

  void payForComponent() {
    if (this.buying != null) {
      money -= this.buying.price;
    }
  }

  
  void mouseReleased() {
    super.mouseReleased();
    if (this.buying != null) {
      if (money<this.buying.price) {
        canBuy = false;
      } else {
        canBuy = true;
      }
      if (this.canBuy && attempting) {
        this.buying.location.x = mouseX;
        this.buying.location.y = mouseY;
        println("bought component");
        payForComponent();
        currentDesign.addComponent(this.buying);
        bought = true;
        this.buying = null;
        this.attempting = false;
      }
    }
  }
}

class shopButton extends Button {
  Component forSale;
  boolean sold = false;
  shopButton(int x, int y, int bWidth, int bHeight, String message, color colour) {
    super(x, y, bWidth, bHeight, message, colour);
  }
  void populate() {
    int random = (int)random(0, 3.9);
    switch(random) {
    case 1:
      this.forSale = new ArmorPierce();
      println("populated with ArmorPierce");
      break;
    case 2:
      this.forSale = new Machinegun();
      println("populated with Machinegun");
      break;
    case 3:
      this.forSale = new Hull();
      println("populated with Hull");
      break;
    }
    if (this.forSale != null) {
      println(this.forSale);
      this.message = "$" + this.forSale.price;
    }
  }

  void click() {
    println("clicked");
    shopScreen.buying = this.forSale.clone();
    shopScreen.attempting = true;
    this.sold = true;
  }

  void draw() {
    super.draw();
    if (this.forSale == null) {
      populate();
    }
    if (this.forSale != null && this.forSale.location != null) {
      this.forSale.location.x = this.x + 50;
      this.forSale.location.y = this.y + 50;
      this.forSale.draw();
    }
    if (this.sold && shopScreen.bought) {
      populate();
      shopScreen.bought = false;
      this.sold = false;
    }
  }
}

class ShipDesign {
  ArrayList<Component> components = new ArrayList<Component>();
  ShipDesign() {
    this.components.add(new Cockpit());
    this.components.get(0).location.x = width/2-25;
    this.components.get(0).location.y = height/2-100;
  }
  //turrents, shields etc.
  void addComponent(Component c) {
    components.add(c);
  }
}

abstract class Component implements Drawable {
  int price;
  int cWidth, cHeight;
  PVector location;
  Enemy target;
  color colour;
  Component() {
    location = new PVector(0, 0);
    this.cWidth = 20;
    this.cHeight = 20;
    //this.location.x=x;
    //this.location.y=y;
  }
  void findTarget(BattleScreen battleScreen) {
    if (currentScreen==battleScreen) {
      this.target = battleScreen.enemies.get(0);
      for (Enemy enemy : battleScreen.enemies) {
        if (dist(this.location.x, this.location.y, enemy.location.x, enemy.location.y) < dist(this.location.x, this.location.y, this.target.location.x, this.target.location.y)) {
          this.target = enemy;
        }
      }
    }
  }
  void draw() {
  }

  Component copyTo(Component c) {
    c.price = this.price;
    c.cWidth =  this.cWidth;
    c.cHeight = this.cHeight;
    c.location = new PVector(0,0); //do not copy location
    c.target = null; //do not copy enemy
    c.colour = this.colour;
    return c;
  }

  abstract Component clone();
}

class Hull extends Component {

  Hull() {
    super();
    this.price = (int)random(5, 10)*waves/2;
    this.colour = #00C5FF;
  }
  void draw() {

    fill(this.colour);
    rect(this.location.x-cWidth/2, this.location.y-cHeight/2, cWidth, cHeight);
  }

  Component clone() {
    Hull cp = new Hull();
    this.copyTo(cp);
    return cp;
  }
}


class Machinegun extends Component {

  Machinegun() {
    super();
    this.price = (int)random(5, 10)*waves/2;
    this.colour = #FAE600;
  }
  void draw() {
    //print(" content drawn at ", this.location.x, this.location.y, this.cWidth, this.cHeight);
    fill(this.colour);
    rect(this.location.x-this.cWidth/2, this.location.y-this.cHeight/2, this.cWidth, this.cHeight);
  }

  Component clone() {
    Machinegun mg = new Machinegun();
    this.copyTo(mg);
    return mg;
  }
}


class ArmorPierce extends Component {

  ArmorPierce() {
    super();
    this.price = (int)random(5, 10)*waves/2;
    println(this.price);
    this.colour = #B200FA;
    
  }

  Component clone() {
    ArmorPierce ap = new ArmorPierce();
    this.copyTo(ap);
    return ap;
  }

  void draw() {

    fill(this.colour);
    rect(this.location.x-this.cWidth/2, this.location.y-this.cHeight/2, this.cWidth, this.cHeight);
  }
  
  void shoot(){
    
  }
}

class Cockpit extends Component {

  Cockpit() {
    super();
    this.colour = #FA0303;
  }
  void draw() {

    fill(this.colour);
    rect(this.location.x-this.cWidth/2, this.location.y-this.cHeight, this.cWidth, this.cHeight);
  }

  Component clone() {
    Cockpit cp = new Cockpit();
    this.copyTo(cp);
    return cp;
  }
}

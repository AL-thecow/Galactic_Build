enum ScreenType {
  START,
    SHOP,
    BATTLE
};

class Screen {
  ArrayList<Drawable> elements = new ArrayList<Drawable>();

  void show() {
    println("screen was shown");
  }

  void hide() {
    println("screen was hidden");
  }

  void keyPressed() {
    //nothing by default
  }
  void keyReleased() {
    //nothing by default
  }
  void mouseClicked() {
        for (Drawable element : this.elements) {
      if (element instanceof Clickable) {
        Clickable c = (Clickable) element;
        if (c.mouseOver()) {
          c.click();
        }
      }
    }
  }
  void mouseReleased() {

  }

  void draw() {
    for (Drawable element : this.elements) {
      element.draw();
    }
  }
}

enum Life {
  ALIVE, DEAD
};

interface Drawable {
  void draw();
}

interface Clickable extends Drawable {
  boolean mouseOver();
  void click();
}

class Button implements Clickable {
  int x, y, bWidth, bHeight;
  String message;
  color colour;
  int outlineColour = 0;
  int outlineWeight = 4;
  

  Button(int x, int y, int bWidth, int bHeight, String message, color colour) {
    this.x = x;
    this.y = y;
    this.bWidth = bWidth;
    this.bHeight = bHeight;
    this.message = message;
    this.colour = colour;
  }

  boolean mouseOver() {//checks if mouse is over button
    if (mouseX>=this.x  && mouseX<this.x + this.bWidth && mouseY>this.y && mouseY<this.y+this.bHeight) {
      this.colour = 150;
      return true;
    } else {
      return false;
    }
  }

  void click() {
    //does nothing - must override
  }

  void draw() {
    if(!mouseOver()){
      this.colour = 200;
    }
    fill(this.colour);
    rect(this.x, this.y, bWidth, bHeight);
    textSize(32);
    fill(textColor);
    text(this.message, this.x, this.y + this.bHeight - 20);

  }
}

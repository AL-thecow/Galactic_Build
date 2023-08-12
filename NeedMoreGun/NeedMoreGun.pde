//this project is poorly documented due to time constraints, unfortunately. pushMatrix and popMatrix are not applicable for relocating entities so a normal vector movement system was used.
//And lots of functionality is missing aswell
//wave combat doesnt work, but at least the shopping system functions


//ArrayList<Entity> allyScreenElements = new ArrayList<Entity>();

Star[] stars = new Star[90];
Screen currentScreen;
StartScreen startScreen;
BattleScreen battleScreen;
ShopScreen shopScreen;

void switchScreen(ScreenType scrType) {
  println("switching to ", scrType.name());
  if(currentScreen != null){
    currentScreen.hide();
  }
  
  switch(scrType) {
  case START:
    currentScreen = startScreen;
    break;
  case BATTLE:
    currentScreen = battleScreen;
    break;
  case SHOP:
    currentScreen = shopScreen;
    break;
  }
  currentScreen.show();
  println(currentScreen);
}

void setup() {
  //fullScreen();
  size(1280,780);

  startScreen = new StartScreen();
  battleScreen = new BattleScreen();
  shopScreen = new ShopScreen();
  switchScreen(ScreenType.START);
  for(int i=0; i<stars.length;i++){
   stars[i] = new Star();
}
}

void keyPressed() {
  currentScreen.keyPressed();
  //println(keyCode);
  //keys[keyCode]=true;
}

void keyReleased() {
  currentScreen.keyReleased();
  //keys[keyCode]=false;
}

void mouseClicked() {
  currentScreen.mouseClicked();
}

void mouseReleased() {
  currentScreen.mouseReleased();

  //for (Drawable element : shopScreenElements) {
  //  if (element instanceof Clickable) {
  //    Clickable c = (Clickable) element;
  //    if (c.mouseOver()) {
  //      c.click();
  //    }
  //  }
  //}

  //Enemy enemy = enemies.get(7);
  //if(enemy.isHit()){
  //  enemy.dropHealth(10);
  //  if (enemy.isDead()){
  //    enemies.remove(enemy)
  //  }
  //}
}

void draw() {
  currentScreen.draw();
  //background(150);
  //ellipse(150, 150, 50, 50);
  //startScreen();

  //battleScreen();
}

void someMethod() {
  //something
  System.out.println("something clicked");
}

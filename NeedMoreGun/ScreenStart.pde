class StartScreen extends Screen {
  StartScreen() {
    this.elements.add(new Button(100, 10, 60, 20, "Exit", 200) {
      void click() {
        println("Exit");
        System.exit(0);
      }
    }
    );

    this.elements.add(new Button(100, 40, 60, 20, "Battle", 200) {
      void click() {
        //do something
        println("Battle");
        switchScreen(ScreenType.BATTLE);
      }
    }
    );

    this.elements.add(new Button(width/2 - 100, height/2-100, 200, 60, "Start Game", 200) {
      void click() {
        println("Shop");
        switchScreen(ScreenType.SHOP);
      }
    }
    );
  }

  void draw() {
    background(100);
    super.draw();
  }
}

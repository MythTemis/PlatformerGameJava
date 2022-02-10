Sprite p;

void setup(){
  size(1400, 750);
  p = new Sprite("data/taffyta.png", 1.0);
  p.change_x = 5;
  
}

void draw(){
  background(255);
  p.display();
  p.update();
}

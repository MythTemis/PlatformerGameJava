final static float MOVE_SPEED = 4;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;
final static float GRAVITY = .6;
final static float JUMP_SPEED = 14;

//global variables
Sprite p;
PImage bckgrd, collision_tester;
ArrayList<Sprite> platforms;
void setup(){
  
  size(3584, 240);
  imageMode(CENTER);
  p = new Sprite("data/taffyta.png", 1.0);
  p.change_x = 0;
  p.change_y = 0;
  platforms = new ArrayList<Sprite>();
  collision_tester = loadImage("data/astrocat_grey.png");
  
}

void draw(){
  // To set the background you have to 1) make sure that the game window is the same
  // size as the image and 2) that the image is a png
  PImage bgrdP;
  bgrdP = loadImage("data/marioRippoff.png");
  background(bgrdP);
  p.display();
  resolvePlatformCollisions(p, platforms);
  
  for(Sprite s: platforms) 
  s.display();
}

public void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls){
  //Gravity
  s.change_y += GRAVITY;
  
  //Y check
  s.center_y += s.change_y;
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  
  if(col_list.size() > 0) {
    Sprite collided = col_list.get(0);
    if(s.change_y > 0){
      s.setBottom(collided.getTop());
    }
    else if(s.change_y < 0){
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
}

  s.center_x += s.change_x;
  col_list = checkCollisionList(s, walls);
  
  if(col_list.size() > 0) {
    Sprite collided = col_list.get(0);
    if(s.change_x > 0){
      s.setRight(collided.getLeft());
    }
    else if(s.change_x < 0){
      s.setLeft(collided.getRight());
    }
    s.change_x = 0;
  }
}

boolean checkCollision(Sprite s1, Sprite s2) {
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  
  if (noXOverlap || noYOverlap) {
    return false;
  } else {
    return true;
  }
}

public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list) {
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for (Sprite p: list) {
    if(checkCollision(s, p))
    collision_list.add(p);
  }
  return collision_list;
}

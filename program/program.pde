import processing.sound.*;

final static float MOVE_SPEED = 4;
final static float SPRITE_SCALE = 50.0/128;
final static float SPRITE_SIZE = 50;
final static float GRAVITY = 1;
final static float JUMP_SPEED = 14;
final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;

//global variables
Sprite p;
PImage bckgrd, collision_tester;
ArrayList<Sprite> platforms;
float view_x = 0;
float view_y = 0;
SoundFile file;
void setup(){
  
  size(3584, 240);
  imageMode(CENTER);
  p = new Sprite("data/taffyta.png", 0.4);
  p.change_x = 0;
  p.change_y = 0;
  platforms = new ArrayList<Sprite>();
  
  file = new SoundFile(this, "data/sugarrushWAV.wav");
  file.play();
  file.amp(.5);
  //collision_tester = loadImage("data/test.png");
  //Sprite ct = new Sprite("data/test.png", 1);
  //platforms.add(ct);
  
  
}

void draw(){
  // To set the background you have to 1) make sure that the game window is the same
  // size as the image and 2) that the image is a png
  scroll();
  p.update();
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
  float spriteHitBoxX = p.center_x;
  float spriteHitBoxY = p.center_y;
  float spriteHitBoxW = p.w;
  float spriteHitBoxH = p.h;
  float groundHitBoxX = 0;
  float groundHitBoxY = 205;
  float groundHitBoxW = 1100;
  float groundHitBoxH = 25;
  float groundHitBoxX2 = 1135;
  float groundHitBoxY2 = 205;
  float groundHitBoxW2 = 240;
  float groundHitBoxH2 = 25;
  float boxHitBoxX = 255;
  float boxHitBoxY = 143;
  float boxHitBoxW = 15;
  float boxHitBoxH = 15;
  float boxHitBoxX2 = 318;
  float boxHitBoxY2 = 143;
  float boxHitBoxW2 = 80;
  float boxHitBoxH2 = 15;
  //rect(255, 143, 15, 15);
  //rect(318, 143, 80, 15);
  //rect(1135, 205, 240, 25);
  //rect(0,205, 1100, 25);
  if (spriteHitBoxX < groundHitBoxX + groundHitBoxW &&
    spriteHitBoxX + spriteHitBoxW > groundHitBoxX &&
    spriteHitBoxY < groundHitBoxY + groundHitBoxH &&
    spriteHitBoxH + spriteHitBoxY > groundHitBoxY) {
    //colliding!
    fill(255, 0, 0);
    s.change_y = 0;
    //GRAVITY = 0;
  } else if (spriteHitBoxX < groundHitBoxX2 + groundHitBoxW2 &&
    spriteHitBoxX + spriteHitBoxW > groundHitBoxX2 &&
    spriteHitBoxY < groundHitBoxY2 + groundHitBoxH2 &&
    spriteHitBoxH + spriteHitBoxY > groundHitBoxY2) {
      s.change_y = 0;
    } else if (spriteHitBoxX < boxHitBoxX + boxHitBoxW &&
    spriteHitBoxX + spriteHitBoxW > boxHitBoxX &&
    spriteHitBoxY < boxHitBoxY + boxHitBoxH &&
    spriteHitBoxH + spriteHitBoxY > boxHitBoxY) {
      s.change_y = 0;
      s.change_x = 0;
    }else if (spriteHitBoxX < boxHitBoxX2 + boxHitBoxW2 &&
    spriteHitBoxX + spriteHitBoxW > boxHitBoxX2 &&
    spriteHitBoxY < boxHitBoxY2 + boxHitBoxH2 &&
    spriteHitBoxH + spriteHitBoxY > boxHitBoxY2) {
      s.change_y = 0;
      s.change_x = 0;
    }
    else {
    //not colliding!
    fill(0, 255, 0);
    s.change_y += GRAVITY;
  }
 rect(spriteHitBoxX, spriteHitBoxY, spriteHitBoxW, spriteHitBoxH);
    //rect(groundHitBoxX, groundHitBoxY, groundHitBoxW, groundHitBoxH);
  //s.change_y += GRAVITY;
  
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

void scroll() {
  float right_boundary = view_x + width - RIGHT_MARGIN;
  if(p.getRight() > right_boundary){ view_x -= p.getRight() - right_boundary; }
  float left_boundary = view_x + LEFT_MARGIN;
  if(p.getLeft() < left_boundary){ view_x -= left_boundary - p.getLeft(); }
  float bottom_boundary = view_y + height - VERTICAL_MARGIN;
  if (p.getBottom() > bottom_boundary) { view_y += p.getBottom() - bottom_boundary;}
  float top_boundary = view_y + VERTICAL_MARGIN;
  if(p.getTop() < top_boundary){view_y -= top_boundary - p.getTop();}
  translate(-view_x, -view_y);
}

 public class Sprite{
  PImage img;
float center_x, center_y;
float change_x, change_y;
float w, h;
 

public Sprite(String filename, float scale, float x, float y){
 
  img = loadImage(filename);
  w = img.width * scale;
  h = img.height * scale;
  center_x = x;
  center_y = y;
  change_x = 0;
  change_y = 0;
  
}

public Sprite(String filename, float scale){
  this(filename, scale, 0, 0);
 // img.width = 50;
 // img.height = 50;
}
public void display(){
  image(img, center_x, center_y);
}
public void update(){
//center_x += change_x;
//center_y += change_y;
movePlayer();
}
void movePlayer(){
  if (key == 'w' || key == 'W') {
    center_y += -13;}
   if (key == 'd' || key == 'D') {
    center_x += 10;}
   if (key == 's' || key == 'S') {
    center_y += 0;
    center_x +=0;}
   if (key == 'a' || key == 'A') {
    center_x += -10;}
}

void setLeft(float left){
  center_x = left + w/2;
}

float getLeft(){
return center_x - w/2;
}

void setRight(float right){
  center_x = right - w/2;
}

float getRight(){
  return center_x + w/2;
}

void setTop(float top){
  center_y = top + h/2;
}

float getTop(){
  return center_y - h/2;
}

void setBottom(float bottom){
  center_y = bottom - h/2;
}

float getBottom(){
  return center_y + h/2;
}

 }

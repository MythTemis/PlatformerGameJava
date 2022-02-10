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
    center_y += -10;}
   if (key == 'd' || key == 'D') {
    center_x += 10;}
   if (key == 's' || key == 'S') {
    center_y += 10;}
   if (key == 'a' || key == 'A') {
    center_x += -10;}
}
}

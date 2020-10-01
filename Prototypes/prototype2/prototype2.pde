
ArrayList<Plus> plus = new ArrayList<Plus>();
PImage img;
void setup() {
  
  size(1000, 800);

  img = loadImage("data/logo.png");

  int spacer = 80;

  int wideCount = ceil(width/spacer);
  int heightCount = ceil(height/spacer);

  //color plusCol = color(255, 200, 200);
  color plusCol = color(255, 255, 255);

  for (int h = 0; h<heightCount; h++) {
    for (int w = 0; w<wideCount; w++) {
   ///   if (ceil(random(0, 3))==1) {
        if (h%2==1) {
          plus.add(new Plus(spacer*w, spacer*h, plusCol));
        } else {
          plus.add(new Plus(spacer*w+spacer/2, spacer*h, plusCol));
      //  }
      }
    }
  }
}

void draw() {
  background(225, 0, 0);
    for (int i = 0; i<plus.size(); i++) {
    plus.get(i).update();
  }
  imageMode(CENTER);
  blendMode(LIGHTEST);
  image(img,width/2, height/2);
      blendMode(NORMAL);

}

class Plus {
  float ypos, 
    xpos, 
    r, 
    growth; 
    float seed ;

   
  float theta = 0.0;
  float alpha = 50;
  color fill; //color
  float strokeWidth = 6;
  float rBase = 15;

  int range = 80;
  int hoverVal = 0;
  
  boolean visited = false;
  boolean triggered = false;
  
  
  float sinkAmount;


  Plus(float x, float y, color c) {
    ypos = y;
    xpos = x;
    fill = c;
    r = rBase;
    growth = 14;
    alpha = random(30,155);
    seed = random(-10);
    sinkAmount = (random(.5,2));
  }
  void update() {
    theta += 0.01;
    noStroke();
    //stroke(255,255,255,alpha);
    show();
    sink();

  }
  void sink(){
    ypos=ypos+sinkAmount;
    if(ypos>height+r){
     ypos = 0-2*r; 
    }
  }
  
 void show(){
   
   if (dist(mouseX, mouseY, xpos, ypos)<range) {
     
      if(!triggered ){
      triggered = true;
      hoverVal = 200;
      }
    } else {
      //r = r-.2;
      //visited = false; //unvisit
    }
    
    if(triggered == true){
      //
           hoverVal -=5;
           if(hoverVal==0){
             triggered = false;
           }
    }

   float limit=70; //highest white value
   float a = (cos((seed+theta)) *limit) + hoverVal;
   
    fill(225,a,a);
    rectMode(CENTER);
    //blendMode(LIGHTEST);
    rect(xpos,ypos, strokeWidth, r*2);
    rect(xpos,ypos, r*2, strokeWidth);
    
 }
//ease in, ease out.
  void grow() {
    if (dist(mouseX, mouseY, xpos, ypos)<range) {
      if(!visited){
      r = rBase + growth;
      visited = true;
      }else{
      r = r-.2;
      }
    } else {
      r = r-.2;
      visited = false;
    }
        if(r>2){
    //fill(fill+20);
    rectMode(CENTER);
    rect(xpos,ypos, strokeWidth, r*2);
    rect(xpos,ypos, r*2, strokeWidth);
        }
  }
}

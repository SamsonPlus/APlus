
ArrayList<Plus> plus = new ArrayList<Plus>();
PImage img;
void setup() {
  
  size(1000, 800);

  img = loadImage("data/logo.png");

  int spacer = 40;

  int wideCount = ceil(width/spacer);
  int heightCount = ceil(height/spacer);

  //color plusCol = color(255, 200, 200);
  color plusCol = color(255, 255, 255);

  for (int h = 0; h<heightCount; h++) {
    for (int w = 0; w<wideCount; w++) {
      if (ceil(random(0, 6))==1) {
        if (h%2==1) {
          plus.add(new Plus(spacer*w, spacer*h, plusCol));
        } else {
          plus.add(new Plus(spacer*w+spacer/2, spacer*h, plusCol));
        }
      }
    }
  }
}

void draw() {
  background(225, 0, 0);
  
  imageMode(CENTER);
  image(img,width/2, height/2);
    
  for (int i = 0; i<plus.size(); i++) {
    plus.get(i).update();
  }
}

class Plus {
  float ypos, 
    xpos, 
    r, 
    growth; 

  color fill; //color
  float strokeWidth = 4;
  float rBase = 0;

  int range = 80;
  
  boolean visited = false;


  Plus(float x, float y, color c) {
    ypos = y;
    xpos = x;
    fill = c;
    r = rBase;
    growth = 14;
  }
  void update() {
   // strokeWeight(strokeWidth);
    stroke(fill);
    grow();
    if(r>2){
     strokeCap(SQUARE);
    //line((xpos-r), ypos, (xpos+r+1), ypos); //horizontal line
   // line(xpos, (ypos-r), xpos, (ypos+r+1)); //vertical line
    
    fill(fill);
    rectMode(CENTER);
    rect(xpos,ypos, strokeWidth, r*2);
    rect(xpos,ypos, r*2, strokeWidth);
    }
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

  }
}

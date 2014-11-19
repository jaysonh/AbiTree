boolean useLeafFade = true;

int NUM_LEAF_IMAGES = 28;
PImage [] leafImgs = new PImage[NUM_LEAF_IMAGES];
PImage refImg;


int numLeavesX,numLeavesY;

Leaf [][]leaves;

int leafSeperation = 30;

int NUM_LEAF_COLOURS = 13;
color []leafColors = { color(226,235,167), 
                       color(231,233,121), 
                       color(171,213,145), 
                       color(160,206,94), 
                       color(127,197,97), 
                       color(139,192,139), 
                       color(89,188,113), 
                       color(101,168,78), 
                       color(116,160,102), 
                       color(116,160,102), 
                       color(90,137,96), 
                       color(67,108,61), 
                       color(41,80,43)};
                       
float windSpeed = 0.0f;
                       
void setup()
{
  size(1024,768,OPENGL);
  refImg = loadImage("tree-example-page-001-rotated.jpg");
  
  
  for(int i = 0; i < NUM_LEAF_IMAGES;i++)
  {
     int indx = i +19;
     leafImgs[i] = loadImage("data/final-leaves_" +indx + ".png"); 
  }
  imageMode(CORNER);
  
  numLeavesX = width / leafSeperation +1;
  numLeavesY = height/ leafSeperation +1;
  
  leaves = new Leaf[numLeavesY][numLeavesX];
 
  for(int y = 0; y < numLeavesY;y++)
  {
    leaves[y] = new Leaf[numLeavesX];
    
    
    for(int x =0; x < numLeavesX;x++)
    {
      int imgPixelIndx = (y * leafSeperation) * refImg.width + x*leafSeperation;
      color c =  refImg.pixels[imgPixelIndx];
      leaves[y][x]=new Leaf();
      if(!(y*leafSeperation >238 && x*leafSeperation > 460))
          leaves[y][x].draw=true;
        else if(random(0,100) < 6)
          leaves[y][x].draw=true;
        else
          leaves[y][x].draw=false;
        
      
         }
  }
  
  frameRate(25.0);
}

void draw()
{
  frame.setTitle("FPS: " + frameRate);
  background(0);
  noTint();
  image(refImg,0,0,width,height);
  for(int y = leafSeperation; y < height-leafSeperation; y+= leafSeperation)
  {
     for(int x = leafSeperation; x < width-leafSeperation; x+=leafSeperation)
     {
        color c = refImg.pixels[y * width + x];
        
            int xIndx = x / leafSeperation;
            int yIndx = y / leafSeperation;
       
         
          leaves[yIndx][xIndx].draw(x,y);
          
          
     } 
  }
  
  //drawBorder();
  float mouseMoveDist = dist(pmouseX,pmouseY,mouseX,mouseY);
  if(mouseMoveDist > 0.0f)
  {
    windSpeed += 0.025f;
    if(windSpeed > 1.0f) windSpeed = 1.0f;
  }else
    windSpeed *= 0.75f;
}

void drawBorder()
{
  noStroke();
  fill(255);
  rect(0,0,19,height);  
  rect(width-19,0,19,height);
  rect(0,0,width,19);
  rect(0,height-19,width,19);
}

void mousePressed()
{
  println(mouseX + " " + mouseY);
}

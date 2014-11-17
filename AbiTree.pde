int NUM_LEAF_IMAGES = 28;
PImage [] leafImgs = new PImage[NUM_LEAF_IMAGES];
PImage refImg;

float LEAF_RAND_OFF = 10.0f;
float LEAF_RAND_VEL = 0.2f;

int numLeavesX,numLeavesY;

int [][] leafIndx;
float [][] leafAngle;
PVector [][]leafOff;
PVector [][]leafVel;
void setup()
{
  size(1024,768);
  refImg = loadImage("tree-example-page-001-rotated.jpg");
  
  
  for(int i = 0; i < NUM_LEAF_IMAGES;i++)
  {
     int indx = i +19;
     leafImgs[i] = loadImage("data/final-leaves_" +indx + ".png"); 
  }
  imageMode(CENTER);
  
  numLeavesX = width / 20 +1;
  numLeavesY = height/ 20 + 1;
  
  leafOff = new PVector[numLeavesY][numLeavesX];
  leafVel = new PVector[numLeavesY][numLeavesX];
  leafAngle = new float[numLeavesY][numLeavesX];
  leafIndx = new int[numLeavesY][numLeavesX];
  for(int y = 0; y < numLeavesY;y++)
  {
    leafOff[y] = new PVector[numLeavesX];
    leafIndx[y] = new int[numLeavesX];
    for(int x =0; x < numLeavesX;x++)
    {
      leafIndx[y][x] = (int)random(0,NUM_LEAF_IMAGES);
      leafAngle[y][x] = random(0,TWO_PI);
      leafVel[y][x] = new PVector(random(-LEAF_RAND_VEL,LEAF_RAND_VEL),random(-LEAF_RAND_VEL,LEAF_RAND_VEL));
      leafOff[y][x] = new PVector(random(-LEAF_RAND_OFF,LEAF_RAND_OFF),random(-LEAF_RAND_OFF,LEAF_RAND_OFF));
    }
  }
  //noLoop();
}

void draw()
{
  background(0);
  image(refImg,width/2,height/2,width,height);
  for(int y = 0; y < height; y+= 20)
  {
     for(int x = 0; x < width; x+=20)
     {
        color c = refImg.pixels[y * width + x];
        
        float col =( red(c) + green(c) + blue(c))/3.0;
        if(col <240)
        {
          if(!(y>238 && x > 460))
          {
            int xIndx = x / 20;
            int yIndx = y / 20;
              pushMatrix();
      
              tint(red(c),green(c),blue(c));
              translate(x +leafOff[yIndx][xIndx].x, y + leafOff[yIndx][xIndx].y);
             
             leafOff[yIndx][xIndx].x += leafOff[yIndx][xIndx].x;
             leafOff[yIndx][xIndx].y += leafOff[yIndx][xIndx].y;
             
             if(dist(0,0,leafOff[yIndx][xIndx].x,leafOff[yIndx][xIndx].y) > 25.0f)
             {
               leafOff[yIndx][xIndx] = new PVector(0.0f,0.0f); 
               leafVel[yIndx][xIndx] = new PVector(random(-LEAF_RAND_VEL,LEAF_RAND_VEL),random(-LEAF_RAND_VEL,LEAF_RAND_VEL));
    
             }
              rotate(leafAngle[yIndx][xIndx]);
              image(leafImgs[leafIndx[yIndx][xIndx]],0,0);
              popMatrix();
          }
        }
     } 
  }
}

void mousePressed()
{
  println(mouseX + " " + mouseY);
}

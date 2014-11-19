float MAX_ROTATE_SPEED = 0.25f;
float MIN_ROTATE_SPEED = 0.1f;
float MAX_ROTATE_DIST = PI/2;
float MIN_ROTATE_DIST = 0.0f;

float MIN_SHIMMER_SPEED = 0.001f;
float MAX_SHIMMER_SPEED = 0.005f;

float LEAF_RAND_OFF = 10.0f;

class Leaf
{
float offAmt;
  float shimmerVal;
  float shimmerSpeed;
   boolean draw;
   
int leafIndx;
float leafAngle;
PVector leafOff;
color leafCols; 

float rotateAmt=0.0f;
float maxRotate;
float rotateSpeed;
PVector rotationCentre;
  Leaf()
  {
    offAmt=0.0f;
    leafIndx = (int)random(0,NUM_LEAF_IMAGES);
    shimmerVal = 1.0f;
    shimmerSpeed = random(MIN_SHIMMER_SPEED,MAX_SHIMMER_SPEED);
    
    
    rotateSpeed = random(MIN_ROTATE_SPEED, MAX_ROTATE_SPEED);
    maxRotate = random(MIN_ROTATE_DIST,MAX_ROTATE_DIST);
    draw=false;
    rotationCentre = new PVector(random(0,leafImgs[leafIndx].width),random(0,leafImgs[leafIndx].height));
    
        draw=true;
      leafCols=leafColors[(int)random(0,NUM_LEAF_COLOURS)];
      leafAngle = random(0,TWO_PI);
      leafOff = new PVector(random(-1.5*LEAF_RAND_OFF,LEAF_RAND_OFF*1.5),random(-1.5*LEAF_RAND_OFF,LEAF_RAND_OFF*1.5));
 
  }
  
void draw(int x, int y)
{
 if(draw)
 {
   shimmerVal -= shimmerSpeed*windSpeed;
   if(shimmerVal < 0.0f)
   {
      shimmerVal = 1.0f;
    shimmerSpeed = random(MIN_SHIMMER_SPEED,MAX_SHIMMER_SPEED);
     leafCols = leafColors[(int)random(0,NUM_LEAF_COLOURS)];
      
   }
              pushMatrix();
      
      if(useLeafFade)
      {
              tint(leafCols,100+155*windSpeed);
      }else
        tint(leafCols);
              translate(x +leafOff.x *sin(offAmt), y + leafOff.y *sin(offAmt));
             
              offAmt += 0.1f*windSpeed; 
              rotate(maxRotate * sin(rotateAmt));
              rotateAmt+= rotateSpeed * windSpeed;
             
              image(leafImgs[leafIndx],-rotationCentre.x,-rotationCentre.y);
              popMatrix();
 } 
}
}

int cols, rows;
int scl = 25;
int h = 1800;
int w = 1800;
float [][] terreno;

float rotacionX = 1.5;
float rotacionY = 0;
float rotacionZ = 0;

float flying = 0;

float tierra = -100;
float hielo = 100;

void setup(){
  size(600,600,P3D);
  
  cols = w/scl;
  rows = h/scl;
  
  terreno = new float [cols][rows];
  float yoff = 0;
  for(int y = 0; y < rows; y++){
    float xoff = 0;
    for(int x = 0; x < cols; x++){
      terreno[x][y] = map( noise(xoff,yoff), 0 , 1, -100, 500 );
      xoff += 0.2;  
    }
    yoff += 0.2; 
  }
  
}

void draw(){
  background(135,206,235);
  
  moverCamara();
  DibujarTerreno();
  Avion();
}

void DibujarTerreno(){
  
  for(int y = 1; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for(int x = 1; x < cols-1; x++){
      if((terreno[x][y]+terreno[x][y+1])/2 < -80){
        fill(0,255,0);
      }else if((terreno[x][y]+terreno[x][y+1])/2 < -60){
        fill(0,200,0);
      }else if((terreno[x][y]+terreno[x][y+1])/2 < -40)
      {
        fill(0,150,0);
      }else if((terreno[x][y]+terreno[x][y+1])/2 < -20){
        fill(0,100,0);
      }else if((terreno[x][y]+terreno[x][y+1])/2 < 10){
        fill(50,50,50);
      }else if((terreno[x][y]+terreno[x][y+1])/2 < 20){
        fill(176,196,222);
      }else{
        fill(255,255,255);
      }
      vertex(x*scl, y*scl, terreno[x][y]);
      vertex(x*scl, (y+1)*scl, terreno[x][y+1]);
    }
    endShape();
  }
}

void moverCamara(){
  if(keyPressed)
  {
    if(key=='w' || key=='W')
    {
      rotacionX +=0.01;
    }
    if(key=='s' || key=='s')
    {
      rotacionX-=0.01;
    }
    if(key == 'q' || key=='Q')
    {
      rotacionY += 0.01;
    }
    if(key == 'e' || key=='E')
    {
      rotacionY -= 0.01;
    }
    if(key == 'd' || key=='D')
    {
      rotacionZ -= 0.01;
    }
    if(key == 'a' || key == 'A')
    {
      rotacionZ += 0.01;
    }
    if(keyCode == 38)
    {
      flying -= 0.1;
    }
    if(keyCode == 40)
    {
      flying += 0.1;
    }
  }
  
  
  translate(width*0.5,height*0.5);
  rotateX(rotacionX);
  rotateY(rotacionY);
  rotateZ(rotacionZ);
  translate(-w*0.5,-h*0.5);
}

void Avion(){
  float yoff = flying;
  for(int y = 0; y < rows; y++){
    float xoff = 0;
    for(int x = 0; x < cols; x++){
      terreno[x][y] = map( noise(xoff,yoff), 0 , 1, -150, 150 );
      xoff += 0.2;  
    }
    yoff += 0.2; 
  }
    
}

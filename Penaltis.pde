//Variables

double fCentroPelotaY = 150.0f;
double fCentroPelotaZ = 0.0f;

void setup(){

size(1024, 600, P3D);
background(0);
stroke(255);

}

void draw(){
  
  background(0);
  noFill();
  translate(512, 300, 200);
  
  //Pelota
  pushMatrix();
    translate(0, (int)fCentroPelotaY, (int)fCentroPelotaZ);
    sphere(10);
  popMatrix();
  
  //Dibujamos porteria
  pushMatrix();
    translate(-150, -180, -150);
    line(0, 0, 0, 0, -70, 0);
    translate(0, -70, 0);
    line(0, 0, 0, 300, 0, 0);
    translate(300, 0, 0);
    line(0, 0, 0, 0, 70, 0);
  popMatrix();
  
  if(fCentroPelotaZ > -150){fCentroPelotaY -= 1.0; fCentroPelotaZ -= 0.42857143;} 
   println("Y = " + fCentroPelotaY + "Z = " + fCentroPelotaZ);
}
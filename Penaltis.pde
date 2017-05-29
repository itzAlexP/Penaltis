//Variables

double fCentroPelotaY = 150.0f;
double fCentroPelotaZ = 0.0f;

void setup(){

size(1024, 600, P3D);
background(0);
stroke(255);

}

void draw(){
  
  //Limpiamos la pantalla
  background(0);
  noFill();
 
  //Calculamos la posicion del portero
  //Comprobamos si la pelota esta en movimiento y en caso de estarlo calculamos posicion de la pelota 
  
  //Dibujamos todos los elementos, la curva unicamente si el usuario esta calculando donde disparar el balon
  
  //Comprobamos si hay colision entre el portero y la pelota
  
  //Modificamos el contador de puntos
 
   //Campo
    pintarCampo();
   
   stroke(255);
   translate(512, 300, 200);
   //Pelota
  pushMatrix();
    translate(0, (int)fCentroPelotaY, (int)fCentroPelotaZ);
    sphere(10);
  popMatrix();
  stroke(0);
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

//Comprobamos si el usuario esta pulsando el boton para empezar a dibujar la trayectoria de la pelota, almacenamos la posicion inicial de donde hace click
void mousePressed(){



}

//Utilizando el punto inicial donde hizo click y la posicion donde se encuentra el raton calculamos todos los puntos de la curva
void mouseDragged(){


}

//A la que soltemos el boton del raton se iniciara el lanzamiento del balon hacia la porteria
void mouseReleased(){



}

//Esta funcion pinta una linea de punta a punta de la pantalla por cada pixel de las y de acuerdo al color que le corresponde.
void pintarCampo(){
  
   for(int i = 0; i < height; i ++){
     if(i <= 100)stroke(150, 155, 150);
     else if(i <= 200)stroke(80, 160, 30);
     else if(i <= 300)stroke(120, 250, 40);
     else if(i <= 400)stroke(80, 160, 30);
     else if(i <= 500)stroke(120, 250, 40);
     else if(i <= 600)stroke(80, 160, 30);
     line(0, i, 0, width, i, 0);
   }
}
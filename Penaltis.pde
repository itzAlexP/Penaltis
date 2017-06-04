int iFaseJuego = 0, iGoles = 0, iVidas = 3, iVelocidadPortero = 8;
float fPosicionXPortero = 480, fPosicionYPortero = 150, fPosicionXPelota = 512.0f, fPosicionYPelota = 450.0f, fPosicionZPelota = 200.0f, fPosicionXDisparo, fPosicionYDisparo, fPosicionZDisparo = 0.0f, fPosicionXControl, fPosicionYControl, fPosicionZControl = 100.0f, fPosicionXCurva,  fPosicionYCurva,  fPosicionZCurva, fTBezierBalon = 0.0f;
boolean bMovimientoPortero = true, bMovimiento = true;
PImage photo;

//El campo se encuentra en el plano z = 0 y el balon en el plano Z = 200

void setup() {

  size(1024, 600, P3D);
  stroke(255);
  photo = loadImage("portero.png");
  textFont(createFont("arial", 14));
}

void draw() {
  //Limpiamos la pantalla
  clear();
   background(0);
   
  //Pintamos el campo 
  stroke(130, 240, 255);
  for (int i = 0; i < height; i ++) {

    if (i == 100 || i == 300 || i == 500) stroke(80, 160, 30);
    if (i == 200 || i == 400) stroke(120, 250, 40);

    line(0, i, 0, width, i, 0);
  }
  stroke(255);
  
  //Pintamos las linias del campo
  strokeWeight(3);
  pushMatrix();
    translate(100, 100, 0);
    line(0, 0, 0, 0, 500, 0);
    translate(150, 0, 0);
    line(0, 0, 0, 0, 200, 0);
    translate(0, 200, 0);
    line(0, 0, 0, 500, 0, 0);
    translate(500, 0, 0);
    line(0, 0, 0, 0, -200, 0);
    translate(0, -200,0);
    translate(150, 0, 0);
    line(0, 0, 0, 0, 500, 0);
  popMatrix();
  strokeWeight(1);


 

  //Pintamos la porteria
  strokeWeight(5);
  pushMatrix();
    translate(362, 100, 0);
    line(0, 0, 0, 0, -70, 0);
    translate(0, -70, 0);
    line(0, 0, 0, 300, 0, 0);
    translate(300, 0, 0);
    line(0, 0, 0, 0, 70, 0);
  popMatrix();
  strokeWeight(1);
 
pushMatrix();
translate(0, 0, 1);
strokeWeight(3);
fill(0);
rect(30, 20, 80, 55, 10, 10, 10, 10);
strokeWeight(1);
translate(0, 0, 1);
fill(255);
if(iVidas > 0){
text("Vidas: " + iVidas, 40, 40);
text("Goles: " + iGoles, 40, 60);
}else{  
  textSize(13);
text("Game over\n Score:" + iGoles, 37, 45);
}
noFill();
popMatrix();
  //Si estamos en la fase 0 pintaremos un cursor para que el usuario elija el punto objetivo del disparo
  if (iFaseJuego == 0 && mouseX > 365 && mouseX < 660 && mouseY > 37 && mouseY < 100) {

    stroke(255, 0, 0);
    line(mouseX - 10, mouseY - 10, mouseX + 10, mouseY + 10);
    line(mouseX + 10, mouseY - 10, mouseX - 10, mouseY + 10);
    stroke(255);
  }

  //Si estamos en la fase 1 pintaremos la posicion seleccionada por el jugador con una esfera dado que el punto al no poderse modificar su tamaño no se puede ver.
  if (iFaseJuego > 0 && iFaseJuego < 3) {
    stroke(255, 0, 0);
    pushMatrix();
    translate(fPosicionXDisparo, fPosicionYDisparo, fPosicionZDisparo);
    sphere(3);
    popMatrix();
    stroke(255);
  }
  
  //Dibujamos trayectoria entre los puntos
   if (iFaseJuego == 2 && mouseX > 0 && mouseX < 1024 && mouseY < 600 && mouseY > 525) {
      stroke(0);
      for(float t = 0.0; t < 0.8; t += 0.05f){
       fPosicionXCurva = pow(1-t,2)*fPosicionXPelota+2*(1-t)*t*fPosicionXControl + t*t*fPosicionXDisparo;
       fPosicionYCurva = pow(1-t,2)*fPosicionYPelota+2*(1-t)*t*fPosicionYControl + t*t*fPosicionYDisparo;
       fPosicionZCurva = pow(1-t,2)*fPosicionZPelota+2*(1-t)*t*fPosicionZControl + t*t*fPosicionZDisparo;
      pushMatrix();
      translate(fPosicionXCurva, fPosicionYCurva, fPosicionZCurva);
      sphere(3);
      popMatrix();
      
      }
     stroke(255);
  }
  
  



  //Calculamos posicion portero
  if(bMovimientoPortero && bMovimiento)fPosicionXPortero += iVelocidadPortero;
  if(!bMovimientoPortero && bMovimiento)fPosicionXPortero -= iVelocidadPortero;
  if(fPosicionXPortero < 100) bMovimientoPortero = true;
  if(fPosicionXPortero > 840) bMovimientoPortero = false;

  //Dibujamos pelota estatica
  if(iFaseJuego < 3){
  pushMatrix();
    translate(fPosicionXPelota, fPosicionYPelota, fPosicionZPelota);
    sphere(10);
  popMatrix();
  }
  
  //Dibujamos pelota en movimiento
  if(iFaseJuego == 3){

      
       fPosicionXCurva = pow(1-fTBezierBalon,2)*fPosicionXPelota+2*(1-fTBezierBalon)*fTBezierBalon*fPosicionXControl + fTBezierBalon*fTBezierBalon*fPosicionXDisparo;
       fPosicionYCurva = pow(1-fTBezierBalon,2)*fPosicionYPelota+2*(1-fTBezierBalon)*fTBezierBalon*fPosicionYControl + fTBezierBalon*fTBezierBalon*fPosicionYDisparo;
       fPosicionZCurva = pow(1-fTBezierBalon,2)*fPosicionZPelota+2*(1-fTBezierBalon)*fTBezierBalon*fPosicionZControl + fTBezierBalon*fTBezierBalon*fPosicionZDisparo;
       
      
      pushMatrix();
      translate(fPosicionXCurva, fPosicionYCurva, fPosicionZCurva);
      sphere(10);
      popMatrix();
      

      if(fTBezierBalon < 1 && bMovimiento){
      fTBezierBalon += 0.01;
      
      }
      
      //Paramos el portero
      if(fTBezierBalon >= 1){
                
          
      }
      
      //Comprobamos si el portero para el balon. 
  
      if(fPosicionYCurva <= 220 && fPosicionYCurva >= 150) {
       
      //Pelota izquierda portero
     if(fPosicionXCurva - 10 < fPosicionXPortero && fPosicionXCurva + 10 - fPosicionXPortero >= 0 || fPosicionXCurva - 10 >= fPosicionXPortero  && fPosicionXCurva + 10 <= fPosicionXPortero + 50 || fPosicionXCurva + 10 > fPosicionXPortero + 50 && fPosicionXCurva - 10 - fPosicionXPortero + 50 <= 0 ){
         iVidas --;
        iFaseJuego = 0;
        fTBezierBalon = 0.0f;
  
     }
     
   
      
      }
   
  }
  stroke(0);

  //Dibujamos portero
   pushMatrix();
  translate(fPosicionXPortero, fPosicionYPortero, 1);
  image(photo, 0, 0);
  popMatrix();
 
}

void mouseClicked() {

  if (iFaseJuego == 0 && mouseX > 365 && mouseX < 660 && mouseY > 32 && mouseY < 100) {
    fPosicionXDisparo = mouseX;
    fPosicionYDisparo = mouseY;
    iFaseJuego = 1;
  
  }
  
  if(iFaseJuego == 3 && fTBezierBalon >= 1.0f){
     
    iGoles++;
    iFaseJuego = 0;
    fTBezierBalon = 0.0f;
    iVelocidadPortero ++;

  }
}

void mousePressed() {
  

if(iFaseJuego == 1 && mouseX < 532 && mouseX > 492 && mouseY > 524 && mouseY < 560  ){iFaseJuego = 2;}
  

  
  
}

void mouseReleased() {
  if (iFaseJuego == 2) {
    iFaseJuego = 3;
  }
}
void mouseDragged() {

  if (iFaseJuego == 2 && mouseX > 0 && mouseX < 1024 && mouseY < 600 && mouseY > 525) {
    fPosicionXControl = 512 + (512 - mouseX);
    fPosicionYControl = 600 + (300 - mouseY);
  }
}
//Variables

int 
  iFaseJuego = 0, 
  iGoles = 0, 
  iVidas = 3, 
  iVelocidadPortero = 8;

float
  fPosicionXPortero = 480, 
  fPosicionYPortero = 150, 

  fPosicionXPelota = 512.0f, 
  fPosicionYPelota = 450.0f, 
  fPosicionZPelota = 200.0f, 

  fPosicionXDisparo, 
  fPosicionYDisparo, 
  fPosicionZDisparo = 0.0f, 

  fPosicionXControl, 
  fPosicionYControl, 
  fPosicionZControl = 100.0f, 

  fPosicionXCurva, 
  fPosicionYCurva, 
  fPosicionZCurva, 

  fTBezierBalon = 0.0f;

boolean 
  bMovimientoPortero = true, 
  bMovimiento = true;

PImage 
  photo;


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
    translate(0, -200, 0);
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

  //Dibujamos el cuadro de vida y resultados
  pushMatrix();
    translate(0, 0, 1);
    strokeWeight(3);
    fill(0);
    rect(30, 20, 80, 55, 10, 10, 10, 10);
    strokeWeight(1);
    translate(0, 0, 1);
    fill(255);
    if (iVidas > 0) {
      text("Vidas: " + iVidas, 40, 40);
      text("Goles: " + iGoles, 40, 60);
    } else {  
      textSize(13);
      text("Game over\n Score:" + iGoles, 37, 45);
    }
    noFill();
  popMatrix();
  
  //Si estamos en la fase 0 pintaremos un cursor para que el usuario elija el punto objetivo del disparo
  if (iFaseJuego == 0 && mouseX > 365 && mouseX < 660 && mouseY > 37 && mouseY < 100 && iVidas > 0) {
    stroke(255, 0, 0);
    line(mouseX - 10, mouseY - 10, mouseX + 10, mouseY + 10);
    line(mouseX + 10, mouseY - 10, mouseX - 10, mouseY + 10);
    stroke(255);
  }

  //Si esntre la fase 1 y la 3 pintaremos la posicion seleccionada por el jugador.
  if (iFaseJuego > 0 && iFaseJuego < 3) {
    stroke(255, 0, 0);
      pushMatrix();
      translate(fPosicionXDisparo, fPosicionYDisparo, fPosicionZDisparo);
      sphere(3);
    popMatrix();
    stroke(255);
  }

  //Una vez seleccionado el punto de destino del balon dibujaremos una ayuda para que el usuario pueda ver parcialmente el recorrido del balon para esquivar el portero
  if (iFaseJuego == 2 && mouseX > 0 && mouseX < 1024 && mouseY < 600 && mouseY > 525) {
    stroke(0);
    for (float t = 0.0; t < 0.7; t += 0.05f) {
      fPosicionXCurva = pow(1-t, 2)*fPosicionXPelota+2*(1-t)*t*fPosicionXControl + t*t*fPosicionXDisparo;
      fPosicionYCurva = pow(1-t, 2)*fPosicionYPelota+2*(1-t)*t*fPosicionYControl + t*t*fPosicionYDisparo;
      fPosicionZCurva = pow(1-t, 2)*fPosicionZPelota+2*(1-t)*t*fPosicionZControl + t*t*fPosicionZDisparo;
      pushMatrix();
        translate(fPosicionXCurva, fPosicionYCurva, fPosicionZCurva);
        sphere(3);
      popMatrix();
    }
    stroke(255);
  }


  //Calculamos posicion portero ya que este se movera todo el rato
  if (bMovimientoPortero && bMovimiento)fPosicionXPortero += iVelocidadPortero;
  if (!bMovimientoPortero && bMovimiento)fPosicionXPortero -= iVelocidadPortero;
  if (fPosicionXPortero < 100) bMovimientoPortero = true;
  if (fPosicionXPortero > 840) bMovimientoPortero = false;
  
  //Dibujamos portero
  pushMatrix();
    translate(fPosicionXPortero, fPosicionYPortero, 1);
    image(photo, 0, 0);
  popMatrix();
  
  //Dibujamos pelota estatica mientras no se haya producido el lanzamiento
  if (iFaseJuego < 3) {
    pushMatrix();
    translate(fPosicionXPelota, fPosicionYPelota, fPosicionZPelota);
    sphere(10);
    popMatrix();
  }

  //Calculamos la posicion de la pelota en movimiento tras el lanzamiento y la dibujamos
  if (iFaseJuego == 3) {

    fPosicionXCurva = pow(1-fTBezierBalon, 2)*fPosicionXPelota+2*(1-fTBezierBalon)*fTBezierBalon*fPosicionXControl + fTBezierBalon*fTBezierBalon*fPosicionXDisparo;
    fPosicionYCurva = pow(1-fTBezierBalon, 2)*fPosicionYPelota+2*(1-fTBezierBalon)*fTBezierBalon*fPosicionYControl + fTBezierBalon*fTBezierBalon*fPosicionYDisparo;
    fPosicionZCurva = pow(1-fTBezierBalon, 2)*fPosicionZPelota+2*(1-fTBezierBalon)*fTBezierBalon*fPosicionZControl + fTBezierBalon*fTBezierBalon*fPosicionZDisparo;

    pushMatrix();
      translate(fPosicionXCurva, fPosicionYCurva, fPosicionZCurva);
      sphere(10);
    popMatrix();

    //Mientras la pelota no llegue a destino seguimos calculando su trayectoria
    if (fTBezierBalon < 1 && bMovimiento) {
      fTBezierBalon += 0.01;
    }

    //Miramos si la pelota esta en el plano del portero
    if (fPosicionYCurva <= 220 && fPosicionYCurva >= 150) {
        
      //Unicamente cuando esten en el mismo plano, para ahorrar calculos, comprobamos si el portero ha tocado el balon
     if (fPosicionXCurva - 10 < fPosicionXPortero && fPosicionXCurva + 10 - fPosicionXPortero >= 0 || fPosicionXCurva - 10 >= fPosicionXPortero  && fPosicionXCurva + 10 <= fPosicionXPortero + 50 || fPosicionXCurva + 10 > fPosicionXPortero + 50 && fPosicionXCurva - 10 - fPosicionXPortero + 50 <= 0 ) {
       //En caso de pararla se resetea el lanzamiento y el jugador pierde una vida.
        iVidas --;
        iFaseJuego = 0;
        fTBezierBalon = 0.0f;
      }
    }
  }
  stroke(0);


}

void mouseClicked() {
  
  //En la fase 0 el hacer click sirve para que si el usuario tiene el raton dentro de la porteria seleccione objetivo de lanzamiento
  if (iFaseJuego == 0 && mouseX > 365 && mouseX < 660 && mouseY > 32 && mouseY < 100 && iVidas > 0) {
    fPosicionXDisparo = mouseX;
    fPosicionYDisparo = mouseY;
    iFaseJuego = 1;
  }
  
  //Al hacer click en la fase 3, si la pelota ha llegado a destino, se resetea el lanzamiento aumentado la velocidad del portero 
  //y dando un punto al jugador, no se hace automaticamente para que el usuario pueda comprobar el resultado del lanzamiento
  if (iFaseJuego == 3 && fTBezierBalon >= 1.0f) {

    iGoles++;
    iFaseJuego = 0;
    fTBezierBalon = 0.0f;
    iVelocidadPortero ++;
  }
}

void mousePressed() {

  //Al pulsar el boton sobre el balon pasamos a la fase en que el jugador elige la curva de lanzamiento.
  if (iFaseJuego == 1 && mouseX < 532 && mouseX > 492 && mouseY > 524 && mouseY < 560  ) {
    iFaseJuego = 2;
  }
}

void mouseReleased() {
  
  //Cuando suelte el boton significa que ha elegido la curva de lanzamiento
  if (iFaseJuego == 2) {
    iFaseJuego = 3;
  }
}
void mouseDragged() {
  
  //Modificamos los valores de la curva de lanzamiento mientras el usuario no suelte el boton y lo arrastre dentro de los limites.
  if (iFaseJuego == 2 && mouseX > 0 && mouseX < 1024 && mouseY < 600 && mouseY > 525) {
    fPosicionXControl = 512 + (512 - mouseX);
    fPosicionYControl = 600 + (300 - mouseY);
  }
}


void keyPressed() {

  //Al perder todas las vidas el usuario puede reiniciar el juego pulsando enter
  if (keyCode == ENTER && iVidas <= 0) {

    iGoles = 0;
    iFaseJuego = 0;
    fTBezierBalon = 0.0f;
    iVelocidadPortero = 8;
    iVidas = 3;
  }
}
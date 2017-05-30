//Variables

double fCentroPelotaY = 150.0f;
double fCentroPelotaZ = 0.0f;
boolean bObjetivo = false;
int iObjetivoX, iObjetivoY;

void setup() {

  size(1024, 600, P3D);
  stroke(255);
  noCursor();
}

void draw() {

  //Limpiamos la pantalla
  clear();
  //noFill();

  //Pintamos el campo
  pintarCampo();

  //Si no se ha seleccionado donde disparar dibujamos el cursor
  pintarCursor();
  
  //En caso de que haya objetivo lo pintamos
  if(bObjetivo)pintarObjetivo();
   


  //Calculamos la posicion del portero
  //Comprobamos si la pelota esta en movimiento y en caso de estarlo calculamos posicion de la pelota 

  //Dibujamos todos los elementos, la curva unicamente si el usuario esta calculando donde disparar el balon

  //Comprobamos si hay colision entre el portero y la pelota

  //Modificamos el contador de puntos



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

  /*if (fCentroPelotaZ > -150) {
    fCentroPelotaY -= 1.0; 
    fCentroPelotaZ -= 0.42857143;
  } 
  println("Y = " + fCentroPelotaY + "Z = " + fCentroPelotaZ);*/
}

//Comprobamos si el usuario esta pulsando el boton para empezar a dibujar la trayectoria de la pelota, almacenamos la posicion inicial de donde hace click
void mousePressed() {
  
  if(!bObjetivo){
  iObjetivoX = mouseX;
  iObjetivoY = mouseY;
  bObjetivo = true;
  }
  
}

//Utilizando el punto inicial donde hizo click y la posicion donde se encuentra el raton calculamos todos los puntos de la curva
void mouseDragged() {
}

//A la que soltemos el boton del raton se iniciara el lanzamiento del balon hacia la porteria
void mouseReleased() {
}



/************************ Pintar Campo ****************************
 - Explicacion
 Para cada Y asigna un color y pinta una linea horizontal 
 de punta a punta de la pantalla para simular un campo de futbol.
 
 - Parametros de entrada
 Ninguno
 
 - Modifica valores
 Ninguno
 
 - Utiliza variables globales
 height, width
 
 - Llama funciones
 stroke()
 line()
 ******************************************************************/

void pintarCampo() {

  stroke(130, 240, 255);
  for (int i = 0; i < height; i ++) {

    if (i == 100 || i == 300 || i == 500) stroke(80, 160, 30);
    if (i == 200 || i == 400) stroke(120, 250, 40);

    line(0, i, 0, width, i, 0);
  }
  stroke(255);
}


/************************ Pintar Cursor ****************************
 - Explicacion
 Dibuja una cruz en pantalla que usaremos para indicar en que lugar
 queremos disparar el balon. El centro de la cruz es la posicion del
 mouse.
 
 - Parametros de entrada
 Ninguno
 
 - Modifica valores
 Ninguno
 
 - Utiliza variables globales
 mouseX, mouseY
 
 - Llama funciones
 stroke()
 line()
 ******************************************************************/

void pintarCursor() {

  stroke(255, 0, 0);
  line(mouseX - 10, mouseY - 10, mouseX + 10, mouseY + 10 );
  line(mouseX + 10, mouseY - 10, mouseX - 10, mouseY + 10 );
  stroke(255);
}

/************************ Pintar Objetivo ****************************
 - Explicacion
Dibujamos una elipse donde el objetivo que indica el usuario para que
sepa a donde ira el balon
 
 - Parametros de entrada
 Ninguno
 
 - Modifica valores
 Ninguno
 
 - Utiliza variables globales
 iObjetivoX, iObjetivoY
 
 - Llama funciones
 stroke()
 strokeWeight()
 ellipse()
 ******************************************************************/

void pintarObjetivo(){

  stroke(255, 0, 0);
  strokeWeight(5);
  ellipse(iObjetivoX, iObjetivoY, 5, 5);
  strokeWeight(1);
  stroke(255);

}
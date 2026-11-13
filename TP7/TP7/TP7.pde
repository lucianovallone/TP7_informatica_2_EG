import processing.serial.*;
Serial miPuerto;


boolean E1 = false;
boolean E2 = false;
boolean L1 = false;
boolean L2 = false;

void setup() {
  miPuerto = new Serial(this, Serial.list()[1], 9600);
  printArray(Serial.list());
  size(600, 350);
  textAlign(CENTER, CENTER); // centra los textos en sus coordenadas (X, Y)
  textSize(20);  // tamaño de letra
}

void draw() {
  background(255); // Limpia la pantalla con blanco en cada vuelta
  
  if (miPuerto.available() > 0) {
    char dato = miPuerto.readChar(); // Guardamos la letra que mandó el Arduino
    
    if (dato == '1') { // Pulsador 1 apretado
      E1 = true;
      L1 = true;
    }
    if (dato == '0') { // Pulsador 1 suelto
      E1 = false;
      L1 = false;
    }
    
    if (dato == '2') { 
      E2 = true;
      L2= true;
    }
    if (dato == '3') {
      E2 = false;
      L2= false;
    }
  }
  
//CARTELES FIJOS
  fill(130, 160, 200);     // Azul claro
  rect(50, 60, 140, 50);
  fill(250, 220, 190);     // Naranja claro
  rect(50, 200, 140, 50);
  
  fill(0);
  text("Entradas", 120, 85);
  text("Salidas", 120, 225);
  
  //E1
  if (E1) fill(0, 255, 0); else fill(255);
  rect(280, 60, 80, 50);
  fill(0);
  text("E1", 320, 85);
  
  //E2
  if (E2) fill(0, 255, 0); else fill(255);
  rect(400, 60, 80, 50);
  fill(0);
  text("E2", 440, 85);
  
  //L1
  if (L1) fill(255, 0, 0); else fill(255);
  ellipse(320, 225, 70, 70);
  fill(0);
  text("L1", 320, 225);
  
  //L2
  if (L2) fill(255, 0, 0); else fill(255);
  ellipse(440, 225, 70, 70);
  fill(0);
  text("L2", 440, 225);
}
void mousePressed() {
  // si la distancia entre el mouse y el centro de L1 es menor a 35:
  if (dist(mouseX, mouseY, 320, 225)<35) {
    L1=!L1; // invierte el estado de L1
    if (L1 == true) {
      miPuerto.write('A'); // Manda orden de prender LED 1 al Arduino
    } else {
      miPuerto.write('a'); // Manda orden de apagar LED 1 al Arduino
    }
  }
  if (dist(mouseX, mouseY, 440, 225)<35){
    L2=!L2;
    if (L2 == true) {
      miPuerto.write('B');
    } else {
      miPuerto.write('b'); 
    }
  }
}

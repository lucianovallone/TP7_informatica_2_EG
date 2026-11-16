const int pinE1 = 22, pinE2 = 24;
const int pinL1 = 26, pinL2 = 28;
int estadoAnt1 = LOW, estadoAnt2 = LOW;

void setup() {
  Serial.begin(9600);
  pinMode(pinE1, INPUT_PULLUP);
  pinMode(pinE2, INPUT_PULLUP);
  pinMode(pinL1, OUTPUT);
  pinMode(pinL2, OUTPUT);
}

void loop() {
  // 1. Escuchar órdenes del mouse desde Processing
  if (Serial.available() > 0) {
    char dato = Serial.read();
    if (dato == 'A') digitalWrite(pinL1, HIGH);
    if (dato == 'a') digitalWrite(pinL1, LOW);
    if (dato == 'B') digitalWrite(pinL2, HIGH);
    if (dato == 'b') digitalWrite(pinL2, LOW);
  }

  // 2. Leer Pulsador 1 (solo si cambió de estado)
  int lectura1 = digitalRead(pinE1);
  if (lectura1 != estadoAnt1) {
    if (lectura1 == LOW) {
      digitalWrite(pinL1, HIGH);
      Serial.write('1');
    } else {
      digitalWrite(pinL1, LOW);
      Serial.write('0');
    }
    estadoAnt1 = lectura1;
    delay(50);
  }
  int lectura2 = digitalRead(pinE2);
  if (lectura2 != estadoAnt2) {
    if (lectura2 == LOW) {
      digitalWrite(pinL2, HIGH);
      Serial.write('2');
    } else {
      digitalWrite(pinL2, LOW);
      Serial.write('3');
    }
    estadoAnt2 = lectura2;
    delay(50); // Pequeña pausa antirrebote
  }
}
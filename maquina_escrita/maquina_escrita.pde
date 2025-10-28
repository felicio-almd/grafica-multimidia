boolean onOffAtivo = false;
boolean digitosAtivo = false;
boolean textoAtivo = false;

char[] letras = new char[10];

void setup() {
  size(1000, 900);
  background(255);
  gerarLetrasAleatorias();
}

void draw() {
  float radius = 20;
  background(255);

  // parte superior
  fill(255, 204, 0);
  noStroke();
  rect(150, 300, 700, 200, radius, radius, 0, 0);  
  
  // parte inferior
  fill(255, 204, 0);
  stroke(0);
  rect(150, 500, 700, 325, 0, 0, radius, radius);  

  // fundo das teclas
  fill(0, 0, 0);
  rect(200, 500, 600, 290, 0, 0, radius, radius); 
  
  // barra de espaço vermelha
  fill(255, 0, 0);
  rect(325, 695, 350, 80, radius, radius, radius, radius); 

  textAlign(CENTER, CENTER);
  textSize(24);
  fill(200);

  if (digitosAtivo) {
    for (int i = 0; i < 10; i++) {
      float x = 240 + i * 55;
      float y = 560;
      ellipse(x, y, 40, 40);
      fill(0);
      text(str(i), x, y);
      fill(200);
    }
  } 
  
  if (textoAtivo) {
    for (int i = 0; i < 10; i++) {
      float x = 240 + i * 55;
      float y = 630;
      ellipse(x, y, 40, 40);
      fill(0);
      text(letras[i], x, y);
      fill(200);
    }
  }

  // botões de ativação 
  desenharBotao(360, 710, 80, 50, "ON/OFF", onOffAtivo);
  desenharBotao(470, 710, 80, 50, "DIG", digitosAtivo);
  desenharBotao(580, 710, 80, 50, "TEXT", textoAtivo);
}

void mousePressed() {
  if (mouseDentro(360, 710, 80, 50)) {
    onOffAtivo = !onOffAtivo;
    // se desligar, apaga tudo
    if (!onOffAtivo) {
      digitosAtivo = false;
      textoAtivo = false;
    }
  } 
  else if (mouseDentro(470, 710, 80, 50) && onOffAtivo) {
    digitosAtivo = !digitosAtivo;
  } 
  else if (mouseDentro(580, 710, 80, 50) && onOffAtivo) {
    textoAtivo = !textoAtivo;
  }

  redraw();
}

void keyPressed() {
  if (key == 'o' || key == 'O'){
    onOffAtivo = !onOffAtivo;
    if (!onOffAtivo) {
      digitosAtivo = false;
      textoAtivo = false;
    }
  }
  if (onOffAtivo) {
    if (key == 'd' || key == 'D') {
      digitosAtivo = !digitosAtivo;
    } 
    else if (key == 't' || key == 'T') {
      textoAtivo = !textoAtivo;
    }
  }
}

void desenharBotao(float x, float y, float w, float h, String label, boolean ativo) {
  if (ativo) fill(0, 255, 0); 
  else fill(255); 
  stroke(0);
  rect(x, y, w, h, 10);
  fill(0);
  textSize(16);
  textAlign(CENTER, CENTER);
  text(label, x + w/2, y + h/2);
}

// verifica se o clique foi dentro do botão
boolean mouseDentro(float x, float y, float w, float h) {
  return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
}

// gera letras aleatórias para o texto apenas uma vez
void gerarLetrasAleatorias() {
  String alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for (int i = 0; i < 10; i++) {
    letras[i] = alfabeto.charAt(int(random(alfabeto.length())));
  }
}



import processing.sound.*;
SoundFile somTecla;

boolean onOffAtivo = false;
boolean digitosAtivo = false;
boolean textoAtivo = false;

float eyeX;
float eyeY;
// Tamanho do olho
float eyeSize = 100;
// Deslocamento da pupila em relação ao centro do olho
float pupilOffset =  6;


char[] letras = {'q', 'w', 'e', 'r', 'a', 'y', 'u', 'i', 'l', 'p'};
String texto = "";
int index = 0;
boolean textoPressionado = false;
void setup() {
  eyeX = width / 2;
  eyeY = height / 2;
  size(1000, 1000);
  background(255);
  somTecla = new SoundFile(this, "Chinese.mp3");
}

void draw() {
  float radius = 20;
  background(255);

  fill(255, 250, 240); // cor de papel
  stroke(180);
  rect(180, 25, 640, 370, 10);  // papel acima do robô

  // Linhas do papel
  stroke(220);
  for (int i = 0; i < 6; i++) {
    float yLinha = 78 + i * 50;
    line(200, yLinha, 780, yLinha);
  }
  fill(0);
  textSize(45); 

  for (int i = 0; i < texto.length(); i++) {
    char letra = texto.charAt(i);
    
    int linha = i / 10;
    int posicionEnLinea = i % 10;
    
    float x = 230 + posicionEnLinea * 56;
    float y = 56 + linha * 50;

    if (y < 330) { 
      text(letra, x, y); 
    }
  }
  // parte superior
  fill(255, 204, 0);
  noStroke();
  rect(150, 370, 700, 258, radius, radius, 0, 0);  


  // parte inferior
  fill(255, 210, 0);
  stroke(0);
  rect(150, 565, 700, 380, 0, 0, radius, radius);  

  // fundo das teclas
  fill(105, 105, 105);
  rect(200, 600, 600, 300, 0, 0, radius, radius); 

  // barra de espaço vermelha
  fill(255, 190, 0);
  rect(320, 790, 350, 80, radius, radius, radius, radius); 


  //robô
  // para facilitar o movimento do robô
  float roboX = 174; // Posição X do robô
  float roboY = 470; // Posição Y do robô

  //pupila que mexe
  // Calcula o ângulo entre o centro do olho e a posição do mouse
  float angle = atan2(mouseY - eyeY, mouseX - eyeX);

  // Calcula a posição da pupila com base no ângulo
  float pupilX = roboX + 363 + cos(angle) * pupilOffset;
  float pupilY = roboY - 102 + sin(angle) * pupilOffset;
  float pupilEX = roboX + 282 + cos(angle) * pupilOffset;
  float pupilEY = roboY - 102 + sin(angle) * pupilOffset;

  beginShape();
  fill(104, 104, 104);
  vertex(roboX + 204, roboY - 161);  // Ponto superior esquerdo

  bezierVertex(roboX + (247 + 377), roboY - 272, 
    roboX + (171 + 70 + 69), roboY - 161, 
    roboX + 205 + 227, roboY - 169);  // Curva suave

  vertex(roboX + (208 + 220), roboY + 14);
  vertex(roboX + 211, roboY + 13); // Ponto inferior esquerdo
  endShape(CLOSE);

  // Lado esquerdo
  beginShape();
  vertex(roboX + 212, roboY + 20);
  vertex(roboX + 205, roboY - 120);
  vertex(roboX + 262, roboY - 12);
  vertex(roboX + 262, roboY + 56); 
  endShape(CLOSE);

  // Lado direito
  beginShape();
  vertex(roboX + 429, roboY + 20);
  vertex(roboX + 432, roboY - 120);
  vertex(roboX + 375, roboY - 12);
  vertex(roboX + 374, roboY + 56); 
  endShape(CLOSE);

  // Meio
  fill(104);
  
  if (onOffAtivo) {
    if (digitosAtivo || textoAtivo) {
      rect(roboX + 262, roboY + 10, 113, 44);
      fill(255, 204, 0);
      
      arc(roboX + 320, roboY + -2, 60, 40, 0, PI);
    } else {
      fill(255, 0, 0);
      rect(roboX + 262, roboY + -1, 113, 56);
    }
  } else {
    rect(roboX + 262, roboY + -1, 113, 56);
    fill(18);
  }

  stroke(0);
  fill(0);
  rect(415, 330, 155 ,68, 50);

  // Olhos
  if (onOffAtivo) {
    if (digitosAtivo || textoAtivo) {
      fill(255, 204, 0);
    } else {
      fill(255, 0, 0);
    }
  } else {
    fill(18);
  }
  ellipse(roboX + 361, roboY - 104, 46, 47);
  ellipse(roboX + 277, roboY - 102, 46, 47);

  //Pupilas
  if (onOffAtivo && (digitosAtivo || textoAtivo)) {
    fill(255, 204, 0);
    ellipse(pupilX, pupilY, 80 * 0.4, 75 * 0.4);
    ellipse(pupilEX, pupilEY, 80 * 0.4, 75 * 0.4);
  }



  // Parafuso esquerdo
  fill(104, 104, 104);
  beginShape();
  vertex(roboX + 179, roboY - 60);  // Ponto superior esquerdo
  vertex(roboX + (157 + 50), roboY - 69);  // Ponto superior direito
  vertex(roboX + (159 + 49), roboY - (39));  // Ponto inferior direito
  vertex(roboX + 180, roboY - (39));  // Ponto inferior esquerdo
  endShape(CLOSE);  // Fecha o retângulo

  // Parafuso direito
  beginShape();
  vertex(roboX + 431, roboY - 69);  // Ponto superior esquerdo
  vertex(roboX + (407 + 50), roboY - 60);  // Ponto superior direito
  vertex(roboX + (407 + 50), roboY - (39));  // Ponto inferior direito
  vertex(roboX + 431, roboY - (38));  // Ponto inferior esquerdo
  endShape(CLOSE);  // Fecha o retângulo
  // -- - - - fim do robô  - - - - - -
  
  
  textAlign(CENTER, CENTER);
  textSize(24);
  fill(200);

  if (digitosAtivo) {
    for (int i = 0; i < 10; i++) {
      float x = 250 + i * 55;
      float y = 665;
      float distance = dist(mouseX, mouseY, x, y);
      float scaledDistance = distance / (45 / 2);
      
      char digito = str(i).charAt(0);
      
     if((mousePressed && scaledDistance <= 1) || (keyPressed && Character.getNumericValue(key) == i)){
        fill(139, 101, 94);
        
        // Lógica de Adição do Dígito (NOVO)
        if (textoPressionado) {
            texto += digito; // Adiciona o dígito à string de texto
            textoPressionado = false;
        }
      }
      
      ellipse(x, y, 45, 46);
      fill(0);
      text(str(i), x, y);
      fill(200);
    }
  } 

  if (textoAtivo) {

    for (int i = 0; i < 10; i++) {
      float x = 250 + i * 55;
      float y = 735;
      float distance = dist(mouseX, mouseY, x, y);
      float scaledDistance = distance / (45 / 2);

      if((mousePressed && scaledDistance <= 1) || (keyPressed && Character.toLowerCase(key) == Character.toLowerCase(letras[i]))){
        if(textoPressionado){
          fill(139, 101, 94);
          texto += Character.toUpperCase(letras[i]);
          textoPressionado = false;
        }

      }
      ellipse(x, y, 45, 45);
      fill(0);
      text(Character.toUpperCase(letras[i]), x, y);
      fill(200);
    }
      
  }

  // botões de ativação 
  desenharBotao(350, 805, 80, 50, "ON/OFF", onOffAtivo);
  desenharBotao(455, 805, 80, 50, "DIG", digitosAtivo);
  desenharBotao(559, 805, 80, 50, "TEXT", textoAtivo);
}

void mousePressed() {
  textoPressionado = true;
  if (mouseDentro(360, 805, 80, 50)) {
    onOffAtivo = !onOffAtivo;
    somTecla.play();
    // se desligar, apaga tudo
    if (!onOffAtivo) {
      digitosAtivo = false;
      textoAtivo = false;
      texto = "";
    }
  } else if (mouseDentro(470, 805, 80, 50) && onOffAtivo) {
    digitosAtivo = !digitosAtivo;
  } else if (mouseDentro(580, 805, 80, 50) && onOffAtivo) {
    textoAtivo = !textoAtivo;
  }

  redraw();
}

void keyPressed() {
  textoPressionado = true;
  
  if (key == BACKSPACE) {
    if (texto.length() > 0) {
      texto = texto.substring(0, texto.length() - 1);
      textoPressionado = false;
      }
    return;
  }
  
  if (key == 'o' || key == 'O') {
    onOffAtivo = !onOffAtivo;
    if (!onOffAtivo) {
      digitosAtivo = false;
      textoAtivo = false;
      texto = "";
    }
  }
  if (onOffAtivo) {
    if (key == 'd' || key == 'D') {
      digitosAtivo = !digitosAtivo;
    } else if (key == 't' || key == 'T') {
      textoAtivo = !textoAtivo;
    }
  }
}

void desenharBotao(float x, float y, float w, float h, String label, boolean ativo) {
  if (ativo) fill(202, 204, 106); 
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




void escrever(String a, float x, float y){
  fill(0);
  text(a, x, y);
}

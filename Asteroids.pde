/* This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>
*/

Nave nave;
float naveVel = 2;
float anguloRotacion = .2;
float balaVel = 15;
int numAsteroids = 1;
int darkMostrador;
int darkMostradorLimite = 24*2;
int MAX_VIDAS = 3;
int vidas;
int escenario = -1;
int diffCurva = 2;
int inicioRadio = 50;

PImage[] asteroidesImagenes = new PImage[3];
PImage rocket, img, logo;
//float bgColor = 0;

ArrayList<Escape> escape;
ArrayList<Escape> fuego;
ArrayList<Bala> balas;
ArrayList<Asteroid> asteroids;

boolean arribaPresion = false;
boolean abajoPresion = false;
boolean aPresion = false;
boolean dPresion = false;

PFont font;

void setup(){
 //background(bgColor);
 size(856, 527);
 font = createFont("data/Fonts/BookAntiqua-Bold-48.vlw", 32);
 asteroidesImagenes[0] = loadImage("data/Images/Asteroid0.png");
 asteroidesImagenes[1] = loadImage("data/Images/Asteroid1.png"); 
 asteroidesImagenes[2] = loadImage("data/Images/Asteroid2.png"); 
 rocket = loadImage("data/Images/Rocket.png");
 logo = loadImage("data/Images/logo.png");
 frameRate(30);
 vidas = 3;
 asteroids = new ArrayList<Asteroid>(0);
 img = loadImage("data/Images/Fondo.png");
}


void draw(){
  image(img, 0, 0);
 if( vidas >= 0 && asteroids.size()>0){
   float theta = T2D(nave.rotacion)+PI/2;
 
   
   nave.actualizar(escape, fuego);
   nave.bordes();
   nave.hacer(); 
   if(nave.verColision(asteroids)){
    vidas--;
    nave = new Nave(); 
   }
   
   if(aPresion){
     rotate2D(nave.rotacion,-anguloRotacion);
     //ellipse(100,100,100,100);
   }
   if(dPresion){
     rotate2D(nave.rotacion, anguloRotacion);
   }
   if(arribaPresion){
     nave.acceleracion = new PVector(0, naveVel); 
     rotate2D(nave.acceleracion, theta);
   }
   
   for(Escape e: escape){
    e.actualizar();
    e.render(); 
   }
   
   for(Escape e: fuego){
    e.actualizar();
    e.render(); 
   }
   
   for(int i = 0; i < balas.size(); i++){
    balas.get(i).bordes();
    if(balas.get(i).actualizar()){
      balas.remove(i);
      i--;
    }
    if(i < 0){
     break; 
    }
    balas.get(i).hacer();
    if(balas.get(i).verColision(asteroids)){
      balas.remove(i);
      i--;
    } 
   }
   
    while(escape.size() > 20){
    escape.remove(0); 
   }
   
   while(fuego.size()>6){
    fuego.remove(0); 
   }
   
    while(balas.size() > 30){
    balas.remove(0); 
   }
   
   for(Asteroid a : asteroids){
    a.actualizar();
    a.bordes();
    a.hacer(); 
   }
  
  
   for(int i = 0; i < vidas; i++){
     image(rocket,40*i + 10,nave.r*1.5,2*nave.r,3*nave.r); 
   }
 } else if(vidas < 0){
   if(darkMostrador < darkMostradorLimite){
   // background(0);
   img = loadImage("data/Images/Fondo.png");
    darkMostrador++;
    for(Asteroid a : asteroids){
      a.actualizar();
      a.bordes();
      a.hacer(); 
     }
    fill(0, 255-(darkMostradorLimite-darkMostrador)*3);
    rect(0,0,width,height);
   } else {
     //background(0);
     img = loadImage("data/Images/Fondo.png");
     for(Asteroid a : asteroids){
      a.actualizar();
      a.bordes();
      a.hacer(); 
     }
     image(rocket,width/2 - 5 * nave.r,height/2-7.5*nave.r,10*nave.r,15*nave.r); 
     textFont(font, 33);
     fill(0, 200);
     text("\nPERDISTE", width/2-80-2, height*.75-1);
     fill(0, 200);
     textFont(font, 32);
     fill(#FC0303);
     text("\nPERDISTE", width/2-80, height*.75);
     fill(#F0F0F0);
     text("Version 1", width/2-90-2, height*.75-1);

     
     textFont(font, 16);
     fill(0, 200);
     text("\nHaga click para jugar de nu7evo", width/2-80-2, height*.9-1);
     textFont(font, 15);
     fill(255);
     text("\nHaga click para jugar nuevamente", width/2-80, height*.9);
   }
 } else {
     //background(0);
     img = loadImage("data/Images/Fondo.png");
     nave = new Nave();
     nave.hacer();
     
     textFont(font, 32);
     fill(255);
     if(escenario > -1){
         text("Escenario " + (escenario + 1) + " completo", width/2-120, height/2);
     } else {
         image(logo, 120, 50);
     }
     textFont(font, 15);
     fill(255);
     textSize(30);
     text("Haga click para jugar el nivel " + (escenario + 2), 240, 300);
 }
}

void mousePressed(){
  if(vidas < 0){
   escenario = -1;
   vidas = 3;
   asteroids = new ArrayList<Asteroid>(0);
  } else  if (asteroids.size()==0){
   escenario++;
   reset(); 
  }
}

void reset(){
 nave  = new Nave();
 escape = new ArrayList<Escape>();
 fuego = new ArrayList<Escape>();
 balas = new ArrayList<Bala>();
 asteroids = new ArrayList<Asteroid>();
 for(int i = 0; i <numAsteroids + diffCurva*escenario; i++){
  PVector position = new PVector((int)(Math.random()*width), (int)(Math.random()*height-100)); 
  asteroids.add(new Asteroid(position, inicioRadio, asteroidesImagenes, escenario));
 }
 darkMostrador = 0;
}

void disparoBalas(){
  PVector pos = new PVector(0, nave.r*2);
  rotate2D(pos,T2D(nave.rotacion) + PI/2);
  pos.add(nave.posicion);
  PVector vel  = new PVector(0, balaVel);
  rotate2D(vel, T2D(nave.rotacion) + PI/2);
  balas.add(new Bala(pos, vel));
}

void keyPressed(){
  if(key==CODED){
   if(keyCode==UP){
      arribaPresion=true;
   } else if(keyCode==DOWN){
      abajoPresion=true;
   } else if(keyCode == LEFT){
    aPresion = true;  
   }else  if(keyCode==RIGHT){
    dPresion = true; 
   }
  }
  if(key == 'a'){
    aPresion = true; 
  }
  if(key=='d'){
   dPresion = true; 
  }
  if(key=='w'){
    arribaPresion=true;
  }
  if(key=='s'){
   abajoPresion=true; 
  }
}

void keyReleased(){
  if(key==CODED){
   if(keyCode==UP){
     arribaPresion=false;
    nave.acceleracion = new PVector(0,0);  
   } else if(keyCode==DOWN){
     abajoPresion=false;
     nave.acceleracion = new PVector(0,0); 
   } else if(keyCode==LEFT){
     aPresion = false; 
   } else  if(keyCode==RIGHT){
    dPresion = false; 
   }
  }
  if(key=='a'){
   aPresion = false; 
  }
  if(key=='d'){
   dPresion = false; 
  }
  if(key=='w'){
    arribaPresion=false;
    nave.acceleracion = new PVector(0,0);
  }
  if(key=='s'){
   abajoPresion=false; 
   nave.acceleracion = new PVector(0,0);
  }
  if(key == ' '){
   disparoBalas();
  }
}


float T2D(PVector pvect){
   return (float)(Math.atan2(pvect.y, pvect.x));  
}

void rotate2D(PVector v, float theta) {
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}

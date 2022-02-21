This is free and unencumbered software released into the public domain.

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

class Asteroid{
 float radios;
 float omegaLimite = .05;
 PVector posicion;
 PVector velocidad;
 PVector rotacion;
 float giro;
 int col = 100;
 PImage pics[];
 PImage pic;
 int escenario;
 float amortiguado = 1;

 
 public Asteroid(PVector pos, float radios_, PImage[] pics_, int escenario_){
   radios  = radios_;
   escenario = escenario_;
   posicion = pos;
   float angulo = random(2 * PI);
   velocidad = new PVector(cos(angulo), sin(angulo));
   velocidad.mult((50*50)/(radios*radios));
   velocidad.mult(sqrt(escenario  + 2));
   velocidad.mult(amortiguado);
   angulo = random(2 * PI);
   rotacion = new PVector(cos(angulo), sin(angulo));
   giro = (float)(Math.random()*omegaLimite-omegaLimite/2);
   int rnd = (int)(Math.random()*3);
   pics = pics_;
   pic = pics[rnd];
 }
 
 void disolver(ArrayList<Asteroid> asteroids){
  if(radios <= 30){
   asteroids.remove(this);
  } else if (radios < 33){
     for(int i = 0; i < 2; i++){
      float angulo = random(2*PI);
      PVector rand = new PVector(radios*sin(angulo), radios*cos(angulo));
      rand.add(posicion);
      asteroids.add(new Asteroid(rand, radios*.8, pics, escenario));
    }
    asteroids.remove(this);
  } else {
    for(int i = 0; i < 3; i++){
      float angulo = random(2*PI);
      PVector rand = new PVector(radios*sin(angulo), radios*cos(angulo));
      rand.add(posicion);
      asteroids.add(new Asteroid(rand, radios*.8, pics, escenario));
    }
    asteroids.remove(this);
  }
 }
 
 void actualizar()
 {
   posicion.add(velocidad);
   rotate2D(rotacion, giro);
 }
 
 void hacer()
 {
   fill(col);
   circ(posicion.x, posicion.y);
   if (posicion.x < radios)
   {
      circ(posicion.x + width, posicion.y);
    } 
    else if (posicion.x > width-radios)
    {
      circ( posicion.x-width, posicion.y);
    }
    
    if (posicion.y < radios) 
    {
      circ(posicion.x, posicion.y + height); 
    }
    
    else if (posicion.y > height-radios)
    {
      circ(posicion.x, posicion.y-height);
    } 
 }
 
 void bordes(){
  if (posicion.x < 0){ posicion.x = width;}
    if (posicion.y < 0){posicion.y = height;}
    if (posicion.x > width){posicion.x = 0;}
    if (posicion.y > height){posicion.y = 0;} 
 }
 
 void circ(float x, float y)
 {
  pushMatrix();
  translate(x,y);
  rotate(T2D(rotacion)+PI/2); 
  image(pic, -radios,-radios,radios*2, radios*2);
  popMatrix();
 }  

float T2D(PVector pvect)
{
   return (float)(Math.atan2(pvect.y, pvect.x));  
}

void rotacion2D(PVector v, float theta) 
{
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}
 
}
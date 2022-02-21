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

class Nave{   
 PVector posicion;
 PVector velocidad;
 PVector acceleracion;
 PVector rotacion;
 float drag = .9;
 float r = 15;
 PImage img = loadImage("data/Images/Rocket.png");

 public Nave(){
  posicion = new PVector(width/2, height-50);
  acceleracion = new PVector(0,0);
  velocidad = new PVector(0,0);
  rotacion = new PVector(0,1);
 } 
 
 void actualizar(ArrayList<Escape> escape, ArrayList<Escape> fuego){
   PVector abajo = new PVector(0, -2*r);
   rotate2D(abajo, T2D(rotacion)+PI/2);
   abajo.add(posicion);
   color grey = color(100, 75);
   
   int escapeVol = (int)(velocidad.mag())+1;
   for(int i = 0; i  <escapeVol; i++){
     float angulo = (float)(Math.random()*.5-.25);
     angulo += T2D(rotacion);
     PVector fueraDir = new PVector(cos(angulo), sin(angulo));
     escape.add(new Escape(abajo, fueraDir, grey, 15));
   }
   for(int i = 0; i  <1; i++){
     float angulo = (float)(Math.random()*.5-.25);
     angulo += T2D(rotacion);
     PVector fueraDir = new PVector(cos(angulo), sin(angulo));
     fueraDir.y = 0;
     abajo.add(fueraDir);
     abajo.y-=.5;
     color red = color((int)(200 + Math.random()*55),(int)( 150+Math.random()*105), 50, 250);
     fuego.add(new Escape(abajo,fueraDir, red, 5));
   }
   velocidad.add(acceleracion);
   velocidad.mult(drag);
   velocidad.limit(5);
   posicion.add(velocidad);

 }
 
 void bordes(){
  if (posicion.x < r){
      posicion.x = width-r;
    }
    if (posicion.y < r) {
      posicion.y = height-r;
    }
    if (posicion.x > width-r) {
      posicion.x = r;
    }
    if (posicion.y > height-r){
      posicion.y = r;
    } 
 }
 
 boolean verColision(ArrayList<Asteroid> asteroids){
   for(Asteroid a : asteroids){
    PVector dist = PVector.sub(a.posicion, posicion);
    if(dist.mag() < a.radios + r/2){
     a.disolver(asteroids);
     return true; 
    }
   }
   return false;
 }
 
 void hacer(){
   float theta = T2D(rotacion)  + PI/2;
   theta += PI;
   
   pushMatrix();
   translate(posicion.x, posicion.y);
   rotate(theta);
   fill(0);

   image(img,-r,-r*1.5,2*r,3*r); 
   popMatrix();
 }
 
float T2D(PVector pvect){
   return (float)(Math.atan2(pvect.y, pvect.x));  
}
 
 void rotate2D(PVector v, float theta) {
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}
 
}

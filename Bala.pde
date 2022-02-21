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

class Bala 
{
 PVector posicion;
 PVector velocidad;
 int radios = 5;
 int indicador = 0;
 int tiempoFuera = 24 * 2;
 float alpha;
 PImage img = loadImage("data/Images/laser.png");

 public Bala(PVector pos, PVector vel){
  posicion = pos;
  velocidad = vel;
  alpha = 255;
 } 
 
 void bordes(){
  if (posicion.x < 0){
      posicion.x = width;
    }
    if (posicion.y < 0) {
      posicion.y = height;
    }
    if (posicion.x > width) {
      posicion.x = 0;
    }
    if (posicion.y > height){
      posicion.y = 0;
    } 
 }
 
 boolean verColision(ArrayList<Asteroid> asteroids){
   for(Asteroid a : asteroids){
     PVector dist = PVector.sub(posicion, a.posicion);
     if(dist.mag() < a.radios){ 
      a.disolver(asteroids);      
      return true;
     }
   }
   return false;
 }
 
 boolean actualizar(){
   alpha *= .9;
  indicador++;
  if(indicador>=tiempoFuera){
    return true;
  }
  posicion.add(velocidad);
  return false; 
 }
 
 void hacer(){
  fill(255);
  pushMatrix();
  translate(posicion.x, posicion.y);
  rotate(T2D(velocidad)+PI/2);
  image(img, -radios/2, -2*radios, radios, radios*5); 
  popMatrix();
 }
 
float T2D(PVector pvect){
   return (float)(Math.atan2(pvect.y, pvect.x));  
}

}

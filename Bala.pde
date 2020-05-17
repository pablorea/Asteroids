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

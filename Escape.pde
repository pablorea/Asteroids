class Escape
{
  PVector posicion;
  PVector velocidad;
  float diametro;
  color hugh;
  
  public Escape(PVector pos, PVector vel, color col, int rad)
  {
   posicion = pos;
   velocidad = vel; 
   diametro = (float)(Math.random()*rad);
   hugh = col;
  }
  
  void render()
  {
   noStroke();
   fill(hugh);
   ellipse(posicion.x, posicion.y, diametro, diametro);
    
  }
  
  void actualizar()
  {
   posicion.add(velocidad);
   velocidad.mult(.9); 
  }
}
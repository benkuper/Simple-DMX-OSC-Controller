import java.awt.Rectangle;

class Component extends Rectangle
{
  String name;
 public Component parentComponent;
 public Component(Component parent)
 {
   this.parentComponent = parent;
   this.x= 0;
    this.y = 0;
 }
 
 public Component()
 {
   parentComponent = null;
 }
 
 public PVector getAbsolutePosition()
 {
   //println("Abs pos "+name+" : "+this.x+"/"+this.y);
   PVector p = new PVector(this.x,this.y);
   if(parentComponent != null) p.add(parentComponent.getAbsolutePosition());
   return p;
 }
 
 boolean isInRect()
  {
    PVector p = getRelativeMouse();  return p.x >= 0 && p.x <= 1 && p.y >= 0 && p.y <= 1;
  }
  
  PVector getRelativeMouse()
  {
    
    PVector relPos = new PVector(mouseX,mouseY).sub(getAbsolutePosition());
    return new PVector(relPos.x*1./this.width,relPos.y*1./this.height);
  }
}
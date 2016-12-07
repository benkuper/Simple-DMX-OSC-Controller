import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


void setup() 
{
  size(400,400,P2D);  
  frameRate(30);
  manager = new DMXManager(this);
  
  oscP5 = new OscP5(this,7878);
  
  oscP5.plug(this,"setMasterValue","/master");
  oscP5.plug(this,"setGroupValue","/group");
  oscP5.plug(this,"setChannelValue","/channel");
  
}

void draw() {    
  background(0);
  
  manager.x = 0;
  manager.y = 0;
  manager.width = width-20;
  manager.height = height;
  manager.draw();
  
  manager.sendDMX();
  
  pushStyle();
  if(manager.portOpened) fill(50,255,20);
  else fill(255,50,20);
  ellipse(width-15,15,10,10);
  popStyle();
  }

void setMasterValue(float value)
{
  manager.setMasterValue(value);
}


void setGroupValue(int group, float value)
{
  manager.setGroupValue(group,value);
}

void setChannelValue(int group, int channel, float value)
{
  manager.setChannelValue(group,channel, value);
}
public class DMXChannel extends Component
{
  public int channel;
  DMXSlider slider;
  PApplet parent;
  
  public boolean isSelected;
  DMXGroup parentGroup;
  
  boolean nextKeyStartNewNum;
  
  public DMXChannel(DMXGroup parentGroup, PApplet parent)
  {
    super(parentGroup);
    this.parentGroup = parentGroup;
     name = "channel";
   this.parent = parent;
    slider = new DMXSlider(this,parent);
    
    parent.registerMethod("keyEvent",this);
  }
  
  public void draw()
  {
    pushMatrix();
    parent.translate(this.x,this.y);
    slider.x = 0;
    slider.y = 0;
    slider.width = this.width;
    slider.height = this.height-20;
    slider.opacity = channel > 0?255:100;
    slider.draw();
    
    pushStyle();
    if(isSelected && parentGroup.isSelected) 
    {
      stroke(255,255,0);
      noFill();
      rect(0,0,this.width,this.height);
    }
    
    fill(255);
    textAlign(CENTER);
    text(channel+"",0,this.height-18,width,18);
    
    popStyle();
    popMatrix();
  }
  
   public void setSelected(boolean value)
  {
    isSelected = value;
    nextKeyStartNewNum = true;
  }
  
  
  public void keyEvent(KeyEvent e)
  {
    if(!isSelected || !parentGroup.isSelected) return;
    if(e.getAction() == KeyEvent.PRESS)
    {
      switch(e.getKey())
      {
        case '+':
        channel++;
        break;
        
        case '-':
        channel--;
        break;
      }
      
      if(e.getKey() >= 48 && e.getKey() <= 58)
      {
        int num =(e.getKey()-48);
        String s = channel+""+num;
        int targetChannel = parseInt(s);
        if(nextKeyStartNewNum || targetChannel > 512)
        {
          targetChannel = num;
        }
        nextKeyStartNewNum = false;
        channel = targetChannel;
      }
    }
  }
  
  public JSONObject getData()
  {
    JSONObject data = new JSONObject();
    data.setInt("channel",channel);
    data.setFloat("volume",slider.value);
     
    return data;
  }
  
  public void loadData(JSONObject data)
  {
    channel = data.getInt("channel");
    slider.setValue(data.getFloat("volume"));
  }
    
    
}
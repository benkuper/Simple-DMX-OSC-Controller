public class DMXGroup extends Component
{
  public ArrayList<DMXChannel> channels;
  public DMXSlider groupSlider;
  PApplet parent;
  public final int numChannels = 5;
  
  public int selectedChannel;
  public boolean  isSelected;
  
  public DMXGroup(PApplet parent)
  {
    super();
    name = "group";
    this.parent = parent;
    channels = new ArrayList<DMXChannel>();
    for(int i=0;i<numChannels;i++)
    {
      channels.add(new DMXChannel(this,parent));
    }
    
    parent.registerMethod("keyEvent",this);
    setSelectedChannel(0);
    
    groupSlider = new DMXSlider(this,parent);
    groupSlider.sliderColor = color(100,250,30);
  }
  
   public void draw()
  {
    pushMatrix();
    parent.translate(this.x,this.y);
    
    int gap = 5;
    int margin = 5;
    
    groupSlider.x = margin;
    groupSlider.y = margin;
    groupSlider.width = 30;
    groupSlider.height = height-margin*2;
    groupSlider.draw();
    
    int startX = groupSlider.x + groupSlider.width+gap;
    
    pushStyle();
    noFill();
    stroke(255,50);
    if(isSelected)
    {
      stroke(255,150);
    }
    rect(0,0,this.width,this.height);
    
    popStyle();
   
    int i = 0;
    
    int sliderWidth = ((this.width-margin*2-startX) - gap*(channels.size()-1))/channels.size();
    for(DMXChannel c : channels) 
    {
      c.x = startX+margin+i*(sliderWidth+gap);
      c.y = margin;
      c.width = sliderWidth;
      c.height = (this.height-margin*2);
      c.draw();
      i++;
    }
    popMatrix();
  }
  
  public void setSelected(boolean value)
  {
    isSelected = value;
  }
  
  public void setSelectedChannel(int index)
  {
    channels.get(selectedChannel).setSelected(false);
    selectedChannel = min(max(index,0),channels.size()-1);
    channels.get(selectedChannel).setSelected(true);
    
  }
  
  public void keyEvent(KeyEvent e)
  {
    if(!isSelected) return;
    if(e.getAction() == KeyEvent.PRESS)
    {
      switch(e.getKeyCode())
      {
        case LEFT:
        setSelectedChannel(selectedChannel-1);
        break;
        
        case RIGHT:
        setSelectedChannel(selectedChannel+1);
        break;
      }
    }
  }
  
  public JSONObject getData()
  {
    JSONObject data = new JSONObject();

    data.setFloat("groupVolume",groupSlider.value);
    
    JSONArray channelsData = new JSONArray();
    int i=0;
    for(DMXChannel c : channels)
    {
      channelsData.setJSONObject(i,c.getData());
      i++;
    }
    
    data.setJSONArray("channels",channelsData);
  
    return data;
  }
  
  public void loadData(JSONObject data)
  {
    groupSlider.setValue(data.getFloat("groupVolume"));
    JSONArray channelsData = data.getJSONArray("channels");
    
    for(int i=0;i<channelsData.size() && i<channels.size();i++)
    {
      channels.get(i).loadData(channelsData.getJSONObject(i));
    }
  }
  
}
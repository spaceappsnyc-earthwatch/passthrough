import SimpleOpenNI.*;
SimpleOpenNI  context;

int resolution_x = 1280;
int resolution_y = 800;

int width = resolution_x/2;
int height = resolution_y;


void setup()
{
  size(resolution_x, resolution_y);
  context = new SimpleOpenNI(this);
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  // mirror is by default enabled
  context.setMirror(true);

  // enable depthMap generation 
  context.enableDepth();

  // enable ir generation
  context.enableRGB();
}

void draw()
{
  // update the cam
  context.update();

  background(25);

  // draw irImageMap
  image(context.rgbImage(), 0, 160);
  //filter(THRESHOLD);
  
  // draw irImageMap
  image(context.rgbImage(), context.depthWidth(), 160);
  
}

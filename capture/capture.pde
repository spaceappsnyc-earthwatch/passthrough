import processing.video.*;

Capture cam1;
Capture cam2;

int resolution_x = 1280;
int resolution_y = 800;


void setup() { 
  size(resolution_x, resolution_y);

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam1 = new Capture(this, cameras[0]);
    cam2 = new Capture(this, cameras[0]);
    cam1.start();
    cam2.start();    
  }      
}

void draw() {
  if (cam1.available() == true && cam2.available()) {
    cam1.read();
    cam2.read();
  }
  image(cam1, 0, 0);
  image(cam2, 0.5 * resolution_x / 2, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}



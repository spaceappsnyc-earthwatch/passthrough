
VideoCapture left, right;

int resolution_x = 1280;
int resolution_y = 800;

int width = resolution_x / 2;
int height = resolution_y;
  
boolean testMode = true;

void setup() {
  
  if (testMode) {
    left = new TestVideoCapture(height, width, resolution_x, resolution_y);    
    right = new TestVideoCapture(height, width, resolution_x, resolution_y);
  } else {
    String camera_config = Capture.list()[0];
    left = new VideoCapture(this, height, width, true, camera_config);
    right = new VideoCapture(this, height, width, false, camera_config);
  }  
  left.start();
  right.start();
  
  size(resolution_x, resolution_y);
}

void draw() {
  if (left.available() || right.available()) {
    left.read();
    right.read();
    image(left.transform(), 0, 0);
    image(right.transform(), width, 0);
  }
}



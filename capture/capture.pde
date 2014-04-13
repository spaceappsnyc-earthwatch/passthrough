
VideoCapture left, right;
boolean liveVideo;

int resolution_x = 1280;
int resolution_y = 800;

int width = resolution_x / 2;
int height = resolution_y;
  
boolean testMode = true;

void setup() {
  liveVideo = true;
  
  if (testMode) {
    left = new TestVideoCapture(height, width, resolution_x, resolution_y);    
    right = new TestVideoCapture(height, width, resolution_x, resolution_y);
  } else {
    left = new VideoCapture(this, liveVideo, height, width, true);
    right = new VideoCapture(this, liveVideo, height, width, false);
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



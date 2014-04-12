
VideoCapture left, right;
boolean liveVideo;

int resolution_x = 1280;
int resolution_y = 800;

int width = resolution_x / 2;
int height = resolution_y;
  

void setup() {
  liveVideo = true;
  
  
  left = new VideoCapture(this, liveVideo, height, width);
  right = new VideoCapture(this, liveVideo, height, width);
  
  left.start();
  right.start();
  
  size(resolution_x, resolution_y);
}

void draw() {
  if (left.available() || right.available()) {
    left.read();
    right.read();
  }
  image(left.transform(), 0, 0);
  image(right.transform(), width, 0);

}



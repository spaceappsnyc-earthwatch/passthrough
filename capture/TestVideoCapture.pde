
class TestVideoCapture extends VideoCapture {
  boolean hasBeenCalled;
  TestVideoCapture(PApplet scope, boolean liveVideo, int height, int width, boolean left) {
    hasBeenCalled = false;
  }
  
  void start() {
    // no op  
  }
  
  boolean available() {
    return !hasBeenCalled;
  }
  
  void read() {
    hasBeenCalled = true;
    currentImage = loadImage("data/Oculus_grid_640x800.jpg");
  }
}

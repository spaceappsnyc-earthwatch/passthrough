
class TestVideoCapture extends VideoCapture {
  boolean hasBeenCalled;
  TestVideoCapture(int height, int width, int resolution_height, int resolution_width) {
    super(height, width, resolution_height, resolution_width); 
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

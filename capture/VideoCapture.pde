import processing.video.*;

class VideoCapture {
  Capture cam;
  int height, width;
  int resolution_height, resolution_width;
  int offset_height, offset_width;
  PImage currentImage;

  VideoCapture(int height, int width, int resolution_height, int resolution_width) {
  }

  VideoCapture(PApplet scope, boolean liveVideo, int height, int width, boolean left) {
    this.height = height;
    this.width = width;
    if (liveVideo == false)
      println("recorded video");
    else {
      println("live video");
      /*
      String[] cameras = Capture.list();
       println("Available cameras:");
       for (int i = 0; i < cameras.length; i++) {
       println(cameras[i]);
       }
       */
      String camera_config = Capture.list()[0];
      cam = new Capture(scope, camera_config);

      //println("camera_config: ", camera_config);
      String resolution = split(split(camera_config, "size=")[1], ",")[0];
      resolution_width = int(split(resolution, "x")[0]);
      resolution_height = int(split(resolution, "x")[1]);

      //println("resolution", resolution, "width", width, "height", height);
      if (left) {
        offset_width = -40 + (resolution_width - width) / 2;
        offset_height = (resolution_height - height) / 2;
      } 
      else {
        offset_width = 40 + (resolution_width - width) / 2;
        offset_height = (resolution_height - height) / 2;
      }

      //println("offset_width", offset_width, "offset_height", offset_height);
    }
  }

  void start() {
    cam.start();
  }

  boolean available() {
    return cam.available();
  }

  void read() {
    cam.read();
    currentImage = cam.get(offset_width, offset_height, width, height);
  }

  PImage transform() {
    println("calling transform");
    return currentImage;
  }
}


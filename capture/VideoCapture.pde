import processing.video.*;

class VideoCapture {
  Capture cam;
  int height, width;
  int resolution_height, resolution_width;
  int offset_height, offset_width;
  PImage currentImage;
  int[] barrel_idx;

  VideoCapture(int height, int width, int resolution_height, int resolution_width) {
    this.height = height;
    this.width = width;
    this.resolution_height = resolution_height;
    this.resolution_width = resolution_width;

    barrel_idx = calculate_barrel_idx();
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
    barrel_idx = calculate_barrel_idx();
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

  int[] calculate_barrel_idx() {
    int[] idx = new int[width * height];
        
    float paramA = -0.007715; // affects only the outermost pixels of the image
    float paramB = 0.026731;  // most cases only require b optimization
    float paramC = 0.0;       // most uniform correction
    float paramD = 1.0 - paramA - paramB - paramC; // describes the linear scaling of the image
    
    float d = min(width, height) * 0.5;
    float centerX = (width - 1) * 0.5;
    float centerY = (height - 1) * 0.5;

    int i = 0;
    for (int x = 0; x < width; x++)
      for (int y = 0; y < height; y++) {
        float deltaX = (x - centerX) / d;
        float deltaY = (y - centerY) / d;

        float dstR = sqrt(sq(deltaX) + sq(deltaY));

        float srcR = (paramA * dstR * dstR * dstR 
          + paramB * dstR * dstR 
          + paramC * dstR + paramD) * dstR;
        float factor = abs(dstR / srcR);

        int srcX = floor(centerX + (deltaX * factor * d));
        int srcY = floor(centerY + (deltaY * factor * d));
        
        if (srcX >= 0 && srcY >= 0 && srcX < width && srcY < height) {
          idx[i] = srcY * width + srcX;
        } else {
          idx[i] = -1;
          println("x = ", x, "y = ", y, "srcX=", srcX, "srcY=", srcY);
        }
        i++;
      }
    
    return idx;
  }  

  PImage barrelDistortion(PImage orig) {
    orig.loadPixels();

    PImage img = new PImage(orig.width, orig.height);
    img.loadPixels();

    for (int n = 0; n < width * height; n++)
      if (barrel_idx[n] >= 0)
        img.pixels[barrel_idx[n]] = orig.pixels[n]; 

    img.updatePixels();
    return img;
  }

  PImage transform() {
    return barrelDistortion(currentImage);
  }
}


import processing.video.*;

class VideoCapture {
  Capture cam;
  int height, width;
  int resolution_height, resolution_width;
  int offset_height, offset_width;
  PImage currentImage;
  //int[] barrel_idx;

  VideoCapture(int height, int width, int resolution_height, int resolution_width) {
    this.height = height;
    this.width = width;
    this.resolution_height = resolution_height;
    this.resolution_width = resolution_width;

    //barrel_idx = calculate_barrel_idx();
  }

  VideoCapture(PApplet scope, int height, int width, boolean left, String camera_config) {
    this.height = height;
    this.width = width;
    /*
      String[] cameras = Capture.list();
     println("Available cameras:");
     for (int i = 0; i < cameras.length; i++) {
     println(cameras[i]);
     }
     */
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

      //println("offset_width", offset_width, "offset_height", offset_height);
    }
    //barrel_idx = calculate_barrel_idx();
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
/*
  float[] polarCoordinates(float x, float y) {
    float[] polar = new float[2];
    final float d = min(width, height) * 0.5;
    final float centerX = (width) * 0.5;
    final float centerY = (height) * 0.5;

    float dx = (x - centerX) / d;
    float dy = (y - centerY) / d;

    polar[0] = sqrt(sq(dx) + sq(dy));
    if (polar[0] == 0)
      polar[1] = 0;
    else
      polar[1] = atan2(dy, dx);

    return polar;
  }

  int[] cartesianCoordinates(float[] polar) {
    int[] xy = new int[2];

    final float d = min(width, height) * 0.5;
    final float centerX = (width) * 0.5;
    final float centerY = (height) * 0.5;

    float dx = centerX + d * polar[0] * cos(polar[1]);
    float dy = centerY + d * polar[0] * sin(polar[1]);

    xy[0] = round(dx);
    xy[1] = round(dy);
    return(xy);
  }

  float[] barrel_transform(float[] polar) {
    float r = polar[0];
    float theta = polar[1];

    float[] barrel = new float[2];

    final float paramA = 0; //-0.007715; // affects only the outermost pixels of the image
    final float paramB = 0.026731;  // most cases only require b optimization
    final float paramC = 0.0;       // most uniform correction
    final float paramD = 1.0 - paramA - paramB - paramC; // describes the linear scaling of the image

    barrel[0] = (paramA * r * r * r + paramB * r * r + paramC * r + paramD) * r;
    barrel[1] = polar[1];

    return barrel;
  }

  int[] calculate_barrel_idx() {
    int[] idx = new int[width * height];

    int n = 0;
    for (int x = 0; x < width; x++)
      for (int y = 0; y < height; y++) {
        float[] polar = polarCoordinates(x, y);
        float[] barrel = barrel_transform(polar); 
        int[] xy = cartesianCoordinates(barrel);

        if (n % 1000 == 0) {
          println("(", x, ", ", y, ") -> (", polar[0], ",", polar[1], ") -> (", barrel[0], ",", barrel[1], ") -> (", xy[0], ",", xy[1], ")");
        }
        
        if (xy[0] >= 0 && xy[0] < width && xy[1] >= 0 && xy[1] < height) 
         idx[n] = xy[0] * height + xy[1]; 
        else
          idx[n] = -1;
        n++;
      }

    return idx;
  }  

  PImage barrelDistortion(PImage orig) {
    orig.loadPixels();

    PImage img = new PImage(orig.width, orig.height);
    img.loadPixels();

    for (int n = 0; n < width * height; n++)
      if (barrel_idx[n] >= 0)
        //img.pixels[n] = orig.pixels[barrel_idx[n]];
        img.pixels[barrel_idx[n]] = orig.pixels[n];
      else 
        println("not coloring: ", n);

    img.updatePixels();
    return img;
  }*/
  
  PImage transform() {
    return currentImage;
    //return barrelDistortion(currentImage);
  }
}


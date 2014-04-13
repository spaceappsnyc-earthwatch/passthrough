static class RiftSettings {
  static float HScreenSize = 0.14976;
  static float VScreenSize = 0.0935;
  static float VScreenCenter = VScreenSize * 0.5;
  // static float EyeToScreenDistance;
  static float LensSeparationDistance = 64; // mm
  static float InterpupillaryDistance = 64; // mm
  static float HResolution = 1280;
  static float VResolution =  800;
  // static float DistortionK;


  // second set of data
  static float halfHSS = HScreenSize * 0.5f;
  static float halfLSD = LensSeparationDistance / 1000 * 0.5f;

  static float leftOffset =  (((halfHSS - halfLSD) / halfHSS) * 2.0) - 1.0;
  static float rightOffset = (( halfLSD / halfHSS) * 2.0) - 1.0;
}


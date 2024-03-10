
boolean isHit(PImage img, float threshold, int x, int y) {
  if (x < 0 || img.width < x || y < 0 || img.height < y) {
    return false;
  } 
  color c = img.get(x, y);
  float b = brightness(c);
  return b > threshold;
}

void updateThresholdImage(PImage img, float threshold) {
  for (int i = 0; i < img.pixels.length; i++) {
    if (brightness(img.pixels[i]) > threshold) {
      // thresholdImage.pixels[i] = color(0, 255);
      thresholdImage.pixels[i] = color(255);
    } else {
      // thresholdImage.pixels[i] = color(255, 200);                                    //不透明度
      thresholdImage.pixels[i] = color(0);
    }
  }
  thresholdImage.updatePixels();
}

PImage flipImage(PImage image) {
  PImage flipped = new PImage(image.width, image.height);
  for (int i = 0; i < image.width; i++) {
    for (int j = 0; j < image.height; j++) {
      flipped.set(image.width - 1 - i, j, image.get(i, j));
    }
  }
  return flipped;
}
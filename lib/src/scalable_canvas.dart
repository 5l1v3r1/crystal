part of crystal;

abstract class ScalableCanvas {
  final DpiMonitor dpiMonitor;
  final CanvasElement canvas;
  final int width;
  final int height;
  
  int get canvasWidth => (dpiMonitor.pixelRatio * width).round();
  int get canvasHeight => (dpiMonitor.pixelRatio * height).round();
  
  StreamSubscription _sub;
  
  ScalableCanvas(this.canvas, this.width, this.height, this.dpiMonitor) {
    canvas.style.width = '${width}px';
    canvas.style.height = '${height}px';
    _sub = dpiMonitor.onChange.listen((_) => scale());
  }
  
  void draw();
  
  void destroy() {
    _sub.cancel();
  }
  
  void scale() {
    canvas.width = canvasWidth;
    canvas.height = canvasHeight;
    draw();
  }
}
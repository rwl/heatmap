import 'dart:html';
import 'package:heatmap/heatmap.dart';

main() {
  // create a heatmap instance
  var heatmap = new Heatmap(document.getElementById('heatmapContainer'),
      maxOpacity: 0.6,
      radius: 50,
      blur: .90,
      // backgroundColor with alpha so you can see through it
      backgroundColor: 'rgba(0, 0, 58, 0.96)');
  var heatmapContainer = document.getElementById('heatmapContainerWrapper');

  onMove(e) {
    // we need preventDefault for the touchmove
    e.preventDefault();
    var x = e.layer.x;
    var y = e.layer.y;
    if (e is TouchEvent) {
      x = e.touches[0].page.x;
      y = e.touches[0].page.y;
    }

    heatmap.addData({'x': x, 'y': y, 'value': 1});
  }
  heatmapContainer.onMouseMove.listen(onMove);
  heatmapContainer.onTouchMove.listen(onMove);

  heatmapContainer.onClick.listen((e) {
    var x = e.layer.x;
    var y = e.layer.y;
    heatmap.addData({'x': x, 'y': y, 'value': 1});
  });
}

library heatmap;

import 'dart:html';
import 'dart:js';

/// A heatmap instance has its own internal datastore and renderer where
/// you can manipulate data. As a result the heatmap gets updated (either
/// partially or completely, depending on whether it's necessary).
class Heatmap {
  JsObject _h337, _heatmap;

  Heatmap(

      /// A DOM node where the heatmap canvas should be appended (heatmap will
      /// adapt to the node's size)
      Node container,
      {

      /// A background color string in form of hexcode, color name, or rgb(a).
      String backgroundColor,

      /// An object that represents the gradient (syntax: number string [0,1] :
      /// color string).
      gradient,

      /// The radius each datapoint will have (if not specified on the
      /// datapoint itself).
      num radius,

      /// A global opacity for the whole heatmap. This overrides maxOpacity
      /// and minOpacity if set! Default = 0.6
      num opacity,

      /// The maximal opacity the highest value in the heatmap will have.
      /// (will be overridden if opacity set)
      num maxOpacity,

      /// The minimum opacity the lowest value in the heatmap will have.
      /// (will be overridden if opacity set)
      num minOpacity,

      /// Pass a callback to receive extrema change updates. Useful for DOM
      /// legends.
      Function onExtremaChange,

      /// The blur factor that will be applied to all datapoints. The higher
      /// the blur factor is, the smoother the gradients will be.
      /// Default = 0.85
      num blur,

      /// The property name of your x coordinate in a datapoint. Default = "x"
      String xField,

      /// The property name of your y coordinate in a datapoint. Default = "y"
      String yField,

      /// The property name of your y coordinate in a datapoint.
      /// Default = "value"
      String valueField}) {
    _h337 = context['h337'];
    if (_h337 == null) {
      throw new ArgumentError.notNull('h337');
    }
    var cfg = {};
    if (container != null) cfg['container'] = container;
    if (backgroundColor != null) cfg['backgroundColor'] = backgroundColor;
    if (gradient != null) cfg['gradient'] = gradient;
    if (radius != null) cfg['radius'] = radius;
    if (opacity != null) cfg['opacity'] = opacity;
    if (maxOpacity != null) cfg['maxOpacity'] = maxOpacity;
    if (minOpacity != null) cfg['minOpacity'] = minOpacity;
    if (onExtremaChange != null) cfg['onExtremaChange'] = onExtremaChange;
    if (blur != null) cfg['blur'] = blur;
    if (xField != null) cfg['xField'] = xField;
    if (yField != null) cfg['yField'] = yField;
    var _cfg = new JsObject.jsify(cfg);
    var args = [_cfg];
    _heatmap = _h337.callMethod('create', args);
    if (_heatmap == null) {
      throw new ArgumentError.notNull('heatmap');
    }
  }

  /// Use this functionality only for adding datapoints on the fly, not for
  /// data initialization! [addData] adds a single or multiple datapoints to
  /// the heatmaps' datastore. [data] may be a [List] or a [Map].
  void addData(data) {
    var _data = (data is Map) ? new JsObject.jsify(data) : data;
    _heatmap.callMethod('addData', [_data]);
  }

  /// Initializes a heatmap instance with a dataset. "min", "max", and "data"
  /// keys are required. [setData] removes all previously existing points from
  /// the heatmap instance and re-initializes the datastore.
  void setData(Map data) {
    _heatmap.callMethod('setData', [new JsObject.jsify(data)]);
  }

  /// Changes the upper bound of your dataset and triggers a complete
  /// rerendering.
  void setDataMax(num max) {
    _heatmap.callMethod('setDataMax', [max]);
  }

  /// Changes the lower bound of your dataset and triggers a complete
  /// rerendering.
  void setDataMin(num min) {
    _heatmap.callMethod('setDataMin', [min]);
  }

  /// Reconfigures a heatmap instance after it has been initialized.
  /// Triggers a complete rerendering.
  void configure(
      {String backgroundColor,
      gradient,
      num radius,
      num opacity,
      num maxOpacity,
      num minOpacity,
      Function onExtremaChange,
      num blur,
      String xField,
      String yField,
      String valueField}) {
    var cfg = {};
    if (backgroundColor != null) cfg['backgroundColor'] = backgroundColor;
    if (gradient != null) cfg['gradient'] = gradient;
    if (radius != null) cfg['radius'] = radius;
    if (opacity != null) cfg['opacity'] = opacity;
    if (maxOpacity != null) cfg['maxOpacity'] = maxOpacity;
    if (minOpacity != null) cfg['minOpacity'] = minOpacity;
    if (onExtremaChange != null) cfg['onExtremaChange'] = onExtremaChange;
    if (blur != null) cfg['blur'] = blur;
    if (xField != null) cfg['xField'] = xField;
    if (yField != null) cfg['yField'] = yField;
    var _cfg = new JsObject.jsify(cfg);
    _heatmap.callMethod('configure', [_cfg]);
  }

  /// Returns value at datapoint position.
  ///
  /// Note: The returned value is an interpolated value based on the gradient
  /// blending if point is not in store.
  num getValueAt(num x, num y) {
    var p = new JsObject.jsify({'x': x, 'y': y});
    return _heatmap.callMethod('getValueAt', [p]);
  }

  /// Returns a persistable and reimportable (with [setData]) [Map].
  Map getData() => _heatmap.callMethod('getData');

  /// Returns dataURL string.
  ///
  /// The returned value is the base64 encoded dataURL of the heatmap
  /// instance.
  String getDataURL() => _heatmap.callMethod('getDataURL');

  /// Repaints the whole heatmap canvas.
  void repaint() {
    _heatmap.callMethod('repaint');
  }
}

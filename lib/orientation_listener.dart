/// A lightweight Flutter package for listening to device orientation changes
/// (portrait/landscape) without needing a [BuildContext].
library;

import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart';

/// Signature for callbacks that receive an [Orientation] update.
typedef OrientationCallback = void Function(Orientation orientation);

/// Listens for device orientation changes and notifies a callback whenever
/// the orientation switches between [Orientation.portrait] and
/// [Orientation.landscape].
///
/// Unlike [OrientationBuilder], this controller does not require a
/// [BuildContext] and can be used from anywhere in your app (services,
/// controllers, blocs, etc.).
///
/// Example:
/// ```dart
/// final controller = OrientationController();
///
/// controller.listen((orientation) {
///   debugPrint('Orientation changed to: $orientation');
/// });
///
/// // When you're done listening:
/// controller.dispose();
/// ```
class OrientationController with WidgetsBindingObserver {
  OrientationCallback? _callback;
  Orientation? _lastOrientation;
  bool _isListening = false;

  /// The most recently observed orientation, or `null` if [listen] has not
  /// been called yet.
  Orientation? get currentOrientation => _lastOrientation;

  /// Whether this controller is currently observing orientation changes.
  bool get isListening => _isListening;

  /// Starts listening for orientation changes.
  ///
  /// The [callback] is invoked immediately with the current orientation and
  /// again every time the orientation changes.
  ///
  /// Calling [listen] more than once replaces the previously registered
  /// callback. Make sure [WidgetsFlutterBinding.ensureInitialized] has been
  /// called (e.g. from `main()`), otherwise [WidgetsBinding.instance] will
  /// not be available.
  /// //
  void listen(OrientationCallback callback) {
    _callback = callback;

    if (!_isListening) {
      WidgetsBinding.instance.addObserver(this);
      _isListening = true;
    }

    final current = _readOrientation();
    _lastOrientation = current;
    callback(current);
  }

  @override
  void didChangeMetrics() {
    final current = _readOrientation();
    if (current != _lastOrientation) {
      _lastOrientation = current;
      _callback?.call(current);
    }
  }

  Orientation _readOrientation() {
    final view = PlatformDispatcher.instance.implicitView ??
        PlatformDispatcher.instance.views.first;
    final size = view.physicalSize;
    return size.width > size.height
        ? Orientation.landscape
        : Orientation.portrait;
  }

  /// Stops listening for orientation changes and releases resources.
  ///
  /// After calling [dispose] the controller can no longer be used. Create
  /// a new instance if you need to listen again.
  void dispose() {
    if (_isListening) {
      WidgetsBinding.instance.removeObserver(this);
      _isListening = false;
    }
    _callback = null;
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orientation_listener/orientation_listener.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OrientationController', () {
    test('listen invokes the callback immediately with current orientation',
        () {
      final controller = OrientationController();
      addTearDown(controller.dispose);

      Orientation? received;
      controller.listen((orientation) => received = orientation);

      expect(received, isNotNull);
      expect(received, controller.currentOrientation);
    });

    test('isListening reflects controller state', () {
      final controller = OrientationController();

      expect(controller.isListening, isFalse);

      controller.listen((_) {});
      expect(controller.isListening, isTrue);

      controller.dispose();
      expect(controller.isListening, isFalse);
    });

    test('dispose clears the callback and stops listening', () {
      final controller = OrientationController();
      var calls = 0;

      controller.listen((_) => calls++);
      final initialCalls = calls;

      controller.dispose();

      // Manually invoke didChangeMetrics — after dispose nothing should
      // happen because the callback has been cleared.
      controller.didChangeMetrics();
      expect(calls, initialCalls);
    });
  });
}

# orientation_listener

[![pub package](https://img.shields.io/pub/v/orientation_listener.svg)](https://pub.dev/packages/orientation_listener)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A lightweight Flutter package for listening to device orientation changes
(portrait/landscape) **without** needing a `BuildContext`.

Use it from anywhere in your app — services, controllers, blocs, repositories —
not just inside widgets.

## Features

- Get notified whenever the device orientation flips between portrait and landscape.
- No `BuildContext` required.
- Tiny — a single class, no native code, no platform channels.
- Works on all Flutter platforms (Android, iOS, Web, macOS, Windows, Linux).

## Getting started

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  orientation_listener: ^0.1.0
```

Then run:

```sh
flutter pub get
```

Import it where you need it:

```dart
import 'package:orientation_listener/orientation_listener.dart';
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:orientation_listener/orientation_listener.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final OrientationController _controller = OrientationController();

  @override
  void initState() {
    super.initState();
    _controller.listen((orientation) {
      debugPrint('Orientation changed: $orientation');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
```

The callback is invoked **immediately** with the current orientation, and again
each time the orientation actually changes.

### API

| Member | Description |
| --- | --- |
| `listen(callback)` | Start listening. The callback fires once immediately with the current orientation and then on every change. |
| `currentOrientation` | The most recently observed orientation, or `null` before `listen` is called. |
| `isListening` | Whether the controller is currently observing changes. |
| `dispose()` | Stop listening and release resources. Always call this when you're done. |

## Example

A runnable example lives in the [`example/`](example/) directory:

```sh
cd example
flutter run
```

## Contributing

Issues and pull requests are welcome at
<https://github.com/Elshan2022/orientation_listener>.

## License

[MIT](LICENSE) © Elshan Huseynov

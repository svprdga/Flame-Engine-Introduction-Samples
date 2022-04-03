import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Extremely basic 2D movement
class Basic2DMovement extends FlameGame with KeyboardEvents {
  static const _size = 100.0;

  final paint = Paint()..color = Colors.lightGreen;

  double _x = 0.0;
  double _y = 0.0;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = Rect.fromLTWH(_x, _y, _size, _size);
    canvas.drawRect(rect, paint);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) && isKeyDown) {
      _x -= 10.0;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        isKeyDown) {
      _x += 10.0;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && isKeyDown) {
      _y -= 10.0;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) &&
        isKeyDown) {
      _y += 10.0;
    }

    return KeyEventResult.handled;
  }
}

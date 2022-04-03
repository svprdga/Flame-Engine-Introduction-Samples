import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Advanced2DMovement extends FlameGame with KeyboardEvents {
  static const _size = 100.0;

  final paint = Paint()..color = Colors.lightGreen;

  static const double _speed = 100.0;
  static const double _friction = 0.9;

  Vector2 _position = Vector2.zero();
  Vector2 _movementVector = Vector2.zero();

  bool _isPressingLeft = false;
  bool _isPressingRight = false;
  bool _isPressingUp = false;
  bool _isPressingDown = false;

  @override
  void update(double delta) {
    super.update(delta);

    final Vector2 inputVector = Vector2.zero();

    if (_isPressingLeft) {
      inputVector.x -= 1.0;
    } else if (_isPressingRight) {
      inputVector.x += 1.0;
    }

    if (_isPressingUp) {
      inputVector.y -= 1.0;
    } else if (_isPressingDown) {
      inputVector.y += 1.0;
    }

    if (!inputVector.isZero()) {
      _movementVector = inputVector;

      // Normalize movement vector and apply the speed
      _movementVector.normalize();
      _movementVector *= _speed * delta;
    } else {
      _movementVector *= _friction;
    }

    // Apply movement vector to the current position
    _position += _movementVector;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = Rect.fromLTWH(_position.x, _position.y, _size, _size);
    canvas.drawRect(rect, paint);
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
        event is RawKeyDownEvent) {
      _isPressingLeft = true;
    } else if (event is RawKeyUpEvent &&
        event.data.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _isPressingLeft = false;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        event is RawKeyDownEvent) {
      _isPressingRight = true;
    } else if (event is RawKeyUpEvent &&
        event.data.logicalKey == LogicalKeyboardKey.arrowRight) {
      _isPressingRight = false;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) &&
        event is RawKeyDownEvent) {
      _isPressingUp = true;
    } else if (event is RawKeyUpEvent &&
        event.data.logicalKey == LogicalKeyboardKey.arrowUp) {
      _isPressingUp = false;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown) &&
        event is RawKeyDownEvent) {
      _isPressingDown = true;
    } else if (event is RawKeyUpEvent &&
        event.data.logicalKey == LogicalKeyboardKey.arrowDown) {
      _isPressingDown = false;
    }

    return KeyEventResult.handled;
  }
}

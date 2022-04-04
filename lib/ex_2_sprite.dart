import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends SpriteComponent with KeyboardHandler {
  static const _size = 128.0;

  static const double _speed = 100.0;
  static const double _friction = 0.9;

  Vector2 _movementVector = Vector2.zero();

  bool _isPressingLeft = false;
  bool _isPressingRight = false;
  bool _isPressingUp = false;
  bool _isPressingDown = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(_size, _size);
    sprite = await Sprite.load('flutter.png');
  }

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
    position += _movementVector;
  }

  @override
  bool onKeyEvent(
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

    return true;
  }
}

class SpriteExample extends FlameGame with HasKeyboardHandlerComponents {
  late final Player _player;

  @override
  Color backgroundColor() => const Color(0xFF353935);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _player = Player();
    await add(_player);
  }
}

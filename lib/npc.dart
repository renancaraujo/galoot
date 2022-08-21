import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:galoot/main.dart';
import 'package:galoot/textprompt.dart';

class Npc extends SpriteAnimationComponent with HasGameRef<GalootGame> {
  final Color color;
  Npc(this.color, {super.position}) : super(size: Vector2(16, 16));
  void converse() {}
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(size: Vector2(14, 14), position: Vector2(1, 1))
      ..collisionType = CollisionType.passive);
  }
}

class Fish extends Npc with CollisionCallbacks {
  final Sprite sprite;
  Fish(this.sprite, super.color, {super.position});

  Future<void> onLoad() async {
    super.onLoad();
    animation = SpriteAnimation.spriteList(
      [
        sprite,
      ],
      stepTime: 0.3,
    );
  }

  @override
  void converse() {
    gameRef.add(
      TextPrompt(
        "You found a fish!",
        color: color,
        top: false,
      ),
    );
    gameRef.globs['has_fish'] = true;
    removeFromParent();
  }
}

class Trashcan extends Npc with CollisionCallbacks {
  final Sprite sprite;
  Trashcan(this.sprite, super.color, {super.position});

  Future<void> onLoad() async {
    super.onLoad();
    animation = SpriteAnimation.spriteList(
      [
        sprite,
      ],
      stepTime: 0.3,
    );
  }

  @override
  void converse() {
    if (gameRef.globs['has_cap'] == false) {
      gameRef.add(
        TextPrompt(
          "You found a cap!",
          color: color,
          top: false,
        ),
      );
      gameRef.globs['has_cap'] = true;
    }
  }
}

class Bone extends Npc with CollisionCallbacks {
  final Sprite sprite;
  Bone(this.sprite, super.color, {super.position});

  Future<void> onLoad() async {
    super.onLoad();
    animation = SpriteAnimation.spriteList(
      [
        sprite,
      ],
      stepTime: 0.3,
    );
  }

  @override
  void converse() {
    gameRef.add(
      TextPrompt(
        "You found a bone!",
        color: color,
        top: false,
      ),
    );
    gameRef.globs['has_bone'] = true;
    removeFromParent();
  }
}

class GuardDog extends Npc with CollisionCallbacks {
  final Sprite sprite;
  GuardDog(this.sprite, super.color, {super.position});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    animation = SpriteAnimation.spriteList(
      [
        sprite,
      ],
      stepTime: 0.3,
    );
  }

  @override
  void converse() {
    if (gameRef.globs['has_bone'] == false) {
      gameRef.add(TextPrompt(
        "Voof. Only big dogs can pass here, scram!",
        color: color,
        top: true,
      ));
      // conv1
    } else {
      gameRef.add(TextPrompt(
        "Voof!! What's that you have there?!",
        color: color,
        top: false,
      ));
      gameRef.player.move(gameRef.player.position..add(Vector2(-16, 0)));
      add(MoveByEffect(
        Vector2(0, -16 * 40),
        EffectController(duration: 4.8),
      ));
      gameRef.globs['dog_moved'] = true;
    }
  }
}

class Grandpa extends Npc with CollisionCallbacks {
  final Sprite sprite;
  Grandpa(this.sprite, super.color, {super.position});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    animation = SpriteAnimation.spriteList(
      [
        sprite,
      ],
      stepTime: 0.3,
    );
    size.add(Vector2(2, 2));
  }

  @override
  void converse() {
    if (gameRef.globs['has_bone'] == true) {
      gameRef.add(TextPrompt(
        "Good morning",
        color: Colors.white,
        top: true,
      ));
      // conv1
    } else {
      gameRef.add(TextPrompt(
        "What's that you have there?!",
        color: color,
        top: false,
      ));
    }
  }
}

class Lumberjack extends Npc with CollisionCallbacks {
  final Sprite sprite;

  Lumberjack(this.sprite, super.color, {super.position});

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(size: Vector2(46, 46), position: Vector2(1, 1))
      ..collisionType = CollisionType.passive);
    animation = SpriteAnimation.spriteList(
      [
        sprite,
      ],
      stepTime: 0.3,
    );
    size.add(Vector2(32, 32));
  }

  @override
  void converse() {
    if (gameRef.globs['has_fish'] == true) {
      gameRef.add(TextPrompt(
        "Good morning",
        color: color,
        top: true,
      ));
      // conv1
    } else {
      gameRef.add(TextPrompt(
        "I want fish",
        color: Colors.white,
        top: false,
      ));
    }
  }
}

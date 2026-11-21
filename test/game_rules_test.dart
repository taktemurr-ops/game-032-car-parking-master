import 'package:flutter_test/flutter_test.dart';
import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/level_plan.dart';
import 'package:game_032_car_parking_master/game/park_engine.dart';
import 'package:game_032_car_parking_master/game/rules.dart';

void main() {
  final rules = ParkingRules();
  final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: rules.optionalMechanics);

  test('holding ahead drives forward; the gear button switches to reverse', () {
    final s = ParkSim(rules.build(planner.spec(1)).puzzle);
    final y0 = s.y;
    for (var i = 0; i < 30; i++) {
      s.tick(ArcadeInput(down: true, x: s.x, y: s.y - 300));
    }
    expect(s.y, lessThan(y0));
    s.tick(ArcadeInput.idle);
    s.tick(ArcadeInput(down: true, tap: true, x: gearRect.x + 10, y: gearRect.y + 10));
    expect(s.reverse, isTrue);
  });

  test('courses: corridor from the start to the bay, nothing blocks the route', () {
    for (var n = 1; n < 400; n += 13) {
      final s = ParkSim(rules.build(planner.spec(n)).puzzle);
      final c = s.course;
      expect(c.path.length, greaterThanOrEqualTo(3));
      for (final cell in c.path) {
        final (x, y) = cellCenter(cell);
        for (final o in c.obstacles) {
          final inside = x > o.x && x < o.x + o.w && y > o.y && y < o.y + o.h;
          expect(inside, isFalse, reason: 'level $n');
        }
      }
    }
  });

  test('driving into a wall costs a life and resets the car', () {
    final s = ParkSim(rules.build(planner.spec(1)).puzzle);
    final lives = s.lives;
    for (var i = 0; i < 400 && s.lives == lives; i++) {
      s.tick(ArcadeInput(down: true, x: 0, y: s.y));
    }
    expect(s.lives, lives - 1);
    expect(s.v, 0);
  });

  test('autopilot parks the car and the stage counts', () {
    final s = ParkSim(rules.build(planner.spec(1)).puzzle);
    final r = runBot(s, rules.bot, 60 * 60 * 3);
    expect(r.won, isTrue);
    expect(s.parks, greaterThanOrEqualTo(1));
  });
}

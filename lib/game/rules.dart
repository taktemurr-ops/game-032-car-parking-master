import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/missions.dart';
import 'package:studio_core/core/stats.dart';
import 'park_rules.dart';

class ParkingRules extends ParkRules {
  ParkingRules()
      : super('game-032-car-parking-master', const [
          GameStat('cars_parked', 'Park edilen araç', 'Cars parked', scale: 50),
          GameStat('perfect_parks', 'Hızlı park', 'Quick parks', scale: 20),
        ], const [
          MissionTemplate('cars_parked', 'cars_parked', [16, 33, 50]),
          MissionTemplate('perfect_parks', 'perfect_parks', [6, 13, 20]),
        ]);
}

ArcadeRules createRules() => ParkingRules();

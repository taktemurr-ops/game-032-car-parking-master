import 'package:flutter/material.dart';

import '../app/arcade_stage.dart';
import '../app/game_api.dart';
import '../core/game_rules.dart';
import 'park_engine.dart';
import 'drive_view.dart';
import 'rules.dart';

const _theme = DriveTheme(Color(0xFF52796F), Color(0xFF5C677D), Color(0xFFFFFFFF), Color(0xFF06D6A0));



final gameConfig = GameConfig(
  gameId: 'game-032-car-parking-master',
  title: const ['Park Ustası', 'Car Parking Master', 'Car Parking Master', 'Car Parking Master', 'Car Parking Master'],
  tagline: const ['Direksiyonu çevir, geri vites at, kusursuz park et!', 'Steer, reverse and park it perfectly!', 'Steer, reverse and park it perfectly!', 'Steer, reverse and park it perfectly!', 'Steer, reverse and park it perfectly!'],
  seedColor: const Color(0xFF06D6A0),
  icon: Icons.local_parking,
  rules: ParkingRules(),
  buildPlay: (ctx) => ArcadeStage(
    ctx: ctx,
    create: () => ParkSim((ctx.generated as GeneratedLevel<ParkLevel>).puzzle),
    paint: (c, s, p, t) => paintPark(c, s, p, t, ctx.lang == 'tr', _theme),
    sound: parkSound,
    boosterIcon: Icons.visibility_off,
    boosterLabel: (l) => l == 'tr' ? 'Hayalet + süre' : 'Ghost + time',
    howTo: const [
      'Aracın gitmesini istediğin yere dokunup basılı tut; bırakınca durur. Sol alttaki D/R düğmesi geri vitestir. Sarı P alanına düz park et.',
      'Hold where the car should drive; release to stop. The D/R button switches to reverse. Park straight in the yellow P bay.',
      'Hold where the car should drive; release to stop. The D/R button switches to reverse. Park straight in the yellow P bay.',
      'Hold where the car should drive; release to stop. The D/R button switches to reverse. Park straight in the yellow P bay.',
      'Hold where the car should drive; release to stop. The D/R button switches to reverse. Park straight in the yellow P bay.',
    ],
  ),
  tutorial: const [
    TutorialStep(Icons.touch_app, [
      'Aracın gitmesini istediğin yere dokunup basılı tut, bırakınca fren yapar.',
      'Hold where the car should go; release to brake.',
      'Halte, wohin das Auto fahren soll.',
      'Mantén donde debe ir el coche.',
      'Maintenez là où la voiture doit aller.',
    ]),
    TutorialStep(Icons.swap_vert, [
      'Sol alttaki D/R düğmesi ileri ve geri vites arasında geçiş yapar.',
      'The D/R button switches between drive and reverse.',
      'D/R schaltet zwischen vorwärts und rückwärts.',
      'D/R cambia entre marcha y reversa.',
      'D/R alterne marche avant et arrière.',
    ]),
    TutorialStep(Icons.local_parking, [
      'Sarı P alanına düz gir ve dur. Çarpmak bir can götürür.',
      'Enter the yellow P bay straight and stop. Crashing costs a life.',
      'Gerade in die gelbe Bucht fahren.',
      'Entra recto en la plaza amarilla.',
      'Entrez droit dans la place jaune.',
    ]),
  ],
);

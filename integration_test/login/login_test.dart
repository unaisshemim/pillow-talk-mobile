import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:pillowtalk/app.dart';
import 'package:pillowtalk/common/services/hive_service.dart';
import 'package:pillowtalk/common/services/notification_service.dart';

void main() {
  patrolTest(
    'real app test',
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    ($) async {
      // Do all the necessary setup here (DI, services, etc.)
      await PillowTalkNotificationService.initialize();
      final hiveService = HiveService();
      await hiveService.init();
      await $.pumpWidgetAndSettle(
        ProviderScope(child: MainApp()),
      ); // Your's app main widget

      await $('Skip').tap();

      await $(TextFormField).enterText('62821270701');

      $('Send Verification Code').tap();

      await Future.delayed(Duration(seconds: 2));
      await $(TextFormField).at(0).enterText('0');
      await $(TextFormField).at(1).enterText('0');
      await $(TextFormField).at(2).enterText('0');
      await $(TextFormField).at(3).enterText('0');

      await Future.delayed(Duration(seconds: 2));

      // Start testing your app here
    },
  );
}

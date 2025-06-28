import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/services/local_notification_services.dart';
import 'core/services/push_notification_servirces.dart';
import 'firebase_options.dart';
import 'i_track_supply.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Future.wait([
    LocalNotificationServices.init(),
    PushNotificationServirces.init(),
  ]);
  runApp(const ITrackSupply());
}

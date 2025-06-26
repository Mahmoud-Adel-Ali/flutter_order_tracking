import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/services/local_notification_services.dart';
import 'firebase_options.dart';
import 'i_track_supply.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    LocalNotificationServices.init(),
  ]);
  runApp(const ITrackSupply());
}

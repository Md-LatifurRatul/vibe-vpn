import 'package:flutter/material.dart';
import 'package:vibe_vpn/app.dart';
import 'package:vibe_vpn/data/local/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initHive();
  runApp(const VibeVpnApp());
}
